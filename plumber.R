# plumber.R

library(Playground)
library("rjson")

#* @options /echo
#* @get /echo
#* @param data:character 
#* @response 200 Return successful
#* @response 500 Bad input
#* @response default Return successful
function(data) {
  
  # Extract the portfolio data
  out = paste0("You said: ", data)
  
  return(out)
  
}

#* @serializer unboxedJSON
#* @get /temperatures
function() {

  result <- fromJSON(file = "temperatures.json")

  return(
    list(result=result)
  )

}

#* @serializer unboxedJSON
#* @get /hostname
function() {

  date = Sys.Date()
  time = Sys.time()
  host = Sys.getenv("HOSTNAME")

  return(
    list(date=date, time=time, host=host)
  )

}

#* @serializer unboxedJSON
#* @post /add
function(a, b) {

  sum = Playground::addition(a, b)
  return(
    list(a=a, b=b, sum=sum)
  )

}

#* @options /subtract
#* @serializer unboxedJSON
#* @post /subtract
function(a, b) {

  out = as.numeric(a) - as.numeric(b)
  return(
    list(a=a, b=b, diff=out)
  )
  
}

#* @options /multiply
#* @serializer unboxedJSON
#* @post /multiply
function(a, b) {

  out = as.numeric(a) * as.numeric(b)
  return(
    list(a=a, b=b, product=out)
  )

}

#* @options /divide
#* @serializer unboxedJSON
#* @post /divide
function(a, b) {

  out = as.numeric(a) / as.numeric(b)
  return(
    list(a=a, b=b, dividend=out)
  )
  
}

