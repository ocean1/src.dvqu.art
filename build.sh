#! /bin/bash

CNAME="dvqu.art"
INDIR="./_input"
OUTDIR="./_output"
STATIC="./_static"
DATA_DIR="./"
PUBLICATIONS="./_data/publications"
NODE_MODULES="./node_modules"
SRC="./_src"

DEFAULT_TEMPLATE="./templates/site.html"
POST_TEMPLATE="./templates/post.md"

PANOPTS="\
  --smart \
  --metadata=current_year:'`date +%Y`' \
  --metadata=updated_on:'`date +%Y-%m-%dT%H:%M:%S%z`'"

METADATA="./metadata.yml"

#rm -rf $OUTDIR/*

replace_bib_link()
{
    DST=$1
    f=$2

    if grep -qE '^bibliography\:' ${f}
    then  # TODO find a better alternative to this ugly replacement
      sed -E 's/(https\:\/\/github\.com\/phretor\/publications\/[^.]+\.pdf)/ [<a href="\1" class="download-pdf">PDF<\/a>]/g' \
        "$DST/index.html" > "$DST/.index.html"
      mv "$DST/.index.html" "$DST/index.html"
    fi
}

rm -f /dev/shm/publications.bib && cat _data/publications/*.bib > /dev/shm/publications.bib

# Sections processing
process_sections(){
echo "[+] Processing sections..."

find $INDIR -mindepth 2 -type f ! -name '.*' ! -path '*/diary/*' | \
  while read f
  do
    parent=$(dirname $(realpath --relative-to ${INDIR} ${f}))
    DST=$OUTDIR/${parent}
    mkdir -p $DST
    FN=$(basename "${f}" .md)

    echo "$f" | grep -qE "\.md$" && {
        if grep -qE '^bibliography\:' ${f}
        then
          EXTRA_OPTS="--filter pandoc-citeproc"
        else
          EXTRA_OPTS=""
        fi

        echo "[/${parent}] Processing..."
        pandoc \
          $PANOPTS \
          $EXTRA_OPTS \
          --standalone \
          --filter pandoc-mustache \
          --template=${DEFAULT_TEMPLATE} \
          $METADATA \
          ${f} \
          -o "$DST/$FN.html"

        replace_bib_link "$DST" "$f"
    } || {
        echo "${f} -> $DST/$(basename ${f})"
        rsync -r --delete "${f}" $DST/
    }
  done
}

# Diary
process_diary()
{
echo "[+] Processing diary..."
rm $INDIR/diary/index.md
find $INDIR -type f -mindepth 3 ! -name '.*' -path '*/diary/*' | sort -r | \
    while read f
    do
        parent=$(dirname $(realpath --relative-to ${INDIR} ${f}))
        DST=$OUTDIR/${parent}
        mkdir -p $DST
        FN=$(basename "${f}" .md)

        echo "$f" | grep -qE "\.md$" && {
            echo "[/${parent}] Processing..."
            pandoc \
              $PANOPTS \
              --variable=href:/$parent \
              --variable=blurb:$(echo $parent | sed -E 's/[^a-z0-9-]/-/g' | sed -E 's/[-]{1,}/-/g') \
              --template=$POST_TEMPLATE \
              $METADATA \
              -o - \
              ${f} >> $INDIR/diary/index.md

            if grep -qE '^bibliography\:' ${f}
            then
              EXTRA_OPTS="--filter pandoc-citeproc"
            else
              EXTRA_OPTS=""
            fi

            pandoc \
              $PANOPTS \
              $EXTRA_OPTS \
              --standalone \
              --template=$DEFAULT_TEMPLATE \
              $METADATA \
              ${f} \
              -o "$DST/$FN.html"

            replace_bib_link "$DST" "$f"
        } || {
            echo "${f} -> $DST/$(basename ${f})"
            rsync -r --delete "${f}" $DST/
        }
    done

echo "[/diary] Processing..."
pandoc \
  $PANOPTS \
  --template=${DEFAULT_TEMPLATE} \
  --standalone \
  -o $OUTDIR/diary/index.html \
  $METADATA \
  $INDIR/diary/metadata.yml \
  $INDIR/diary/index.md
}

# Home page
process_index()
{
echo "[+] Processing index ..."
pandoc \
  $PANOPTS \
  --filter pandoc-mustache \
  --filter pandoc-citeproc \
  --template=${DEFAULT_TEMPLATE} \
  $METADATA \
  -o $OUTDIR/index.html \
  $INDIR/index.md

sed -E 's/(https\:\/\/github\.com\/phretor\/publications\/[^.]+\.pdf)/ [<a href="\1" class="download-pdf">PDF<\/a>]/g' \
  $OUTDIR/index.html > $OUTDIR/.index.html
mv $OUTDIR/.index.html $OUTDIR/index.html
} 


process_sections
process_index

# Static files
echo "[+] Processing static files..."
rsync -r --delete $STATIC/ $OUTDIR/s/
rsync -r --delete _data/pdfs $OUTDIR/s/

# Build frontend kit
echo "[+] Building frontend files..."
mkdir -p $OUTDIR/s/{css,js}
#cp -R $NODE_MODULES/lato-font/fonts/* $OUTDIR/s/fonts/
#cp -R $NODE_MODULES/font-awesome/fonts/* $OUTDIR/s/fonts/
node node_modules/browserify/bin/cmd.js _src/js/app.js | node_modules/uglify-js/bin/uglifyjs -o $OUTDIR/s/js/app.js
node_modules/clean-css-cli/bin/cleancss -o $OUTDIR/s/css/app.css _src/css/*.css

# add favicon
rsync -r --delete _data/favicon.ico $OUTDIR/

# add CNAME
echo $CNAME > $OUTDIR/CNAME

# add .nojekyll
touch $OUTDIR/.nojekyll
