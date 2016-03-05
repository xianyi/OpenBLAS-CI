#!/bin/bash
today=`date +%y%m%d`

####test level1 ####
echo "BLAS 1 S"
./xsl1blastst -R all -N 1 10 2 -a 3 -1.0 0.0 1.0 -X 4 2 1 -1 -2 -Y 4 2 1 -1 -2 > sl1.right.$today
echo "BLAS 1 D"
./xdl1blastst -R all -N 1 10 2 -a 3 -1.0 0.0 1.0 -X 4 2 1 -1 -2 -Y 4 2 1 -1 -2 > dl1.right.$today
echo "BLAS 1 C"
./xcl1blastst -R all -N 1 10 2 -a 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -X 4 2 1 -1 -2 -Y 4 2 1 -1 -2 > cl1.right.$today
echo "BLAS 1 Z"
./xzl1blastst -R all -N 1 10 2 -a 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -X 4 2 1 -1 -2 -Y 4 2 1 -1 -2 > zl1.right.$today

####test level2####
echo "BLAS 2 S"
./xsl2blastst -R all -U 2 L U -A 2 N T -Diag 2 N U -a 3 -1.0 0.0 1.0 -b 3 -1.0 0.0 1.0 -X 4 2 1 -1 -2 -Y 4 2 1 -1 -2 -N 1 10 2 -M 1 10 2 -P 1 10 2 -Q 1 10 2 > sl2.right.$today
echo "BLAS 2 D"
./xdl2blastst -R all -U 2 L U -A 2 N T -Diag 2 N U -a 3 -1.0 0.0 1.0 -b 3 -1.0 0.0 1.0 -X 4 2 1 -1 -2 -Y 4 2 1 -1 -2 -N 1 10 2 -M 1 10 2 -P 1 10 2 -Q 1 10 2 > dl2.right.$today
echo "BLAS 2 C"
./xcl2blastst -R all -U 2 L U -A 3 C N T -Diag 2 N U -a 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -b 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -X 4 2 1 -1 -2 -Y 4 2 1 -1 -2 -N 1 10 2 -M 1 10 2 -P 1 10 2 -Q 1 10 2 > cl2.right.$today
echo "BLAS 2 Z"
./xzl2blastst -R all -U 2 L U -A 3 C N T -Diag 2 N U -a 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -b 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -X 4 2 1 -1 -2 -Y 4 2 1 -1 -2 -N 1 10 2 -M 1 10 2 -P 1 10 2 -Q 1 10 2 > zl2.right.$today

####test level3 ####
echo "BLAS 3 S"
./xsl3blastst -R all -S 2 L R -U 2 L U  -A 2 N T -B 2 N T -Diag 2 N U  -a 3 -1.0 0.0 1.0  -b 3 -1.0 0.0 1.0 -N 1 10 2 -M 1 10 2 -K 1 10 2 > sl3.right.$today
echo "BLAS 3 D"
./xdl3blastst -R all -S 2 L R -U 2 L U  -A 2 N T -B 2 N T -Diag 2 N U  -a 3 -1.0 0.0 1.0  -b 3 -1.0 0.0 1.0 -N 1 10 2 -M 1 10 2 -K 1 10 2 > dl3.right.$today
echo "BLAS 3 C"
./xcl3blastst -R all -S 2 L R -U 2 L U  -A 3 C N T -B 3 C N T -Diag 2 N U  -a 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -b 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -M 1 10 2 -N 1 10 2 -K 1 10 2 > cl3.right.$today
echo "BLAS 3 Z"
./xzl3blastst -R all -S 2 L R -U 2 L U  -A 3 C N T -B 3 C N T -Diag 2 N U  -a 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -b 3 -1.0 -1.1 0.0 0.0 1.0 1.1 -M 1 10 2 -N 1 10 2 -K 1 10 2 > zl3.right.$today
