//BEFORE SCRIPT -> MOVE TO THE SECOND CHANNEL 
setAutoThreshold("Otsu");
run("Convert to Mask", "method=Otsu background=Dark calculate");
waitForUser("Please circle outline");
//HERE YOU NEED TO MANUALLY CIRCLE DEFECT 
run("Measure");
roiManager("Add");

TotalArea=(getResult("Area", 0));
ApproxRad=sqrt(TotalArea/3.14);
Table.deleteRows(0, 0);
for (i = 0; i <=3; i++) {
	print(i);
	roiManager("Select",i);
	roiManager("Measure");
	PercentNuclei=(getResult("%Area",i));
	print(PercentNuclei);
	run("Enlarge...", "enlarge="+ ApproxRad/-5);
	roiManager("Add");
	}
run("Close");
