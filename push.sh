COMMIT_MSG=`git log --max-count 1 --pretty="%h %s"`
cd _output
git add ./
git commit -m "up: $COMMIT_MSG"
git push
