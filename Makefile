# Install FSCli.
#
# Example:
#   make install
install:
	pip install --editable .

# UnInstall FSCli.
#
# Example:
#   make uninstall
uninstall:
	pip uninstall .

# Test FSCli.
#
# Example:
#   make test
test:
	TODO

# Install FSCli Dep.
#
# Example:
#   make dep
dep:
	pipenv run pip install -r requirements/base.txt
