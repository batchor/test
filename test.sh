set -ex

rm -rf .git
git init

REMOTE=git@github.com:batchor/test

git remote add origin $REMOTE

git add test.sh && git commit -m 'test' && git push -u origin main -f

rm -rf repo1 repo2

git clone $REMOTE repo1
git clone $REMOTE repo2


cd repo1
echo "This is a test commit-abc" >> test.txt
git add test.txt && git commit -m 'repo1: 1'
git push

echo "This is a test commit-def" >> test.txt
git add test.txt && git commit -m 'repo1: 2'
git push


cd ../repo2
echo "This is a test commit-123" >> test1.txt
git add . && git commit -m 'repo2: 1'
{
    git pull --ff-only
} || {
    echo "Cannot git pull --ff-only!!!!!!!!!!!!!!!!"
}
{
    git pull --ff --no-edit
} || {
    echo "Cannot git pull --ff!!!!!!!!!!!!!!!!"
}

cd ../repo1
echo "This is a test commit-456" >> test.txt
git add ./ && git commit -m 'repo1: 3'
git push

cd ../repo2
# edit the same file
echo "This is a test commit-789" >> test.txt
git add . && git commit -m 'repo2: 2'
{
    git pull --ff-only
} || {
    echo "Cannot git pull --ff-only!!!!!!!!!!!!!!!!"
}

{
    git pull --ff --no-edit -X theirs
} || {
    echo "Cannot git --ff --no-edit -Xtheirs !!!!!!!!!!!!!!!!"
}
