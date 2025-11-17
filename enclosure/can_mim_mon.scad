//
// CAN MIM MON basic two-piece enclosure.  I ain't no mechanical engineer
// so the emphasis is on "basic" ...
//
// Units are mm
//

// ================================================================================
// Set render mode to select which part of the case to display/export
//   1 : Bottom
//   2 : Top
//   3 : Both parts
render = 3;



// ================================================================================
// Enclosure Dimensions
//

pcb_width = 2.75 * 25.4;  // Inches to mm
pcb_depth = 1.9 * 25.4;
pcb_height = 1.6;
pcb_assy_height = 17;      // Components on top

under_pcb_standoff_h = 3;

wall_thickness = 1.5;

mounting_screw_head_d = 6;
mounting_screw_head_h = 2;
mounting_screw_hole_d = 2.5;
standoff_d = mounting_screw_hole_d + 3.5;

enc_width = pcb_width + 2 + 2*wall_thickness;
enc_depth = pcb_depth + 2 + 2*wall_thickness;
enc_base_height = mounting_screw_head_h + 2;
enc_lid_height = under_pcb_standoff_h + pcb_height + pcb_assy_height + 1;

enc_base_wing_hole_d = 3;

// The base is longer than the enclosure for some mounting wings
base_wing_width = 10;
base_width = enc_width + 2 * base_wing_width;
base_screw_delta_x = base_width - base_wing_width; // half-way in wing
base_screw_delta_y = enc_depth - 20;

// PCB Screw mount (PCB is centered)
pcb_screw_delta_w = 2.45 * 25.4;
pcb_screw_delta_d = 1.6 * 25.4;

// Enclosure lid cutouts for wire access
//
// Left and Right
conn_12_x_offset = 0.4 * 25.4;
conn_12_y_offset = 0.5 * 25.4;

// Top Row
conn_3_x_offset = 0.55 * 25.4;
conn_4_x_offset = 1.375 * 25.4;
conn_5_x_offset = 2.2 * 25.4;
cont_345_y_offset = 1.5 * 25.4;

conn_cutout_w = 10;
conn_cutout_d = 13;  // Relative to PCB Edge



// ================================================================================
// Sub-modules
//
module enc_lid_standoff(x, y) {
    height = enc_lid_height - (under_pcb_standoff_h + pcb_height);
    
    translate([x, y, 0]) {
        difference()
        {
            cylinder(d=standoff_d, h=height, $fn=120);
            
            translate([0, 0, height-9]) {
                cylinder(d=mounting_screw_hole_d, h=9.1, $fn=120);
            }
        }
    }
}


//
// orientation = 1 for left side
// orientation = 2 for right side
// orientation = 3, 4, 5 for top row
module enc_lid_conn_cutout(orientation) {
    h = enc_lid_height - (pcb_height + under_pcb_standoff_h);
    
    if (orientation == 1) {
        x = -0.1;
        y = enc_depth - (enc_depth - pcb_depth)/2 - (conn_12_y_offset + conn_cutout_w/2);
        w = (enc_width - pcb_width)/2 + conn_cutout_d;
        d = conn_cutout_w;
        
        translate([x, y, -0.1]) {
            cube([w, d, h]);
        }
    }
    
    if (orientation == 2) {
        x = enc_width - (enc_width - pcb_width)/2 - conn_cutout_d + 0.1;
        y = enc_depth - (enc_depth - pcb_depth)/2 - (conn_12_y_offset + conn_cutout_w/2);
        w = (enc_width - pcb_width)/2 + conn_cutout_d;
        d = conn_cutout_w;
        
        translate([x, y, -0.1]) {
            cube([w, d, h]);
        }
    }
    
    if (orientation == 3) {
        x = (enc_width - pcb_width)/2 + (conn_3_x_offset - conn_cutout_w/2);
        y = -0.1;
        w = conn_cutout_w;
        d = (enc_depth - pcb_depth)/2 + conn_cutout_d;
        
        translate([x, y, -0.1]) {
            cube([w, d, h]);
        }
    }
    
    if (orientation == 4) {
        x = (enc_width - pcb_width)/2 + (conn_4_x_offset - conn_cutout_w/2);
        y = -0.1;
        w = conn_cutout_w;
        d = (enc_depth - pcb_depth)/2 + conn_cutout_d;
        
        translate([x, y, -0.1]) {
            cube([w, d, h]);
        }
    }
    
    if (orientation == 5) {
        x = (enc_width - pcb_width)/2 + (conn_5_x_offset - conn_cutout_w/2);
        y = -0.1;
        w = conn_cutout_w;
        d = (enc_depth - pcb_depth)/2 + conn_cutout_d;
        
        translate([x, y, -0.1]) {
            cube([w, d, h]);
        }
    }
}



// ================================================================================
// Components
//
module base() {
    difference() {
        union() {
            // Base
            cube([base_width, enc_depth, enc_base_height]);
            
            // Standoffs
            translate([base_wing_width, 0, -0.1]) {
                x = (enc_width - pcb_screw_delta_w) / 2;
                y = (enc_depth - pcb_screw_delta_d) / 2;
                translate([x, y, 0]) {
                    cylinder(d=standoff_d, h=enc_base_height+under_pcb_standoff_h, $fn=120);
                }
                 translate([x + pcb_screw_delta_w, y, 0]) {
                    cylinder(d=standoff_d, h=enc_base_height+under_pcb_standoff_h, $fn=120);
                }
                translate([x, y + pcb_screw_delta_d, 0]) {
                    cylinder(d=standoff_d, h=enc_base_height+under_pcb_standoff_h, $fn=120);
                }
                 translate([x + pcb_screw_delta_w, y + pcb_screw_delta_d, 0]) {
                    cylinder(d=standoff_d, h=enc_base_height+under_pcb_standoff_h, $fn=120);
                }
            }
        }
        
        // Base wing screw holes
        x = base_wing_width/2;
        y = (enc_depth - base_screw_delta_y)/2;
        translate([x, y, -0.1]) {
            cylinder(d=enc_base_wing_hole_d, h=enc_base_height + 0.2, $fn=120);
        }
        translate([x, y + base_screw_delta_y, -0.1]) {
            cylinder(d=enc_base_wing_hole_d, h=enc_base_height + 0.2, $fn=120);
        }
        translate([x + base_screw_delta_x, y, -0.1]) {
            cylinder(d=enc_base_wing_hole_d, h=enc_base_height + 0.2, $fn=120);
        }
        translate([x + base_screw_delta_x, y + base_screw_delta_y, -0.1]) {
            cylinder(d=enc_base_wing_hole_d, h=enc_base_height + 0.2, $fn=120);
        }
        
        // Enclosure lid screw holes
        translate([base_wing_width, 0, -0.1]) {
            x = (enc_width - pcb_screw_delta_w) / 2;
            y = (enc_depth - pcb_screw_delta_d) / 2;
            translate([x, y, -0.1]) {
                // Screw head hole
                cylinder(d=mounting_screw_head_d, h=mounting_screw_head_h+0.1, $fn=120);
                
                // Screw hole
                cylinder(d=mounting_screw_hole_d, h=enc_base_height+under_pcb_standoff_h+0.2, $fn=120);
            }
            translate([x + pcb_screw_delta_w, y, -0.1]) {
                cylinder(d=mounting_screw_head_d, h=mounting_screw_head_h+0.1, $fn=120);
                cylinder(d=mounting_screw_hole_d, h=enc_base_height+under_pcb_standoff_h+0.2, $fn=120);
            }
            translate([x, y + pcb_screw_delta_d, -0.1]) {
                cylinder(d=mounting_screw_head_d, h=mounting_screw_head_h+0.1, $fn=120);
                cylinder(d=mounting_screw_hole_d, h=enc_base_height+under_pcb_standoff_h+0.2, $fn=120);
            }
            translate([x + pcb_screw_delta_w, y + pcb_screw_delta_d, -0.1]) {
                cylinder(d=mounting_screw_head_d, h=mounting_screw_head_h+0.1, $fn=120);
                cylinder(d=mounting_screw_hole_d, h=enc_base_height+under_pcb_standoff_h+0.2, $fn=120);
            }
        }
    }
}


module lid() {
    difference() {
        union() {
            // Hollow Box
            difference() {
                cube([enc_width, enc_depth, enc_lid_height]);
                
                translate([wall_thickness, wall_thickness, wall_thickness]) {
                    cube([enc_width - 2 * wall_thickness, enc_depth - 2 * wall_thickness, enc_lid_height]);
                }
            }
            
            // Standoffs
            x = (enc_width - pcb_screw_delta_w) / 2;
            y = (enc_depth - pcb_screw_delta_d) / 2;
            enc_lid_standoff(x, y);
            enc_lid_standoff(x + pcb_screw_delta_w, y);
            enc_lid_standoff(x, y + pcb_screw_delta_d);
            enc_lid_standoff(x + pcb_screw_delta_w, y + pcb_screw_delta_d);
        }
        
        // Cutouts for access to connectors
        enc_lid_conn_cutout(1);
        enc_lid_conn_cutout(2);
        enc_lid_conn_cutout(3);
        enc_lid_conn_cutout(4);
        enc_lid_conn_cutout(5);
    }
}



// ================================================================================
// Render control
//

if (render == 1) {
    base();
}

if (render == 2) {
    lid();
}

if (render == 3) {
    base();
    
    translate([base_wing_width, enc_depth, enc_base_height + enc_lid_height]) {
        rotate([180, 0, 0]) {
            lid();
        }
    }
}
