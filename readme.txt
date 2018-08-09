# Readme about the regridding code
# Lei Zhu, 02/05/15

# About the folder
RegridPixels.f90		: Main script
cakecut_m.f90 and tools_m.f90 	: Two modules called by RegridPixels.f90
Method.pdf			: A slide to explain the method used in RegridPixels.f90
input/ 				: Test case, OMI HCHO pixels 2013 Aug-Sep, compressed file.
					  "tar -xvf merge_Smedt_OMI_HCHO_2013_Aug_Sep.tgz" to
					  decompress the file before running the script
output/				: Test case, outputs using 0.1 and 0.5 degree resolution
plot/				: An R script to plot the outputs, 
			 	  and two plots with 0.1 and 0.5 degree resolution.
				  You may want to comapre your results with those plots,
				  just to make sure the code works well. 

# Where to make change in RegridPixels.f90
You may need to change the format of input files (around line 160 )
However, try to make change in run.sh, instead of RegridPixels.f90. By doing this you won't mess up the code.

# Compile:
gfortran -o RegridPixels.x cakecut_m.f90 tools_m.f90 RegridPixels.f90

# Run:
./run.sh

