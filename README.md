# Machine Learning experiments with Metagenomic data

Welcome to the homepage of pseqML package!

This is a package in development. 

This package will provide a standard environment to carried out Machine Learning experiemnts in metagenomics samples.

## Quick Installation

**This package is availabe under R (>= 4.0.1).**

You only need to call `install_github` function in `devtools` to install `pseqML`. Be aware of package dependencies.

```
# Installation requires bioconductor and devtools, please use the following commands if you've not

if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install()
install.packages("devtools")

# Before installing pseqML, you need also to install the dependent packages `phyloseq` and `mlr3`.
BiocManager::install(c("phyloseq"))
install.packages('mlr3')
devtools::install_github("jlinares/pseqML", dependencies=TRUE)
```


## Quick Start

Here is a simple but useful example in the use of `pseqML` utilities to carry out multiples and standards feature selection and machine learnings experiments.

Before starting the demonstration, you nedd to load the following packages:

```
require(mlr3)
require(phyloseq)
```

Start the analyisis:

```
## Load a example phyloseq object
data('random_pseq')

## Convert phyloseq to pseqMLR object
pseqML = peq2mlr(phyloseq = pseq,
			target = 'cancer',
			id = 'example')

## Select one Feature Selection approach
pseqML = filterCFS(pseqML, cutoff = 0.1)
```


At this moment, `phyloseq` object was converted to a `pseqMLR` object to which a set of FS algorithms can be passed to reduce the dimensionality of the dataset. Run `listFS()` command to see a complete list of FS algorithms availables in the package.

Once the dataset was reduced, is time to define a set of ML algorithms to carry out the analyisis. Run `listML()` to see a complete list of ML algorithms and how they should be built:

```
## Defining CV inner
cv.in = init_resampling(new('resampling', resampling = 'holdout', ration = 0.6))
search = new('search', measure = 'classif.acc', terminator = list('evals', 10), tuner = list('grid_search', 10))

## Defining learners
l1 = setHyperparameters(new('GLMNET', cv.in, search))
l2 = setHyperparameters(new('NB', cv.in, search))

## Defining CV outer 
outer = init_resampling(new('resampling'), resampling = 'repeated_cv', repeats = 2, folds = 3)

## Benchmark experiment
bmr = benchML(tasks = list(pseqMLR),
			learners = list(l1, l2),
			outer = outer)

## Show results
autoplot(bmr)
```