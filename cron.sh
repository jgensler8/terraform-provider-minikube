set -ex
echo "clone"
git clone --depth 1 https://github.com/${TRAVIS_REPO_SLUG} /tmp/repo
cd /tmp/repo
# go list -u -m all
go get -u
git status
git diff go.mod
echo "update modules"
echo "create branch"
echo "create PR"
