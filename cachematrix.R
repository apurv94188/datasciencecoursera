## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
	inverseMrx <- NULL
	set <- function(y){
		x <<- y
		inverseMrx <<- NULL
	}
	
	get <- function() x
	setInverse <- function(inverseM) inverseMrx <<- inverseM
	getInverse <- function() inverseMrx
	
	list(set=set, get=get, setInverse=setInverse, getInverse=getInverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    
	inverseMrx <- x$getInverse()
	
	if(!is.null(inverseMrx)) {
        return(inverseMrx)
	}
	
	inverseData <- x$get()
	inverseMrx <- solve(inverseData, ...)
	x$setInverse(inverseMrx)
		## Return a matrix that is the inverse of 'x'
	
	return(x$getInverse())
	
}
