su travis
source /home/travis/virtualenv/python3.7.1/bin/activate
pip install --upgrade pip autodocsumm incremental sphinx-rtd-theme nbsphinx twine
cd /home/travis
source virtualenv/python3.7.1/bin/activate
git clone --depth=5 --branch=master https://github.com/FireDynamics/fdsreader.git FireDynamics/fdsreader
# Deploy to Github pages
cd FireDynamics/fdsreader
mkdir docs/build
sphinx-build -b html docs docs/build
touch docs/build/.nojekyll
cd /home/travis
git clone -b gh-pages https://JanVogelsang:$GITHUB_TOKEN@github.com/FireDynamics/fdsreader.git gh-pages
cd gh-pages
rsync -rl --exclude .git --delete "/home/travis/FireDynamics/fdsreader/docs/build/" .
git add -A .
git commit -q -m "Deploy FireDynamics/fdsreader to github.com/FireDynamics/fdsreader.git:gh-pages"
git push origin gh-pages
# Deploy to PyPI
python setup.py sdist bdist_wheel
twine upload -u __token__ -p $PYPI_TOKEN dist/*