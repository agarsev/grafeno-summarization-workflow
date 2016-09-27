Complete summarization + evaluation workflow using grafeno.

USAGE
-----
Put in the directory `texts` a plain text file for each document to summarize.
Then put in the directory `summaries` another plain text file with the gold
standard summary against which to evaluate. The summary files must have the same
file name as the original document.

In the `experiments` directory, put all the `yaml` configuration scripts for the
experiments you want grafeno to run. They all must end with a linearization so
that a summary is produced.

Then, just run `$./run.sh`, and you're done!

RESULTS
-------
Results are formatted as a csv, space-separated, and with a
heading line. For each document, a row will be printed with its name, the
original file length in words, and the summary file length in words.

The rest of the columns, one for each experiment, will be the ROUGE score of the
extracted summary with that experiment against the gold standard one.

You can load the results into R like this:
```
results <- read.csv('results.csv',sep=' ',header=T,row.names=1)
```

INSTALL
-------
Either clone this repository with `--recursive`, or run:

```
$ git submodule init
$ git submodule update
```

Then get the ROUGE npm module:

```
$ npm install
```

You will also have to install the necessary grafeno dependencies, which vary
according to the modules that you want to use.
