# Open Targets Genetics Data Sample

Small data sample (TP53, BRCA1 genes and NEALEUKB_50,GCST001612_1 studies) to be used to test data loading and application.

## How sample has been created

```bash
    /create_data_sample.sh open-targets-genetics-releases/19.03.03 /home/user/output ENSG00000012048,ENSG00000141510 NEALEUKB_50,GCST001612_1
```
Where `open-targets-genetics-releases/19.03.03` is folder with the [full data set].

## Load data

Reffer to the [load script](https://github.com/thehyve/genetics-backend/blob/master/loaders/clickhouse/create_and_load_everything_from_scratch.sh).

[full data set]: https://console.cloud.google.com/storage/browser/open-targets-genetics-releases/19.03.03
