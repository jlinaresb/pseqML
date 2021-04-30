# Machine Learning Methods
# ========================

#### pseq2mlr
#' Convert \code{phyloseq} to \code{mlr3} task 
#' @param pseqML Object of class \code{pseqML} (required)
#' @param id Character vector with ID to data (required)
#' @export
setGeneric('pseq2mlr', function(pseqML, id) standardGeneric('pseq2mlr'))
setMethod('pseq2mlr',
    signature('pseqML'),
    function(pseqML, id){

        X = as.data.frame(t(pseqML@data@otu_table@.Data))
        Y = as.factor(phyloseq::get_variable(pseqML@data, pseqML@target))

        d = cbind.data.frame(X, target = Y)
        names(d) = make.names(names(d))

        task = TaskClassif$new(id = id,
            backend = d,
            target = 'target')

        return(task)
        })


### setHyperparameters
#' Initialize a model with a set of hyperparameers
#' @param object of class \code{model} (required)
#' @param object of class \code{inner} (required)
#' @export
setGeneric('setHyperparameters', function(model, inner) standardGeneric('setHyperparameters'))
setMethod('setHyperparameters',
    signature('model'),
    function(model, inner){

        name = model@l
        learner = lrn(name)

        if (name == 'classif.kknn'){
            ps = ps(
                k = p_int(lower = model@ps$k[[1]], upper =model@ps$k[[2]]))
        } else if (name == 'classif.glmnet'){
            ps = ps(
                alpha = p_dbl(lower = model@ps$alpha[[1]], upper =model@ps$alpha[[2]]),
                s = p_dbl(lower = model@ps$s[[1]], upper = model@ps$s[[2]]))
        } else if (name == 'classif.naive_bayes'){
            ps = ps(
                laplace = p_dbl(lower = model@ps$laplace[[1]], upper = model@ps$laplace[[2]]))
        }

        cv.inner = rsmp(inner@resampling)
        measure = msr(inner@measure)
        terminator = trm(inner@terminator[[1]], n_evals = inner@terminator[[2]])
        tuner = tnr(inner@tuner[[1]], resolution = inner@tuner[[2]])

        at = AutoTuner$new(learner, cv.inner, measure, terminator, tuner, ps)

        })


### Initializze outer resampling
#' Initialize a resampling method to carried out outer CV
#' @param object of class \code{outer} (required)
#' @export
setGeneric('init_outer', function(object) standardGeneric('init_outer'))
setMethod('init_outer',
    signature('outer'),
    function(object){

        strategies = c('bootstrap', 'cv', 'holdout', 'loo', 'repeated_cv')
        stopifnot(object@resampling %in% strategies)

        if (object@resampling == 'bootstrap'){
            outer = rsmp(object@resampling, repeats = object@repeats, ratio = object@ratio)
        } else if (object@resampling == 'cv'){
            outer = rsmp(object@resampling, folds = object@folds)
        } else if (object@resampling == 'holdout'){
            outer = rsmp(object@resampling, ratio = object@ratio)
        } else if (object@resampling == 'loo'){
            outer = rsmp(object@resampling)
        } else if (object@resampling == 'repeated_cv'){
            outer = rsmp(object@resampling, repeats = object@repeats, folds = object@folds)
        }

        return(outer)

        })