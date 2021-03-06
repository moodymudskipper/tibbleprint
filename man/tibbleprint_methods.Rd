% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tibbleprint.R
\name{print.data.frame}
\alias{print.data.frame}
\alias{format.data.frame}
\title{tibbleprint methods}
\usage{
\method{print}{data.frame}(
  x,
  ...,
  n = NULL,
  width = NULL,
  n_extra = NULL,
  row.names = TRUE,
  base = getOption("tibbleprint.base")
)

\method{format}{data.frame}(x, ..., n = NULL, width = NULL, n_extra = NULL)
}
\arguments{
\item{x}{Object to format or print.}

\item{...}{arguments to be passed to to \code{base::data.frame()}}

\item{n}{Number of rows to show. If \code{NULL}, the default, will print all rows
if less than option \code{tibble.print_max}. Otherwise, will print
\code{tibble.print_min} rows.}

\item{width}{Width of text output to generate. This defaults to \code{NULL}, which
means use \code{getOption("tibble.width")} or (if also \code{NULL})
\code{getOption("width")}; the latter displays only the columns that fit on one
screen. You can also set \code{options(tibble.width = Inf)} to override this
default and always print all columns.}

\item{n_extra}{Number of extra columns to print abbreviated information for,
if the width is too small for the entire tibble. If \code{NULL}, the default,
will print information about at most \code{tibble.max_extra_cols} extra columns.}

\item{row.names}{whether to display row names}

\item{base}{whether to trigger original base behavior}
}
\description{
The arguments are the same as in \code{tibble:::print.tbl} except for \code{row.names},
borrowed from \code{base::print.data.frame}, and \code{base}
which triggers the original behavior. Argument passed to \code{...}
whose names match \code{base::print.data.frame}'s other argument names
("digits", "quote", "right", or "max"), also trigger the
original behavior.
}
