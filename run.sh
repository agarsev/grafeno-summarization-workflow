#!/bin/bash

trap "exit" INT

experiments=$(ls experiments/*.yaml | sed 's:experiments/\(.*\).yaml$:\1:')
texts=$(ls texts/* | sed 's:texts/\(.*\)$:\1:')

echo "doc length summaryl" $experiments

rouge_score() {
    timeout 2m ./test.py -f ../texts/$1 -c ../experiments/${2}.yaml > ../.candidate
    if [ $? -ne 0 ]; then
        echo -n " 0"
    else
        echo -n " $(../rouge_eval.js ../.candidate ../summaries/$1)"
    fi
}


cd grafeno

for file in $texts
do
    original=../texts/$file
    gold=../summaries/$file

    origlen=$(wc -w $original | awk '{print $1}')
    goldlen=$(wc -w $gold | awk '{print $1}')

    echo -n "$file $origlen $goldlen"

    for exp in $experiments
    do
        rouge_score $original $exp
    done
    echo ""
done

cd ..
rm -f .candidate
