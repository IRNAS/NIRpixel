/* NIR pixel optical assembly for 7mm lenses and TO46 photodetectors

Copyright Institute IRNAS Rače 2014. 

This documentation describes Open Hardware and is licensed under the CERN OHL v. 1.2.
You may redistribute and modify this documentation under the terms of the [CERN OHL v.1.2.](http://ohwr.org/cernohl). This documentation is distributed WITHOUT ANY EXPRESS OR IMPLIED  WARRANTY, INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A PARTICULAR PURPOSE. Please see the CERN  OHL  v.1.2 for applicable conditions.*/

// lens dimensions
lens_thick = 3.25;
lens_dia = 7.6; 
focal_dist = 6;

// TO46 photodiode package dimensions
pd_thick = 2.75; //2.25
pd_dia = 5.15; //4.66mm 

outer_h = focal_dist + lens_thick + pd_thick;
outer_d = 8;

//cube size
dist=8;

//resolution
res=100;

module opto_assembly(){
	//lens
	translate([0,0,lens_thick/2+focal_dist])
	cylinder(h=lens_thick,r1=lens_dia/2+0.1,r2=lens_dia/2,center=true,$fn=res);
	//photodiode
	translate([0,0,-pd_thick/2])
	cylinder(h=pd_thick,r=pd_dia/2,center=true,$fn=res);
	//optical path
	translate([0,0,focal_dist/2])
	cylinder(h=focal_dist,r2=lens_dia/2-1,r1=pd_dia/2,center=true,$fn=res);
}

module array(){
	for ( x = [-1 : 1]){
		for ( y = [-1 : 1]){
			translate([x*dist,y*dist,0])
			opto_assembly();
		}
	}
}

module enclosure(){
	translate([0,0,lens_thick])
	cube([3*dist+4,3*dist+4,12], center=true);
}

//end object
difference(){
	enclosure();
	array();
}
