{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  pytestCheckHook,
  setuptools,
}:

buildPythonPackage rec {
  pname = "asn1";
  version = "3.0.1";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "andrivet";
    repo = "python-asn1";
    tag = "v${version}";
    hash = "sha256-aICQO2pAZKO+F9o5/sPyZGtIAlXaOUxe9qkb6sQX60U=";
  };

  build-system = [ setuptools ];

  pythonRemoveDeps = [ "enum-compat" ];

  nativeCheckInputs = [ pytestCheckHook ];

  pytestFlagsArray = [ "tests/test_asn1.py" ];

  pythonImportsCheck = [ "asn1" ];

  meta = with lib; {
    description = "Python ASN.1 encoder and decoder";
    homepage = "https://github.com/andrivet/python-asn1";
    changelog = "https://github.com/andrivet/python-asn1/blob/v${version}/CHANGELOG.rst";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
