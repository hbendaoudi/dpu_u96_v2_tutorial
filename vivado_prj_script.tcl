# Set the project directory 
set project_dir [exec pwd]

# Set the project name
set proj_name "dpu_u96_v2"

start_gui
create_project ${proj_name} ${project_dir}/${proj_name}/ -part xczu3eg-sbva484-1-e

# Set the board to the Avnet Ultra96-v2
# If the board is not found, make sure to download the board files from avnet repo on github and add it to the vivado installation folder
set_property board_part em.avnet.com:ultra96v2:part0:1.0 [current_project]

set_property  ip_repo_paths  ${project_dir}/dpu_ip [current_project]
update_ip_catalog

# Source the block diagram creation script
source ${project_dir}/dpu_u96_tcl_2019_2.tcl

update_compile_order -fileset sources_1

# Create an hdl wrapper and add it as source files
make_wrapper -files [get_files ${project_dir}/${proj_name}/${proj_name}.srcs/sources_1/bd/dpu_u96_design/dpu_u96_design.bd] -top

add_files -norecurse ${project_dir}/${proj_name}/${proj_name}.srcs/sources_1/bd/dpu_u96_design/hdl/dpu_u96_design_wrapper.v

