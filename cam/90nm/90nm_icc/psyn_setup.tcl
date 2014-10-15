########## Boilerplate ##########################################
# Script to setup libraries and read the synthesized netlist
#################################################################




set SynopsysInstall [getenv "SYNOPSYS"]

# Next line defines the location of the standard cell libraries. Std.
# Cells can be aligned in datapaths between power and ground rails. So
# AND, XOR, NOR etc., all have at least one matching dimension.

set stdcellhome /sim/synopsys/SAED_EDK90nm/Digital_Standard_Cell_Library/

# The design library is used by design compiler to performance logic
# optimations.  Technology libraries contain information about the
# characteristics and functions of each cell provided in a semiconductor
# vendors library. Semiconductor vendors maintain and distribute
# the technology libraries. In our case the vendor is Synopsys. Cell
# characteristics include information such as cell names, pin names,
# area, delay arcs, and pin loading. The technology library also defines
# the conditions that must be met for a functional design (for example,
# the maximum transition time for nets).  These conditions are called
# design rule constraints. In addition to cell information and design rule
# constraints, technology libraries specify the operating conditions and
# wire load models specific to that technology. 

set design_db  $stdcellhome/synopsys/models/saed90nm_typ.db

# The next few includes contains backend process parameters. For instance,
# it includes detailed information about the poly and metal layers
# in the  design and the standard cell layouts.  These libraries also
# contain logical information (functionality and timing characteristics)
# for every cell in the library.  Finally, libraries contain technology
# information required for design and fabrication.  

# In a Milkyway library below you will find different views for each
# cell, for example, NOR1.CEL and NOR1.FRAM. CEL is the full layout view,
# and FRAM is the abstract view for place and route operation


# tf - Vendor Technology File. This file contains technology-specific
# information such as the names, characteristics (physical and electrical)
# for each metal layer, and design rules. These information are required
# to route a design.

set mapf       $stdcellhome/process/star_rcxt/saed90nm.map


# TLUPlus models are a set of models containing advanced process ects 
# that can be used by the parasitic extractors in Synopsys place-and-route
# tools. These files are used for extracting parasitics from the 
# design. They are created from the tf file using other synopsys tools.

set max_tlu    $stdcellhome/process/star_rcxt/tluplus/saed90nm_1p9m_1t_Cmax.tluplus
set min_tlu    $stdcellhome/process/star_rcxt/tluplus/saed90nm_1p9m_1t_Cmin.tluplus

set search_path [list . [format "%s%s" $SynopsysInstall /dw/sim_ver]]
set target_library  $design_db
set synthetic_library /local/sim/synopsys64/icc/libraries/syn/dw_foundation.sldb
set link_library [concat [concat "*" $target_library] $synthetic_library]
set symbol_library [list generic.sdb]


set basename cam                     ;# Top-level module name
set CLK "clk"                  ;# The name of your clock 

# In a Milkyway library below you will find different views for each
# cell, for example, NOR1.CEL and NOR1.FRAM. CEL is the full layout view,
# and FRAM is the abstract view for place and route operation
# Read the milkyway library created during synthesis
#set MW_LIB_NAME [format "%s%s" $basename "_LIB"]
set MW_LIB_NAME [format "%s%s" $basename "_LIB"]
open_mw_lib cam_LIB
check_library
set_tlu_plus_file -max_tluplus $max_tlu -min_tluplus $min_tlu -tech2itf_map $mapf
check_tlu_plus_files

# Start Physical Synthesis

# Read the synthesized design back into ICC. Specify the top level module
# and save the designs again in milkyway format.
import_designs cam_synth.ddc -format ddc -top cam -cel cam

