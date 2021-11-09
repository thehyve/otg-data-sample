# Data sample for Open Targets Genetics Portal

Small data sample (TP53, BRCA1 genes and NEALE2_50_raw, GCST001612 studies) to be used for testing and development of data loading and front end.

## Before you start

Download a shallow (to avoid downloading data from old releases) clone of this repository:

```bash
git clone -–depth 1 git@github.com:thehyve/otg-data-sample.git
```

Pull git submodules:

```bash
git submodule update --init --recursive
```

Make sure `pandas` and `pyarrow` modules are available in Python (consider using a virtual environment):

```bash
pip install pandas pyarrow
```

## How to use

Run the `create_data_sample.sh` script, using this template:

```bash
./create_data_sample.sh \
${INPUT_DIR} \
${OUTPUT_DIR} \
ENSG00000012048,ENSG00000141510 \
NEALE2_50_raw,GCST001612
```

Where `INPUT_DIR` is the directory containing the [full public release data](http://ftp.ebi.ac.uk/pub/databases/opentargets/genetics) and `OUTPUT_DIR` is the directory where filtered output will be stored.

An archive containing the output of this procedure can be found in our Google Drive.
Contact maintainers (Björn Wouters, Robin Meijer, Roman Hillje) if you cannot find it.

## Load data

To load the filtered output into ClickHouse and Elasticsearch, refer to the [`genetics-backend` repo](https://github.com/thehyve/genetics-backend) and/or instructions in the [`opentargets-genetics-automation` repo](https://github.com/thehyve/opentargets-genetics-automation).
