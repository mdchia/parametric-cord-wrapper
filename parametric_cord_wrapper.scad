// Parametric Cord Wrap
// by Ming-Dao Chia

// *Settings*

// How long the center should be
// Depends on how much cord you have, usually
// Does not include ends
cord_wrap_length = 40; // in mm

// Cable diameter
// Make it a bit bigger than the actual cable to ensure that it'll fit well
cord_diameter = 3; // in mm

// Thickness
// (of entire piece)
PCW_thickness = 3; // in mm

// Middle text
// Leave blank for no text
name="Jane Doe";

// Middle text font
font="Open Sans";

// **Advanced settings**

// Overlap factor
// Ensures all objects are connected and holes are hollow
overlap=0.001; // in mm

module PCW_endcap(){
    difference(){
        cube([cord_diameter*5,cord_diameter*5,PCW_thickness]);
        union(){ // this makes a small spiral :)
            translate([cord_diameter*3,-overlap,-overlap])
            cube([cord_diameter,cord_diameter*4,PCW_thickness+(overlap*2)]);
            translate([cord_diameter+overlap,cord_diameter*3,-overlap])
            cube([cord_diameter*2,cord_diameter,PCW_thickness+(overlap*2)]);
            translate([cord_diameter,cord_diameter+overlap,-overlap])
            cube([cord_diameter,cord_diameter*2,PCW_thickness+(overlap*2)]);
        }
    }
}

module PCW_middle(){
    difference(){
        translate([cord_diameter/2,0,0])
    cube([cord_diameter*4,cord_wrap_length,PCW_thickness]);
    rotate([0,0,90])
    translate([cord_wrap_length/2,-cord_diameter*3.5,PCW_thickness/2])
        linear_extrude(height=(PCW_thickness/2)+overlap){
    text(name, font = font,halign="center", size = cord_diameter*2);
        }
    }
}

module PCW_whole(){
    union(){
        PCW_endcap();
        translate([0,cord_diameter*5-overlap,0])
        PCW_middle();
        mirror([0,1,0])
        mirror([1,0,0])
        translate([-cord_diameter*5,-((cord_diameter*10)+cord_wrap_length-overlap),0])
        PCW_endcap();
    }
}

PCW_whole();