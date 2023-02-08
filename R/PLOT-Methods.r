#' Plot abundances
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param level Character vector. Name of the column corresponding to taxonomic level
setGeneric(
  "plot_abundances",
  function(pseqMLR, level) standardGeneric("plot_abundances"))
setMethod("plot_abundances",
          signature("pseqMLR"),
          function(pseqMLR, level) {

            require(phylosmith)
            plot <- phylosmith::phylogeny_profile(
              phyloseq_obj = pseqMLR@data,
              treatment = pseqMLR@target,
              relative_abundance = TRUE,
              classification = level,
              grid = FALSE,
              merge = TRUE
            )
            print(plot)
          })


#' Plot abundances by target
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param level Character vector. Name of the column corresponding to taxonomic level
setGeneric(
  "plot_abundances_target",
  function(pseqMLR, level) standardGeneric("plot_abundances_target"))
setMethod("plot_abundances_target",
          signature("pseqMLR"),
          function(pseqMLR, level) {

            require(phylosmith)
            pseqMLR@data <- merge_samples(
              x = pseqMLR@data,
              group = pseqMLR@target,
              fun = sum
            )
            plot <- phylosmith::phylogeny_profile(
              phyloseq_obj = pseqMLR@data,
              treatment = pseqMLR@target,
              relative_abundance = TRUE,
              classification = level,
              grid = FALSE,
              merge = TRUE
            )
            print(plot)
          })


#' Plot richness
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param index Richness index. Available indexes are: "shannon", "simpson",
#' or "invsimpson"
setGeneric(
  "plot_richness",
  function(pseqMLR, index) standardGeneric("plot_richness"))
setMethod("plot_richness",
          signature("pseqMLR"),
          function(pseqMLR, index) {

            require(phylosmith)
            require(ggpubr)
            require(viridis)

            plot <- phylosmith::alpha_diversity_graph(
              phyloseq_obj = pseqMLR@data,
              index = index,
              treatment = pseqMLR@target,
              subset = NULL,
              colors = viridis(length(unique(names(table(data.frame(pseqMLR@data@sam_data)[pseqMLR@target])))))
            )

            plot <- plot + stat_compare_means()
            print(plot)
          })


#' Plot abundances bar
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param level Character vector. Name of the column corresponding to taxonomic level
#' @param transformation Character vector. Available transformation methods are:
#'  "none", "mean", "median", "sd", "log", "log10"
setGeneric(
  "plot_abundances_bars",
  function(pseqMLR, level, transformation) standardGeneric("plot_abundances_bars"))
setMethod("plot_abundances_bars",
          signature("pseqMLR"),
          function(pseqMLR, level, transformation) {

            require(phylosmith)

            plot <- phylosmith::taxa_abundance_bars(
              phyloseq_obj = pseqMLR@data,
              classification = level,
              treatment = pseqMLR@target,
              transformation = transformation
            )
            print(plot)
          })


#' Plot abundances lines
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param level Character vector. Name of the column corresponding to taxonomic level
setGeneric(
  "plot_abundances_lines",
  function(pseqMLR, level) standardGeneric("plot_abundances_lines"))
setMethod("plot_abundances_lines",
          signature("pseqMLR"),
          function(pseqMLR, level) {

            require(phylosmith)

            plot <- phylosmith::abundance_lines(
              phyloseq_obj = pseqMLR@data,
              classification = level,
              treatment = pseqMLR@target,
              relative_abundance = TRUE
            )
            print(plot)
          })



#' Plot heatmap
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param level Character vector. Name of the column corresponding to taxonomic level
#' @param transformation Character vector. Available transformation methods are:
#' "none", "relative_abundance", "log", "log10", "log1p", "log2", "identity" and "sqrt"
setGeneric(
  "plot_heatmap",
  function(pseqMLR, level, transformation) standardGeneric("plot_heatmap"))
setMethod("plot_heatmap",
          signature("pseqMLR"),
          function(pseqMLR, level, transformation) {

            require(phylosmith)
            require(viridis)

            plot <- phylosmith::abundance_heatmap(
              phyloseq_obj = pseqMLR@data,
              classification = level,
              treatment = pseqMLR@target,
              transformation = transformation)
            print(plot)
          })


#' Plot varcorr
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param target ¿?
#' @param level Character vector. Name of the column corresponding to taxonomic level
#' @param method Character vector. Available methods are: "pearson", "spearman"
setGeneric(
  "plot_varcorr",
  function(pseqMLR, target, level, method) standardGeneric("plot_varcorr"))
setMethod("plot_varcorr",
          signature("pseqMLR"),
          function(pseqMLR, target, level, method) {

            require(phylosmith)

            plot <- phylosmith::variable_correlation_heatmap(
              phyloseq_obj = pseqMLR@data,
              variables = target,
              treatment = pseqMLR@target,
              classification = level,
              method = method,
              cores = 1,
              significance_color = "black"
              )
            print(plot)
          })


#' Plot taxa core
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param target ¿?
setGeneric(
  "plot_taxa_core",
  function(pseqMLR, target) standardGeneric("plot_taxa_core"))
setMethod("plot_taxa_core",
          signature("pseqMLR"),
          function(pseqMLR, target) {

            require(phylosmith)

            plot <- phylosmith::taxa_core_graph(
              phyloseq_obj = pseqMLR@data,
              treatment = pseqMLR@target,
              frequencies = seq(0.3, 1, 0.1),
              abundance_thresholds = seq(0.01, 1, 0.01)
              )
            print(plot)
          })
