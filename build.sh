#! /bin/bash

CNAME="maggi.cc"
INDIR="./_input"
OUTDIR="./_output"
STATIC="./_static"
PUBLICATIONS="./_data/publications"
NODE_MODULES="./node_modules"
SRC="./_src"
METADATA="./metadata.yml" # TODO parse static dir from metadata
PANOPTS="\
  --smart \
  --metadata=current_year:`date +%Y` \
  --standalone \
  --template=_templates/site.html"

rm -rf $OUTDIR/*

# Sections processing
echo "[+] Processing sections..."
find $INDIR -type f -mindepth 2 -name 'index.md' | \
  while read f
  do
    parent=$(basename $(dirname ${f}))
    DST=$OUTDIR/${parent}
    mkdir -p $DST

    if grep -q 'bibliography' ${f}
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

    if grep -q 'bibliography' ${f}
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
mkdir $OUTDIR/s/{css,js}
browserify _src/js/app.js | uglifyjs -o $OUTDIR/s/js/app.js
cp -R $NODE_MODULES/lato-font $OUTDIR/s/
node-sass --output-style compressed --include-path $NODE_MODULES _src/css/app.scss > $OUTDIR/s/css/app.css

# add CNAME
echo $CNAME > $OUTDIR/CNAME
