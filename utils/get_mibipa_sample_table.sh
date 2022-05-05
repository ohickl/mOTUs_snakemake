#!/bin/bash

mibipa_sample_tsv="/mnt/irisgpfs/users/ohickl/local_tools/motus3/config/mibipa_samples.tsv"
printf "SampleID\tMG_R1\tMG_R2\tMG_SE\tMT_R1\tMT_R2\tMT_SE\n" > ${mibipa_sample_tsv}

for sample_path in /mnt/isilon/projects/ecosystem_biology/MiBiPa/IMP/*/run1/Preprocessing; do
  sample_id=$(python -c "print(\"${sample_path}\".split('/')[7])")
  sample_line="${sample_id}"
  for ome in mg mt; do
    for reads in r1.preprocessed.fq r2.preprocessed.fq se.preprocessed.fq; do
      read_path="${sample_path}/${ome}.${reads}"
      if [[ -f ${read_path} ]]; then
        sample_line="${sample_line}\t${read_path}"
      else
        sample_line="${sample_line}\tNA"
      fi
    done
  done
  sample_line="${sample_line}\n"
  printf ${sample_line} >> ${mibipa_sample_tsv}
done
