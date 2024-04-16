# I3C SystemRDL CSR

## Usage

Only system requirements are Python3 and GNU Make:

```
apt -y install make python3 python-is-python3
```

Create a virtual python environment, activate it and install dependencies:

```
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

Generate register description with make:

```
make generate
```
