declare -a file_array=( 
Pred.DGF-1.Brazil.boundaryRefined.fasta
Pred.DGF-1.Y.boundaryRefined.fasta
Pred.GP63.Brazil.boundaryRefined.fasta
Pred.GP63.Y.boundaryRefined.fasta
Pred.MASPs.Brazil.boundaryRefined.fasta
Pred.MASPs.Y.boundaryRefined.fasta
Pred.Mucins.Brazil.boundaryRefined.fasta
Pred.Mucins.Y.boundaryRefined.fasta
Pred.RHS.Brazil.boundaryRefined.fasta
Pred.RHS.Y.boundaryRefined.fasta
Pred.ts.Brazil.boundaryRefined.fasta
Pred.ts.Y.boundaryRefined.fasta
)

for i in "${file_array[@]}"
do
   
   echo "python3 Get_seq_lengths_from_fasta.v1.1.py --file ${i}"
   python3 Get_seq_lengths_from_fasta.v1.1.py --file $i
done


#####################################################################################
declare -a file_array=( 
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
)

for i in "${file_array[@]}"
do
   
   echo "python /n/scratch2/dp235/illumina_2017_11_TcTSKO_201905analysis_WW/scripts/get_GFP11_in_TcTS_stat.py --infile /n/scratch2/dp235/illumina_2017_11_TcTSKO_201905analysis_WW/blastResultParsed_20minmatchlen_97maxmismatch/141870-${i}.merge.GFP11reads.fasta_Pred.TcTS.Brazil.fasta.parsed"
   python /n/scratch2/dp235/illumina_2017_11_TcTSKO_201905analysis_WW/scripts/get_GFP11_in_TcTS_stat.py --infile /n/scratch2/dp235/illumina_2017_11_TcTSKO_201905analysis_WW/blastResultParsed_20minmatchlen_97maxmismatch/141870-${i}.merge.GFP11reads.fasta_Pred.TcTS.Brazil.fasta.parsed
done
