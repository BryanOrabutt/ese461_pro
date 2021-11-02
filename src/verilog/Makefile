#====================================================================================================
# Description:                 MakeFile
#                              
# Author:                      Bryan Orabutt, Washington University in St. Louis
#                              
# Email:                       borabutt@wustl.edu
#                             
# Version:                     1.00
#
# Rev History:  
#       <Author>        <Date>        <Hardware>     <Version>        <Description>
#    Bryan Orabutt   09/06/2019 11:22     --            1.00             Create
#====================================================================================================
srcdir = ./modules/
tbdir = ./test_bench/
src = $(shell find $(srcdir) -name '*.v')

vcs_flag = -full64 -PP +lint=all,noVCDE +v2k -sverilog -timescale=1ns/10ps

all: divide activation

divide: $(srcdir)divide.v $(tbdir)divide_tb.v
	vcs $(vcs_flag) $^
	./simv +verbose=1

activation: $(srcdir)divide.v $(srcdir)activation.v $(tbdir)activation_tb.v 
	vcs $(vcs_flag) $^
	./simv +verbose=1

network: $(src) $(tbdir)network_tb.v
	vcs $(vcs_flag) $^
	./simv +verbose=1

run: simv
	./simv +verbose=1

.PHONY: clean
clean : 
	rm -rf csrc
	rm -f simv
	rm -rf simv.daidir
	rm -f ./vcd/*.vcd
	rm -f ucli.key
	rm -f *.vcd.vpd
