# plumber.R

library(Playground)
library("rjson")

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

  sum <- Playground::addition(a, b)
  return(
    list(a=a, b=b, sum=sum)
  )

}

#* @options /subtract
#* @serializer unboxedJSON
#* @post /subtract
function(a, b) {

  diff <- Playground::subtract(a, b)
  return(
    list(a=a, b=b, diff=diff)
  )
  
}

#* @options /multiply
#* @serializer unboxedJSON
#* @post /multiply
function(a, b) {

  product <- Playground::multiply(a, b)
  return(
    list(a=a, b=b, product=product)
  )

}

#* @options /divide
#* @serializer unboxedJSON
#* @post /divide
function(a, b) {

  dividend <- Playground::divide(a, b)
  return(
    list(a=a, b=b, dividend=dividend)
  )
  
}

