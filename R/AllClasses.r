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

#' The S4 Class initialize a SVM leaner
#'
#' This object initialize a learner of mlr with a set of hyperparameters
#' @exportClass SVM
setClass('SVM',
  contains = 'model',
  slots = c(
    ps = 'list'),
  prototype = list(
    l = 'classif.ksvm',
    ps = list(C = list(lower = 0, upper = 1),
              sigma = list(lower = 0, upper = 1))
    ))

#' The S4 Class initialize a XGBoost leaner
#'
#' This object initialize a learner of mlr with a set of hyperparameters
#' @exportClass XGBOOST
setClass('XGBOOST',
  contains = 'model',
  slots = c(
    ps = 'list'),
  prototype = list(
    l = 'classif.xgboost',
    ps = list(nrounds = list(lower = 100, upper = 500),
              max_depth = list(lower = 1, upper = 10,
              eta = list(lower = .1, upper = .5),
              lambda = list(lower = -1, upper = 0, trafo = function(x) 10^x))
    )))

#' The S4 Class initialize a RandomForest leaner
#'
#' This object initialize a learner of mlr with a set of hyperparameters
#' @exportClass RF
setClass('RF',
  contains = 'model',
  slots = c(
    ps = 'list'),
  prototype = list(
    l = 'classif.randomForest',
    ps = list(ntree = list(lower = 500, upper = 1000),
              mtry = list(lower = 5, upper = 10),
              nodesize = list(lower = 1, upper = 5))
    ))


#' The S4 Class for storing resampling arguments
#'
#' This object stores all arguments to build resampling CV
#' @exportClass resampling
setClass('resampling',
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


#' The S4 Class for storing search strategy in CV-inner.
#'
#' This object stores all arguments to carry out search strategy in a inner CV 
#' @exportClass search
setClass('search',
  slots = c(
    measure = 'vector',
    terminator = 'list',
    tuner = 'list'
    ),
  prototype = list(
    measure = 'classif.acc',
    terminator = list('evals', 10),
    tuner = list('grid_search', 10)
    ))





