echo "clone"
git clone --depth 1 https://github.com/${TRAVIS_REPO_SLUG} /tmp/repo
pushd /tmp/repo
go list -u -m all
echo "update modules"
echo "create branch"
echo "create PR"
