# plumber.R

#* @preempt __first__
#* @get /
function(req, res) {
  res$status <- 302
  res$setHeader("Location", "./__docs__/")
  res$body <- "Redirecting..."
  res
}

#* Return the sum of two numbers
#* @param stockAllocation Stock allocation
#* @get /get_returns
function(stock){
  df <- read.csv("data/simulated-returns.csv")
  if(stock==0){
    s=0
  } else if(stock==100){
    s=1
  } else {
    s=as.integer(stock)/100
  }

  samp <- df[df$stockAllocation == s,]
  samp[sample(nrow(samp), 1), ]
  #readr::read_csv("data/simulated-returns.csv") %>%
  #  dplyr::filter(stockAllocation == stock) %>%
  #  dplyr::sample_n(1)
}
