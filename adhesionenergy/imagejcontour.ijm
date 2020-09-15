run("Flip Vertically");
print("\\Clear")
myImageID = getImageID();
dir = getDirectory("image"); 
name=getTitle; 

selectImage(myImageID); 

setTool("line");
waitForUser("select ground line");

getSelectionCoordinates(x, y);
print (x[0], y[0]); 
print (x[1], y[1]); 

setTool("polygon");
waitForUser("select contour");

run("Fit Spline");

waitForUser("correct");

getSelectionCoordinates(x, y);

for (i=0;i<x.length;i++)
 print (x[i], y[i]); 


run("Draw");
run("Save");
run("Open Next");

selectWindow("Log")
saveAs("Text", dir+name); 

