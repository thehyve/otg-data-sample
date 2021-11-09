#!/bin/bash

if [ $# -lt 4 ]; then
    echo "Creates a sample data set for the given genes and studies."
    echo "Usage: $0 source_dir output_dir gene_list studies_list"
    echo "Example: $0 /home/user/open-targets-genetics-releases/19.05.04 /home/user/output ENSG00000012048,ENSG00000141510 NEALE2_50_raw,GCST001612"
    echo "Selects data set for ENSG00000012048 (BRCA1) and ENSG00000141510 (TP53) genes and for two studies: NEALE2_50_raw and GCST001612"
    exit 1
fi

time_stamp() {
    echo $(date +"%Y-%m-%d %T")
}

INPUT_DIR=${1}
OUTPUT_DIR=${2}
GENES_RE="\\(${3//,/\\|}\\)"
GENES_=${3//,/_}
STUDIES_RE="\\(${4//,/\\|}\\)"
STUDIES_=${4//,/_}

echo "[$(time_stamp)] Filtering genes index (1/12)"
mkdir -p ${OUTPUT_DIR}/lut/genes-index/
grep -h "\"gene_id\":\"${GENES_RE}\"" ${INPUT_DIR}/lut/genes-index/part-*.json > ${OUTPUT_DIR}/lut/genes-index/part-${GENES_}.json

echo "[$(time_stamp)] Filtering variant index (2/12)"
mkdir -p ${OUTPUT_DIR}/lut/variant-index/
grep -h "\"gene_id_any\":\"${GENES_RE}\"" ${INPUT_DIR}/lut/variant-index/part-*.json > ${OUTPUT_DIR}/lut/variant-index/part-${GENES_}.json

echo "[$(time_stamp)] Filtering study index (3/12)"
mkdir -p ${OUTPUT_DIR}/lut/study-index/
grep -h "\"study_id\":\"${STUDIES_RE}\"" ${INPUT_DIR}/lut/study-index/part-*.json > ${OUTPUT_DIR}/lut/study-index/part-${STUDIES_}.json

echo "[$(time_stamp)] Filtering study overlap index (4/12)"
mkdir -p ${OUTPUT_DIR}/lut/overlap-index/
grep -h "\"A_study_id\":\"${STUDIES_RE}\"" ${INPUT_DIR}/lut/overlap-index/part-*.json > ${OUTPUT_DIR}/lut/overlap-index/part-${STUDIES_}.json

echo "[$(time_stamp)] Filtering variant to gene records (5/12)"
mkdir -p ${OUTPUT_DIR}/v2g/
grep -h "\"gene_id\":\"${GENES_RE}\"" ${INPUT_DIR}/v2g/part-*.json > ${OUTPUT_DIR}/v2g/part-${GENES_}.json

echo "[$(time_stamp)] Filtering variant to disease records (6/12)"
mkdir -p ${OUTPUT_DIR}/v2d/
grep -h "\"study_id\":\"${STUDIES_RE}\"" ${INPUT_DIR}/v2d/part-*.json > ${OUTPUT_DIR}/v2d/part-${STUDIES_}.json

echo "[$(time_stamp)] Filtering disease to variant to gene records (7/12)"
mkdir -p ${OUTPUT_DIR}/d2v2g/
grep -h "\"study_id\":\"${STUDIES_RE}\"" ${INPUT_DIR}/d2v2g/part-*.json | grep "\"gene_id\":\"${GENES_RE}\"" > ${OUTPUT_DIR}/d2v2g/part-${STUDIES_}-${GENES_}.json

echo "[$(time_stamp)] Filtering variant to disease colocalisation records (8/12)"
mkdir -p ${OUTPUT_DIR}/v2d_coloc/
grep -h ":\"${STUDIES_RE}\"" ${INPUT_DIR}/v2d_coloc/part-*.json | grep ":\"${GENES_RE}\"" > ${OUTPUT_DIR}/v2d_coloc/part-${STUDIES_}-${GENES_}.json

echo "[$(time_stamp)] Filtering variant to disease credset records (9/12)"
mkdir -p ${OUTPUT_DIR}/v2d_credset/
zcat ${INPUT_DIR}/v2d_credset/part-*.json.gz | grep -h "\"study_id\":\"${STUDIES_RE}\"" | gzip > ${OUTPUT_DIR}/v2d_credset/part-${STUDIES_}.json.gz

echo "[$(time_stamp)] Filtering gwas records (10/12)"
mkdir -p ${OUTPUT_DIR}/sa/
IFS=',' read -r -a genes <<< "$3"
IFS=',' read -r -a studies <<< "$4"
for f in ${INPUT_DIR}/sa/gwas/*.parquet; do
    ./parquet_rows_filter_cli/parquet_filter.py "${f}" ${OUTPUT_DIR}/sa/gwas/"$(basename -- $f)" ${studies[@]/#/--study_id=}
    echo .
done

echo "[$(time_stamp)] Filtering molecular trait records (11/12)"
for f in ${INPUT_DIR}/sa/molecular_trait/*.parquet; do
    ./parquet_rows_filter_cli/parquet_filter.py "${f}" ${OUTPUT_DIR}/sa/molecular_trait/"$(basename -- $f)" "${studies[@]/#/--study_id=}" "${genes[@]/#/--gene_id=}"
    echo .
done

echo "[$(time_stamp)] Filtering locus to gene records (12/12)"
mkdir -p ${OUTPUT_DIR}/l2g/
for f in ${INPUT_DIR}/l2g/*.parquet; do
    ./parquet_rows_filter_cli/parquet_filter.py "${f}" ${OUTPUT_DIR}/l2g/"$(basename -- $f)" ${studies[@]/#/--study_id=} "${genes[@]/#/--gene_id=}"
    echo .
done

echo "[$(time_stamp)] Creating of the sample dataset has finished."
