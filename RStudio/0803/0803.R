sqrt(5)
#sqrt(2,3)
sqrt(c(1,2,3,4,5))
square <- function(data){
  return (data^2)
}
square(5)
square(c(1,2,3,4,5))

point <- function(xval, yval){
  return(c(x=xval, y=yval))
}
p1 <- point(5,6)
p2 <- point(2,3)

euclidean.distance <- function(point1,point2,square.func){
  distance <-sqrt(
    square.func(point1['x'] - point2['x']) + square.func(point1['y'] - point2['y'])
  )
  return(c(distance=distance))
}
euclidean.distance(point1 = p1, point2 = p2, square.func = square)


