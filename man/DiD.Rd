% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DiD_combine_cohorts.R
\name{DiD}
\alias{DiD}
\title{Combine DiD estimates across cohorts and event times.}
\usage{
DiD(
  inputdata,
  varnames,
  control_group = "all",
  base_event = -1,
  min_event = NULL,
  max_event = NULL,
  Esets = NULL,
  return_ATTs_only = TRUE,
  parallel_cores = 1
)
}
\arguments{
\item{inputdata}{A data.table.}

\item{varnames}{A list of the form varnames = list(id_name, time_name, outcome_name, cohort_name), where all four arguments of the list must be a character that corresponds to a variable name in inputdata.}

\item{control_group}{There are three possibilities: control_group="never-treated" uses the never-treated control group only; control_group="future-treated" uses those units that will receive treatment in the future as the control group; and control_group="all" uses both the never-treated and the future-treated in the control group. Default is control_group="all".}

\item{base_event}{This is the base pre-period that is normalized to zero in the DiD estimation. Default is base_event=-1.}

\item{min_event}{This is the minimum event time (e) to estimate. Default is NULL, in which case, no minimum is imposed.}

\item{max_event}{This is the maximum event time (e) to estimate. Default is NULL, in which case, no maximum is imposed.}

\item{Esets}{If a list of sets of event times is provided, it will loop over those sets, computing the average ATT_e across event times e. Default is NULL.}

\item{return_ATTs_only}{Return only the ATT estimates and sample sizes. Default is TRUE.}

\item{parallel_cores}{Number of cores to use in parallel processing. If greater than 1, it will try to run library(parallel), so the "parallel" package must be installed. Default is 1.}
}
\value{
A list with two components: results_cohort is a data.table with the DiDge estimates (by event e and cohort g), and results_average is a data.table with the DiDe estimates (by event e, average across cohorts g). If the Esets argument is specified, a third component called results_Esets will be included in the list of output.
}
\description{
Estimate DiD for all possible cohorts and event time pairs (g,e), as well as the average across cohorts for each event time (e).
}
\examples{
# simulate some data
simdata = SimDiD(sample_size=200, ATTcohortdiff = 2)$simdata

# define the variable names as a list()
varnames = list()
varnames$time_name = "year"
varnames$outcome_name = "Y"
varnames$cohort_name = "cohort"
varnames$id_name = "id"

# estimate the ATT for all cohorts at event time 1 only
DiD(simdata, varnames, min_event=1, max_event=1)

}
