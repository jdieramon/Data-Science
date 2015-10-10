## Objective: we want to save computation when working with matrix inversion
## This code caches the inverse of a matrix rather than compute it repeatedly

## The next function creates a special matrix object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
        i  <- NULL
        #set the matrix
        set  <- function(y) {
                x <<- y
                i <<- NULL
        }
        #get the matrix
        get <- function() x
        #set the inverse of the matrix
        setinverse  <- function(solve) i <<- solve
        #get the inverse
        getinverse  <- function() i
        #creates a list containing the above steps
        list(set = set,get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}



## The next function computes the inverse of the special matrix returned by makeCacheMatrix
##

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        i <- x$getinverse()
        #checks to see if the inverse has already been calculated
        if(!is.null(i)) {
                message("getting cached data")
                return(i) #If the inverse has already been calculated, it gets the inverse from the cache
        }
        #Otherwise, it calculates the inverse matrix and sets the value of the inverse in the cache via the setinverse function
        data <- x$get()
        i <- solve(data, ...)
        x$setinverse(i)
        i
}
