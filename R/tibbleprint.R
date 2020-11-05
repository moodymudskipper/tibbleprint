#' @importFrom utils getFromNamespace
#' @importFrom vctrs new_rcrd field
#' @importFrom cli cat_line
NULL


#' tibbleprint methods
#'
#' The arguments are the same as in `tibble:::print.tbl` except for `row.names`,
#' borrowed from `base::print.data.frame`, and `base`
#' which triggers the original behavior. Argument passed to `...`
#' whose names match `base::print.data.frame`'s other argument names
#' ("digits", "quote", "right", or "max"), also trigger the
#' original behavior.
#'
#' @inheritParams tibble:::print.tbl
#' @param row.names whether to display row names
#' @param base whether to trigger original base behavior
#' @param ... arguments to be passed to to `base::data.frame()`
#' @export
#' @rdname tibbleprint_methods
print.data.frame <- function (x, ..., n = NULL, width = NULL, n_extra = NULL,
                              row.names = TRUE, base = getOption("tibbleprint.base")){
  dots <- list(...)
  nms <- names(dots)
  if (base || any(c("digits", "quote", "right", "max") %in% nms)) {
    if(any(c("width", "n_extra") %in% nms)) {
      stop(
        "`width` and `n_extra` arguments must not be used when printing a ",
        "data frame with `base = TRUE` or providing arguments `digits`, ",
        "`quote`, `right`, or `max`")
    }
    nr <- nrow(x)
    if(!is.null(n) && nr > n) {
      if("max" %in% nms)
        stop("`n` and `max` cannot be used at the same time if `n` is restrictive")
      base::print.data.frame(head(x,n), row.names = row.names, ...)
      writeLines(sprintf(
        " [ reached 'n' -- omitted %s rows ]", nr-n))
    } else {
      base::print.data.frame(x, row.names = row.names, ...)
    }
    return(invisible(x))
  }
  if(row.names && !is.null(rnms <- row.names(x)) && !identical(rnms, as.character(seq(nrow(x))))) {
    rn <- new_rcrd(list(rn = rnms), class = "rownames")
    x2 <- cbind(..rn.. = rn, x)
    names(x2)[[1]] <- "."
    class(x2) <- c("dataframe_as_tibble", class(x2))
  } else {
    x2 <- x
  }
  cat_line(format(x2, ..., n = n, width = width, n_extra = n_extra))
  invisible(x)
}

#' @inheritParams tibble:::format.tbl
#' @export
#' @rdname tibbleprint_methods
format.data.frame <- function (x, ..., n = NULL, width = NULL, n_extra = NULL) {
  trunc_mat <- getFromNamespace("trunc_mat", "tibble")
  mat <- trunc_mat(x, n = n, width = width, n_extra = n_extra)
  format(mat)
}

#' @export
format.rownames <- function(x, ...) field(x, "rn")

obj_sum.dataframe_as_tibble <- function (x) {
  class(x) <- setdiff(class(x), "dataframe_as_tibble")
  type_sum <- if(identical(class(x), "data.frame")) "df" else class(x)[[1]]
  type_sum <- paste0(type_sum, "[,", ncol(x)-1, "]")
  paste0(type_sum, sprintf(" [%s x %s]", nrow(x), ncol(x)-1))
}

.onLoad <- function(libname, pkgname) {
  registerS3method("obj_sum", "dataframe_as_tibble", obj_sum.dataframe_as_tibble, envir = asNamespace("pillar"))

  op <- options()
  op.tibbleprint <- list(
    tibbleprint.base = FALSE
  )
  toset <- !(names(op.tibbleprint) %in% names(op))
  if(any(toset)) options(op.tibbleprint[toset])
  invisible()
}
