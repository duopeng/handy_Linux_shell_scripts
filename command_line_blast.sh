perc_identity_cutoff=85
blast_db_1=fasta/40ts_trans-sialidase_DNA_sequence.fasta
blast_query_1=fasta/ts.pred.Brazil.fasta
blast_db_2=fasta/40ts_trans-sialidase_DNA_sequence.fasta
blast_query_2=fasta/ts.pred.Y.fasta

/home/duopeng/bin/x86_64/ncbi-blast-2.8.1+/bin/makeblastdb -dbtype nucl -in  ${blast_db_1}
/home/duopeng/bin/x86_64/ncbi-blast-2.8.1+/bin/makeblastdb -dbtype nucl -in ${blast_db_2}

echo "blasting..."
/home/duopeng/bin/x86_64/ncbi-blast-2.8.1+/bin/blastn -db ${blast_db_1} -query ${blast_query_1} -out ${blast_query_1}.${blast_db_1##*\/}.blastout -num_threads 1 -num_alignments 2000 -max_hsps 2000 -perc_identity ${perc_identity_cutoff}
echo "done"
echo "blasting..."
/home/duopeng/bin/x86_64/ncbi-blast-2.8.1+/bin/blastn -db ${blast_db_2} -query ${blast_query_2} -out ${blast_query_2}.${blast_db_2##*\/}.blastout -num_threads 1 -num_alignments 2000 -max_hsps 2000 -perc_identity ${perc_identity_cutoff}
echo "done"

#${blast_db_1  <-- from variable blast_db_1
#  ##   <-- greedy front trim
#  *    <-- matches anything
#  :    <-- until the last ':'
 #}