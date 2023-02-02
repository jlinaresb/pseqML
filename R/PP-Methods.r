#' ADD DESCRITPION!
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param level Character vector. Name of the column corresponding to taxonomic level
setGeneric(
    "check_prevalence",
    function(pseqMLR, level) standardGeneric("check_prevalence"))
setMethod("check_prevalence",
    signature("pseqMLR"),
    function(pseqMLR, level) {

        # check prevalence of each feature and save it in a df
        prev <- apply(
            X = otu_table(pseqMLR@data),
            MARGIN = ifelse(taxa_are_rows(pseqMLR@data), yes = 1, no = 2),
            FUN = function(x) {sum(x > 0)})

        # add taxonomy
        prev <- data.frame(
            Prevalence = prev,
            TotalAbundance = taxa_sums(pseqMLR@data),
            tax_table(pseqMLR@data)
        )

        # make df to return
        df <- plyr::ddply(
            prev,
            level,
            function(x) {
                cbind(mean(x$Prevalence), sum(x$Prevalence))
                })

        names(df)[2] <- "counts_mean"
        names(df)[3] <- "sum_counts"

        return(df)
        })



#' DRAFT! ADD DESCRIPTION
#' @param pseqMLR Object of class \code{pseqMLR}
setGeneric(
    "relative_abundance",
    function(pseqMLR) standardGeneric("relative_abundance"))
setMethod("relative_abundance",
    signature("pseqMLR"),
    function(pseqMLR) {
        pseqMLR@data <- transform_sample_counts(
            pseqMLR@data, function(x) {x / sum(x)}
            )
        return(pseqMLR)
        })

#' DRAFT! ADD DESCRIPTION
#' @param pseqMLR Object of class \code{pseqMLR}
setGeneric(
    "zscore_abundance",
    function(pseqMLR) standardGeneric("zscore_abundance"))
setMethod("zscore_abundance",
    signature("pseqMLR"),
    function(pseqMLR) {
        pseqMLR@data <- transform_sample_counts(
            pseqMLR@data, function(x) {x / sum(x)}
            )
        pseqMLR@data <- transform_sample_counts(
            pseqMLR@data, function(x) (x - mean(x)) / sd(x))
        return(pseqMLR)
        })


#' DRAFT! ADD DESCRIPTION
#' @param pseqMLR Object of class \code{pseqMLR}
setGeneric(
    "deep_median_abundance",
    function(pseqMLR) standardGeneric("deep_median_abundance"))
setMethod("deep_median_abundance",
    signature("pseqMLR"),
    function(pseqMLR) {
        pseqMLR@data <- transform_sample_counts(
            pseqMLR@data, function(x) {x / sum(x)}
            )
        pseqMLR@data <- transform_sample_counts(
            pseqMLR@data, function(x) (x - mean(x)) / sd(x))
        return(pseqMLR)
        })


#' DRAFT! ADD DESCRIPTION
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param transform Character vector. See ?microbiome::transform() for more info
setGeneric(
    "transform_counts",
    function(pseqMLR, tranform) standardGeneric("transform_counts"))
setMethod("transform_counts",
    signature("pseqMLR"),
    function(pseqMLR) {
        require(microbiome)
        pseqMLR@data <- transform(
            pseqMLR@data,
            transform = transform)
        return(pseqMLR)
        })


#' DRAFT! ADD DESCRIPTION
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param type Character vector. It can choose filter taxa by: "mean", "coef_var" or "presence"
#' @param threshold Numeric
#' @param percentage Numeric. Only used when type == presence. Value range from 0 to 1
setGeneric(
    "filtering_taxa",
    function(pseqMLR, type, threshold, percentage) standardGeneric("filtering_taxa"))
setMethod("filtering_taxa",
    signature("pseqMLR"),
    function(pseqMLR, type, threshold, percentage) {

        if (type == "mean") {
            f <- function(x) mean(x) > threshold
        } else if (type == "coef_var") {
            f <- function(x) sd(x)/mean(x) > threshold
        } else if (type == "presence") {
            f <- function(x) sum(x > threshold) > (percentage * length(x))
        }

        pseqMLR@data <- filter_taxa(
            pseqMLR@data,
            f,
            TRUE)
        return(pseqMLR)
        })
