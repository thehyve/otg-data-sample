# Open Targets Genetics Data Sample

Small data sample (TP53, BRCA1 genes and NEALE2_50_raw,GCST001612 studies) to be used to test data loading and application.

## How sample dataset has been created

### The release dataset

```bash
    ./create_data_sample.sh open-targets-genetics-releases/19.05.04 /home/user/output ENSG00000012048,ENSG00000141510 NEALE2_50_raw,GCST001612
```
Where `open-targets-genetics-releases/19.05.04` is folder with the [full release data set].

## Load data

To load the release dataset to `ot` database and elasticsearch reffer to the [load script](https://github.com/thehyve/genetics-backend/blob/master/loaders/clickhouse/create_and_load_everything_from_scratch.sh).

[full release data set]: https://console.cloud.google.com/storage/browser/open-targets-genetics-releases/19.05.04
