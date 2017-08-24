#! /bin/bash

CNAME="maggi.cc"
INDIR="./_input"
OUTDIR="./_output"
STATIC="./_static"
DATA_DIR="./"
PUBLICATIONS="./_data/publications"
NODE_MODULES="./node_modules"
SRC="./_src"
METADATA="./metadata.yml" # TODO parse static dir from metadata
default_template="site"
PANOPTS="\
  --smart \
  --metadata=current_year:`date +%Y` \
  --standalone \
  --template=${default_template} \
  --data-dir=${DATA_DIR}"

rm -rf $OUTDIR/*

# Sections processing
echo "[+] Processing sections..."
find $INDIR -type f -mindepth 2 -name 'index.md' | \
  while read f
  do
    parent=$(dirname $(realpath --relative-to ${INDIR} ${f}))
    DST=$OUTDIR/${parent}
    mkdir -p $DST

    if grep -qE '^bibliography\:' ${f}
    then
      OPTS="$PANOPTS \
        --filter pandoc-citeproc"
    else
      OPTS=$PANOPTS
    fi

    echo "[/${parent}] Processing..."
    pandoc \
      $OPTS \
      $METADATA \
      ${f} \
      -o $DST/index.html

    if grep -qE '^bibliography\:' ${f}
    then
      sed -E 's/(https\:\/\/github\.com\/phretor\/publications\/[^.]+\.pdf)/ [<a href="\1" class="download-pdf">PDF<\/a>]/g' \
        $DST/index.html > $DST/.index.html
      mv $DST/.index.html $DST/index.html
    fi
  done

# Home page
echo "[+] Processing index ..."
OPTS="$PANOPTS --filter pandoc-citeproc"
pandoc \
  $OPTS \
  $METADATA \
  $INDIR/index.md \
  -o $OUTDIR/index.html
sed -E 's/(https\:\/\/github\.com\/phretor\/publications\/[^.]+\.pdf)/ [<a href="\1" class="download-pdf">PDF<\/a>]/g' \
  $OUTDIR/index.html > $OUTDIR/.index.html
mv $OUTDIR/.index.html $OUTDIR/index.html

# Static files
echo "[+] Processing static files..."
cp -R $STATIC $OUTDIR/s

# Build frontend kit
echo "[+] Building frontend files..."
mkdir $OUTDIR/s/{css,js,fonts}
cp -R $NODE_MODULES/lato-font/fonts/* $OUTDIR/s/fonts/
cp -R $NODE_MODULES/font-awesome/fonts/* $OUTDIR/s/fonts/
browserify _src/js/app.js | uglifyjs -o $OUTDIR/s/js/app.js
node-sass --output-style compressed --include-path $NODE_MODULES _src/css/app.scss > $OUTDIR/s/css/app.css

# add CNAME
echo $CNAME > $OUTDIR/CNAME
