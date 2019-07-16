# Open Targets Genetics Data Sample

Small data sample (TP53, BRCA1 genes and NEALE2_50_raw,GCST001612 studies) to be used to test data loading and application.

## How sample dataset has been created

### The release dataset

```bash
    ./create_data_sample.sh open-targets-genetics-releases/19.05.04 /home/user/output ENSG00000012048,ENSG00000141510 NEALE2_50_raw,GCST001612
```
Where `open-targets-genetics-releases/19.05.04` is folder with the [full release data set].

### The gwas data

This repo contains also gwas data for NEALE2_50_raw study. Here is [full gwas data set].

## Load data

**NOTE:** we reffer to the loading scripts from the master branch. They read data from Google Storage.
The scripts have to be modified to work with local file system to load this sample. [Here](https://github.com/thehyve/genetics-backend/tree/load_from_local_disk/loaders/clickhouse) is branch to achieve that. You could use branch instead untill it's not merged with the master.

### Default database and elasticsearch

To load the release dataset to `ot` database and elasticsearch reffer to the [load script](https://github.com/thehyve/genetics-backend/blob/master/loaders/clickhouse/create_and_load_everything_from_scratch.sh).

### sumstats database

To load the gwas dataset to `sumstats` database reffer to the [load folder](https://github.com/opentargets/genetics-backend/tree/master/loaders/clickhouse/scripts).
gwas data loadin happens in 2 steps:

    - load_sumstats_gwas.sh
    - sumstats_gwas_makechrtables.sh

[full release data set]: https://console.cloud.google.com/storage/browser/open-targets-genetics-releases/19.05.04
[full gwas data set]: https://console.cloud.google.com/storage/browser/genetics-portal-sumstats/gwas
