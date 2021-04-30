#' The S4 Class for storing phyloseq data to carried out ML analyisis.
#'
#' This object stores the all information of metagenomic data
#' in one \code{\link{phyloseq}} class. In addition, ...
#' @exportClass pseqML
setClass('pseqML',
         slots = c(
           data = 'phyloseq',
           target = 'character'
         ),
         prototype = list(
           data = NULL,
           target = NULL
         ))



# Machine Learning classes
# =========================
#' The S4 Class initialize a leaner of mlr3
#'
#' This object initialize a learner of mlr with a set of hyperparameters
#' @exportClass model
setClass('model',
  slots = c(
    l = 'character'))


#' The S4 Class initialize a k-NN leaner
#'
#' This object initialize a learner of mlr with a set of hyperparameters
#' @exportClass KNN
setClass('KNN',
  contains = 'model',
  slots = c(
    ps = 'list'),
  prototype = list(
    l = 'classif.kknn',
    ps = list(k = list(lower = 1, upper = 15))
    ))

#' The S4 Class initialize a glmnet leaner
#'
#' This object initialize a learner of mlr with a set of hyperparameters
#' @exportClass GLMNET
setClass('GLMNET',
  contains = 'model',
  slots = c(
    ps = 'list'),
  prototype = list(
    l = 'classif.glmnet',
    ps = list(alpha = list(lower = 0, upper = 1),
              s     = list(lower = 0, upper = 1))
    ))

#' The S4 Class initialize a Naive Bayes leaner
#'
#' This object initialize a learner of mlr with a set of hyperparameters
#' @exportClass NB
setClass('NB',
  contains = 'model',
  slots = c(
    ps = 'list'),
  prototype = list(
    l = 'classif.naive_bayes',
    ps = list(laplace = list(lower = 0, upper = 1))
    ))


#' The S4 Class for storing CV-inner arguments
#'
#' This object stores all arguments to carry out inner CV in a
#' nested resampling
#' @exportClass inner
setClass('inner',
  slots = c(
    resampling = 'character',
    measure = 'vector',
    terminator = 'list',
    tuner = 'list'
    ),
  prototype = list(
    resampling = 'holdout',
    measure = 'classif.acc',
    terminator = list('evals', 10),
    tuner = list('grid_search', 10)
    ))


#' The S4 Class for storing CV-outer arguments
#'
#' This object stores all arguments to carry out outer CV in a
#' nested resampling
#' @exportClass outer
setClass('outer',
  slots = c(
    resampling = 'character',
    repeats = 'numeric',
    ratio = 'numeric',
    folds = 'numeric'
    ),
  prototype = list(
    resampling = 'cv',
    repeats = 0,
    ratio = 0,
    folds = 5
    ))


