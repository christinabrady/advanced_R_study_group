x<-matrix(rep(2,4),ncol=2)
x
x[]<-0
x
is.matrix(x)
x<-0
str(x)
is.vector(x)
is.double(x)

animals<-c("cat","dog","mouse", "rabbit")
x<-1:4
names(x)<-animals
x

outer(x,y,FUN="+")


