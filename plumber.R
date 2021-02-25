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
  df <- feather::read_feather("data/simulated-returns.feather")
  if(stock==0){
    s=0
  } else if(stock==100){
    s=1
  } else {
    s=as.integer(stock)/100
  }

  samp <- df[df$stockAllocation == s,]
  samp <- samp[sample(nrow(samp), 1), ]
  samp$decile <- as.integer(cut(samp$percrank, c(0,0.2,0.4,0.6,0.8,Inf), 1:5))
  return(samp)
  #readr::read_csv("data/simulated-returns.csv") %>%
  #  dplyr::filter(stockAllocation == stock) %>%
  #  dplyr::sample_n(1)
}

#* Return the sum of two numbers
#* @param stockAllocation Stock allocation
#* @get /get_returns_array
function(stock_array){
  df <- feather::read_feather("data/simulated-returns.feather")

  stocks = gsub("]", "", stock_array, fixed = TRUE)
  stocks = gsub("[", "", stocks, fixed = TRUE)
  l = strsplit(stocks, ",")

  df_results = data.frame(matrix(ncol = 4, nrow = length(l[[1]])))
  colnames(df_results) <- c("expReturns","stockAllocation","percrank","decile")

  for (i in l[[1]]){
    stock = as.integer(i)

    if(stock==0){
      s=0
    } else if(stock==100){
      s=1
    } else {
      s=as.integer(stock)/100
    }

    samp <- df[df$stockAllocation == s,]
    samp <- samp[sample(nrow(samp), 1), ]
    samp$decile <- as.integer(cut(samp$percrank, c(0,0.2,0.4,0.6,0.8,Inf), 1:5))

    df_results <- rbind(df_results, samp)
  }
   return(df_results)
  #readr::read_csv("data/simulated-returns.csv") %>%
  #  dplyr::filter(stockAllocation == stock) %>%
  #  dplyr::sample_n(1)
}
