module single_port_ram( data, addr, we, clk, q);
    input [15:0] data;
    input [2:0] addr;
    input we;
    input clk;
    output reg [15:0] q;

    reg [15:0] ram [0:127];

    always @(posedge clk) begin
      if (we) begin
        ram [addr] <= data;
        q <= 0;
      end
      else q <= ram [addr];
    end

endmodule //single_port_ram 

module single_port_ram_w( data, addr, we, clk, q);
    input [15:0] data;
    input [2:0] addr;
	input [6:0] offset;
    input we;
    input clk;
    output reg [15:0] q;

    reg [15:0] ram [0:127];

    always @(posedge clk) begin
      if (we) begin
        ram [addr] <= data;
        q <= 0;
      end
      else q <= ram [addr];
    end

endmodule //single_port_ram 


module top_tb ();
  wire [15:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15,
                 I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31,
                 I32, I33, I34, I35, I36, I37, I38, I39, I40, I41, I42, I43, I44, I45, I46, I47,
                 I48, I49, I50, I51, I52, I53, I54, I55, I56, I57, I58, I59, I60, I61, I62, I63,
                 I64, I65, I66, I67, I68, I69, I70, I71, I72, I73, I74, I75, I76, I77, I78, I79,
                 I80, I81, I82, I83, I84, I85, I86, I87, I88, I89, I90, I91, I92, I93, I94, I95,
                 I96, I97, I98, I99, I100, I101, I102, I103, I104, I105, I106, I107, I108, I109, I110, I111,
                 I112, I113, I114, I115, I116, I117, I118, I119, I120, I121, I122, I123, I124, I125, I126, I127;
  wire [15:0] W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14, W15,
                 W16, W17, W18, W19, W20, W21, W22, W23, W24, W25, W26, W27, W28, W29, W30, W31,
                 W32, W33, W34, W35, W36, W37, W38, W39, W40, W41, W42, W43, W44, W45, W46, W47,
                 W48, W49, W50, W51, W52, W53, W54, W55, W56, W57, W58, W59, W60, W61, W62, W63,
                 W64, W65, W66, W67, W68, W69, W70, W71, W72, W73, W74, W75, W76, W77, W78, W79,
                 W80, W81, W82, W83, W84, W85, W86, W87, W88, W89, W90, W91, W92, W93, W94, W95,
                 W96, W97, W98, W99, W100, W101, W102, W103, W104, W105, W106, W107, W108, W109, W110, W111,
                 W112, W113, W114, W115, W116, W117, W118, W119, W120, W121, W122, W123, W124, W125, W126, W127;
  reg[31:0] OUTPUT0, OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4, OUTPUT5, OUTPUT6, OUTPUT7, OUTPUT8, OUTPUT9, OUTPUT10, OUTPUT11, OUTPUT12, OUTPUT13, OUTPUT14, OUTPUT15,
                 OUTPUT16, OUTPUT17, OUTPUT18, OUTPUT19, OUTPUT20, OUTPUT21, OUTPUT22, OUTPUT23, OUTPUT24, OUTPUT25, OUTPUT26, OUTPUT27, OUTPUT28, OUTPUT29, OUTPUT30, OUTPUT31,
                 OUTPUT32, OUTPUT33, OUTPUT34, OUTPUT35, OUTPUT36, OUTPUT37, OUTPUT38, OUTPUT39, OUTPUT40, OUTPUT41, OUTPUT42, OUTPUT43, OUTPUT44, OUTPUT45, OUTPUT46, OUTPUT47,
                 OUTPUT48, OUTPUT49, OUTPUT50, OUTPUT51, OUTPUT52, OUTPUT53, OUTPUT54, OUTPUT55, OUTPUT56, OUTPUT57, OUTPUT58, OUTPUT59, OUTPUT60, OUTPUT61, OUTPUT62, OUTPUT63,
                 OUTPUT64, OUTPUT65, OUTPUT66, OUTPUT67, OUTPUT68, OUTPUT69, OUTPUT70, OUTPUT71, OUTPUT72, OUTPUT73, OUTPUT74, OUTPUT75, OUTPUT76, OUTPUT77, OUTPUT78, OUTPUT79,
                 OUTPUT80, OUTPUT81, OUTPUT82, OUTPUT83, OUTPUT84, OUTPUT85, OUTPUT86, OUTPUT87, OUTPUT88, OUTPUT89, OUTPUT90, OUTPUT91, OUTPUT92, OUTPUT93, OUTPUT94, OUTPUT95,
                 OUTPUT96, OUTPUT97, OUTPUT98, OUTPUT99, OUTPUT100, OUTPUT101, OUTPUT102, OUTPUT103, OUTPUT104, OUTPUT105, OUTPUT106, OUTPUT107, OUTPUT108, OUTPUT109, OUTPUT110, OUTPUT111,
                 OUTPUT112, OUTPUT113, OUTPUT114, OUTPUT115, OUTPUT116, OUTPUT117, OUTPUT118, OUTPUT119, OUTPUT120, OUTPUT121, OUTPUT122, OUTPUT123, OUTPUT124, OUTPUT125, OUTPUT126, OUTPUT127;
  reg [31:0] partial_sum;
  wire[2:0] weight_addr, input_addr;
  wire[6:0] weight_offset;
  
  top network(.I0(I0), .W0(W0), .OUTPUT0(OUTPUT0), 
.I1(I1), .W1(W1), .OUTPUT1(OUTPUT1), 
.I2(I2), .W2(W2), .OUTPUT2(OUTPUT2), 
.I3(I3), .W3(W3), .OUTPUT3(OUTPUT3), 
.I4(I4), .W4(W4), .OUTPUT4(OUTPUT4), 
.I5(I5), .W5(W5), .OUTPUT5(OUTPUT5), 
.I6(I6), .W6(W6), .OUTPUT6(OUTPUT6), 
.I7(I7), .W7(W7), .OUTPUT7(OUTPUT7), 
.I8(I8), .W8(W8), .OUTPUT8(OUTPUT8), 
.I9(I9), .W9(W9), .OUTPUT9(OUTPUT9), 
.I10(I10), .W10(W10), .OUTPUT10(OUTPUT10), 
.I11(I11), .W11(W11), .OUTPUT11(OUTPUT11), 
.I12(I12), .W12(W12), .OUTPUT12(OUTPUT12), 
.I13(I13), .W13(W13), .OUTPUT13(OUTPUT13), 
.I14(I14), .W14(W14), .OUTPUT14(OUTPUT14), 
.I15(I15), .W15(W15), .OUTPUT15(OUTPUT15), 
.I16(I16), .W16(W16), .OUTPUT16(OUTPUT16), 
.I17(I17), .W17(W17), .OUTPUT17(OUTPUT17), 
.I18(I18), .W18(W18), .OUTPUT18(OUTPUT18), 
.I19(I19), .W19(W19), .OUTPUT19(OUTPUT19), 
.I20(I20), .W20(W20), .OUTPUT20(OUTPUT20), 
.I21(I21), .W21(W21), .OUTPUT21(OUTPUT21), 
.I22(I22), .W22(W22), .OUTPUT22(OUTPUT22), 
.I23(I23), .W23(W23), .OUTPUT23(OUTPUT23), 
.I24(I24), .W24(W24), .OUTPUT24(OUTPUT24), 
.I25(I25), .W25(W25), .OUTPUT25(OUTPUT25), 
.I26(I26), .W26(W26), .OUTPUT26(OUTPUT26), 
.I27(I27), .W27(W27), .OUTPUT27(OUTPUT27), 
.I28(I28), .W28(W28), .OUTPUT28(OUTPUT28), 
.I29(I29), .W29(W29), .OUTPUT29(OUTPUT29), 
.I30(I30), .W30(W30), .OUTPUT30(OUTPUT30), 
.I31(I31), .W31(W31), .OUTPUT31(OUTPUT31), 
.I32(I32), .W32(W32), .OUTPUT32(OUTPUT32), 
.I33(I33), .W33(W33), .OUTPUT33(OUTPUT33), 
.I34(I34), .W34(W34), .OUTPUT34(OUTPUT34), 
.I35(I35), .W35(W35), .OUTPUT35(OUTPUT35), 
.I36(I36), .W36(W36), .OUTPUT36(OUTPUT36), 
.I37(I37), .W37(W37), .OUTPUT37(OUTPUT37), 
.I38(I38), .W38(W38), .OUTPUT38(OUTPUT38), 
.I39(I39), .W39(W39), .OUTPUT39(OUTPUT39), 
.I40(I40), .W40(W40), .OUTPUT40(OUTPUT40), 
.I41(I41), .W41(W41), .OUTPUT41(OUTPUT41), 
.I42(I42), .W42(W42), .OUTPUT42(OUTPUT42), 
.I43(I43), .W43(W43), .OUTPUT43(OUTPUT43), 
.I44(I44), .W44(W44), .OUTPUT44(OUTPUT44), 
.I45(I45), .W45(W45), .OUTPUT45(OUTPUT45), 
.I46(I46), .W46(W46), .OUTPUT46(OUTPUT46), 
.I47(I47), .W47(W47), .OUTPUT47(OUTPUT47), 
.I48(I48), .W48(W48), .OUTPUT48(OUTPUT48), 
.I49(I49), .W49(W49), .OUTPUT49(OUTPUT49), 
.I50(I50), .W50(W50), .OUTPUT50(OUTPUT50), 
.I51(I51), .W51(W51), .OUTPUT51(OUTPUT51), 
.I52(I52), .W52(W52), .OUTPUT52(OUTPUT52), 
.I53(I53), .W53(W53), .OUTPUT53(OUTPUT53), 
.I54(I54), .W54(W54), .OUTPUT54(OUTPUT54), 
.I55(I55), .W55(W55), .OUTPUT55(OUTPUT55), 
.I56(I56), .W56(W56), .OUTPUT56(OUTPUT56), 
.I57(I57), .W57(W57), .OUTPUT57(OUTPUT57), 
.I58(I58), .W58(W58), .OUTPUT58(OUTPUT58), 
.I59(I59), .W59(W59), .OUTPUT59(OUTPUT59), 
.I60(I60), .W60(W60), .OUTPUT60(OUTPUT60), 
.I61(I61), .W61(W61), .OUTPUT61(OUTPUT61), 
.I62(I62), .W62(W62), .OUTPUT62(OUTPUT62), 
.I63(I63), .W63(W63), .OUTPUT63(OUTPUT63), 
.I64(I64), .W64(W64), .OUTPUT64(OUTPUT64), 
.I65(I65), .W65(W65), .OUTPUT65(OUTPUT65), 
.I66(I66), .W66(W66), .OUTPUT66(OUTPUT66), 
.I67(I67), .W67(W67), .OUTPUT67(OUTPUT67), 
.I68(I68), .W68(W68), .OUTPUT68(OUTPUT68), 
.I69(I69), .W69(W69), .OUTPUT69(OUTPUT69), 
.I70(I70), .W70(W70), .OUTPUT70(OUTPUT70), 
.I71(I71), .W71(W71), .OUTPUT71(OUTPUT71), 
.I72(I72), .W72(W72), .OUTPUT72(OUTPUT72), 
.I73(I73), .W73(W73), .OUTPUT73(OUTPUT73), 
.I74(I74), .W74(W74), .OUTPUT74(OUTPUT74), 
.I75(I75), .W75(W75), .OUTPUT75(OUTPUT75), 
.I76(I76), .W76(W76), .OUTPUT76(OUTPUT76), 
.I77(I77), .W77(W77), .OUTPUT77(OUTPUT77), 
.I78(I78), .W78(W78), .OUTPUT78(OUTPUT78), 
.I79(I79), .W79(W79), .OUTPUT79(OUTPUT79), 
.I80(I80), .W80(W80), .OUTPUT80(OUTPUT80), 
.I81(I81), .W81(W81), .OUTPUT81(OUTPUT81), 
.I82(I82), .W82(W82), .OUTPUT82(OUTPUT82), 
.I83(I83), .W83(W83), .OUTPUT83(OUTPUT83), 
.I84(I84), .W84(W84), .OUTPUT84(OUTPUT84), 
.I85(I85), .W85(W85), .OUTPUT85(OUTPUT85), 
.I86(I86), .W86(W86), .OUTPUT86(OUTPUT86), 
.I87(I87), .W87(W87), .OUTPUT87(OUTPUT87), 
.I88(I88), .W88(W88), .OUTPUT88(OUTPUT88), 
.I89(I89), .W89(W89), .OUTPUT89(OUTPUT89), 
.I90(I90), .W90(W90), .OUTPUT90(OUTPUT90), 
.I91(I91), .W91(W91), .OUTPUT91(OUTPUT91), 
.I92(I92), .W92(W92), .OUTPUT92(OUTPUT92), 
.I93(I93), .W93(W93), .OUTPUT93(OUTPUT93), 
.I94(I94), .W94(W94), .OUTPUT94(OUTPUT94), 
.I95(I95), .W95(W95), .OUTPUT95(OUTPUT95), 
.I96(I96), .W96(W96), .OUTPUT96(OUTPUT96), 
.I97(I97), .W97(W97), .OUTPUT97(OUTPUT97), 
.I98(I98), .W98(W98), .OUTPUT98(OUTPUT98), 
.I99(I99), .W99(W99), .OUTPUT99(OUTPUT99), 
.I100(I100), .W100(W100), .OUTPUT100(OUTPUT100), 
.I101(I101), .W101(W101), .OUTPUT101(OUTPUT101), 
.I102(I102), .W102(W102), .OUTPUT102(OUTPUT102), 
.I103(I103), .W103(W103), .OUTPUT103(OUTPUT103), 
.I104(I104), .W104(W104), .OUTPUT104(OUTPUT104), 
.I105(I105), .W105(W105), .OUTPUT105(OUTPUT105), 
.I106(I106), .W106(W106), .OUTPUT106(OUTPUT106), 
.I107(I107), .W107(W107), .OUTPUT107(OUTPUT107), 
.I108(I108), .W108(W108), .OUTPUT108(OUTPUT108), 
.I109(I109), .W109(W109), .OUTPUT109(OUTPUT109), 
.I110(I110), .W110(W110), .OUTPUT110(OUTPUT110), 
.I111(I111), .W111(W111), .OUTPUT111(OUTPUT111), 
.I112(I112), .W112(W112), .OUTPUT112(OUTPUT112), 
.I113(I113), .W113(W113), .OUTPUT113(OUTPUT113), 
.I114(I114), .W114(W114), .OUTPUT114(OUTPUT114), 
.I115(I115), .W115(W115), .OUTPUT115(OUTPUT115), 
.I116(I116), .W116(W116), .OUTPUT116(OUTPUT116), 
.I117(I117), .W117(W117), .OUTPUT117(OUTPUT117), 
.I118(I118), .W118(W118), .OUTPUT118(OUTPUT118), 
.I119(I119), .W119(W119), .OUTPUT119(OUTPUT119), 
.I120(I120), .W120(W120), .OUTPUT120(OUTPUT120), 
.I121(I121), .W121(W121), .OUTPUT121(OUTPUT121), 
.I122(I122), .W122(W122), .OUTPUT122(OUTPUT122), 
.I123(I123), .W123(W123), .OUTPUT123(OUTPUT123), 
.I124(I124), .W124(W124), .OUTPUT124(OUTPUT124), 
.I125(I125), .W125(W125), .OUTPUT125(OUTPUT125), 
.I126(I126), .W126(W126), .OUTPUT126(OUTPUT126), 
.I127(I127), .W127(W127), .OUTPUT127(OUTPUT127), 
.clk(clk), .rst(rst), .input_addr(addr), .weight_addr(addr_w), .weight_offset(offset));
  
single_port_ram SRAM0(.data(I0), .addr(addr), .we(we), .clk(clk), .q(q_I0));
single_port_ram_w SRAM_w0(.data(W0), .addr(addr_w), .we(we), .clk(clk), .q(q_W0), .offset(offset));
single_port_ram SRAM1(.data(I1), .addr(addr), .we(we), .clk(clk), .q(q_I1));
single_port_ram_w SRAM_w1(.data(W1), .addr(addr_w), .we(we), .clk(clk), .q(q_W1), .offset(offset));
single_port_ram SRAM2(.data(I2), .addr(addr), .we(we), .clk(clk), .q(q_I2));
single_port_ram_w SRAM_w2(.data(W2), .addr(addr_w), .we(we), .clk(clk), .q(q_W2), .offset(offset));
single_port_ram SRAM3(.data(I3), .addr(addr), .we(we), .clk(clk), .q(q_I3));
single_port_ram_w SRAM_w3(.data(W3), .addr(addr_w), .we(we), .clk(clk), .q(q_W3), .offset(offset));
single_port_ram SRAM4(.data(I4), .addr(addr), .we(we), .clk(clk), .q(q_I4));
single_port_ram_w SRAM_w4(.data(W4), .addr(addr_w), .we(we), .clk(clk), .q(q_W4), .offset(offset));
single_port_ram SRAM5(.data(I5), .addr(addr), .we(we), .clk(clk), .q(q_I5));
single_port_ram_w SRAM_w5(.data(W5), .addr(addr_w), .we(we), .clk(clk), .q(q_W5), .offset(offset));
single_port_ram SRAM6(.data(I6), .addr(addr), .we(we), .clk(clk), .q(q_I6));
single_port_ram_w SRAM_w6(.data(W6), .addr(addr_w), .we(we), .clk(clk), .q(q_W6), .offset(offset));
single_port_ram SRAM7(.data(I7), .addr(addr), .we(we), .clk(clk), .q(q_I7));
single_port_ram_w SRAM_w7(.data(W7), .addr(addr_w), .we(we), .clk(clk), .q(q_W7), .offset(offset));
single_port_ram SRAM8(.data(I8), .addr(addr), .we(we), .clk(clk), .q(q_I8));
single_port_ram_w SRAM_w8(.data(W8), .addr(addr_w), .we(we), .clk(clk), .q(q_W8), .offset(offset));
single_port_ram SRAM9(.data(I9), .addr(addr), .we(we), .clk(clk), .q(q_I9));
single_port_ram_w SRAM_w9(.data(W9), .addr(addr_w), .we(we), .clk(clk), .q(q_W9), .offset(offset));
single_port_ram SRAM10(.data(I10), .addr(addr), .we(we), .clk(clk), .q(q_I10));
single_port_ram_w SRAM_w10(.data(W10), .addr(addr_w), .we(we), .clk(clk), .q(q_W10), .offset(offset));
single_port_ram SRAM11(.data(I11), .addr(addr), .we(we), .clk(clk), .q(q_I11));
single_port_ram_w SRAM_w11(.data(W11), .addr(addr_w), .we(we), .clk(clk), .q(q_W11), .offset(offset));
single_port_ram SRAM12(.data(I12), .addr(addr), .we(we), .clk(clk), .q(q_I12));
single_port_ram_w SRAM_w12(.data(W12), .addr(addr_w), .we(we), .clk(clk), .q(q_W12), .offset(offset));
single_port_ram SRAM13(.data(I13), .addr(addr), .we(we), .clk(clk), .q(q_I13));
single_port_ram_w SRAM_w13(.data(W13), .addr(addr_w), .we(we), .clk(clk), .q(q_W13), .offset(offset));
single_port_ram SRAM14(.data(I14), .addr(addr), .we(we), .clk(clk), .q(q_I14));
single_port_ram_w SRAM_w14(.data(W14), .addr(addr_w), .we(we), .clk(clk), .q(q_W14), .offset(offset));
single_port_ram SRAM15(.data(I15), .addr(addr), .we(we), .clk(clk), .q(q_I15));
single_port_ram_w SRAM_w15(.data(W15), .addr(addr_w), .we(we), .clk(clk), .q(q_W15), .offset(offset));
single_port_ram SRAM16(.data(I16), .addr(addr), .we(we), .clk(clk), .q(q_I16));
single_port_ram_w SRAM_w16(.data(W16), .addr(addr_w), .we(we), .clk(clk), .q(q_W16), .offset(offset));
single_port_ram SRAM17(.data(I17), .addr(addr), .we(we), .clk(clk), .q(q_I17));
single_port_ram_w SRAM_w17(.data(W17), .addr(addr_w), .we(we), .clk(clk), .q(q_W17), .offset(offset));
single_port_ram SRAM18(.data(I18), .addr(addr), .we(we), .clk(clk), .q(q_I18));
single_port_ram_w SRAM_w18(.data(W18), .addr(addr_w), .we(we), .clk(clk), .q(q_W18), .offset(offset));
single_port_ram SRAM19(.data(I19), .addr(addr), .we(we), .clk(clk), .q(q_I19));
single_port_ram_w SRAM_w19(.data(W19), .addr(addr_w), .we(we), .clk(clk), .q(q_W19), .offset(offset));
single_port_ram SRAM20(.data(I20), .addr(addr), .we(we), .clk(clk), .q(q_I20));
single_port_ram_w SRAM_w20(.data(W20), .addr(addr_w), .we(we), .clk(clk), .q(q_W20), .offset(offset));
single_port_ram SRAM21(.data(I21), .addr(addr), .we(we), .clk(clk), .q(q_I21));
single_port_ram_w SRAM_w21(.data(W21), .addr(addr_w), .we(we), .clk(clk), .q(q_W21), .offset(offset));
single_port_ram SRAM22(.data(I22), .addr(addr), .we(we), .clk(clk), .q(q_I22));
single_port_ram_w SRAM_w22(.data(W22), .addr(addr_w), .we(we), .clk(clk), .q(q_W22), .offset(offset));
single_port_ram SRAM23(.data(I23), .addr(addr), .we(we), .clk(clk), .q(q_I23));
single_port_ram_w SRAM_w23(.data(W23), .addr(addr_w), .we(we), .clk(clk), .q(q_W23), .offset(offset));
single_port_ram SRAM24(.data(I24), .addr(addr), .we(we), .clk(clk), .q(q_I24));
single_port_ram_w SRAM_w24(.data(W24), .addr(addr_w), .we(we), .clk(clk), .q(q_W24), .offset(offset));
single_port_ram SRAM25(.data(I25), .addr(addr), .we(we), .clk(clk), .q(q_I25));
single_port_ram_w SRAM_w25(.data(W25), .addr(addr_w), .we(we), .clk(clk), .q(q_W25), .offset(offset));
single_port_ram SRAM26(.data(I26), .addr(addr), .we(we), .clk(clk), .q(q_I26));
single_port_ram_w SRAM_w26(.data(W26), .addr(addr_w), .we(we), .clk(clk), .q(q_W26), .offset(offset));
single_port_ram SRAM27(.data(I27), .addr(addr), .we(we), .clk(clk), .q(q_I27));
single_port_ram_w SRAM_w27(.data(W27), .addr(addr_w), .we(we), .clk(clk), .q(q_W27), .offset(offset));
single_port_ram SRAM28(.data(I28), .addr(addr), .we(we), .clk(clk), .q(q_I28));
single_port_ram_w SRAM_w28(.data(W28), .addr(addr_w), .we(we), .clk(clk), .q(q_W28), .offset(offset));
single_port_ram SRAM29(.data(I29), .addr(addr), .we(we), .clk(clk), .q(q_I29));
single_port_ram_w SRAM_w29(.data(W29), .addr(addr_w), .we(we), .clk(clk), .q(q_W29), .offset(offset));
single_port_ram SRAM30(.data(I30), .addr(addr), .we(we), .clk(clk), .q(q_I30));
single_port_ram_w SRAM_w30(.data(W30), .addr(addr_w), .we(we), .clk(clk), .q(q_W30), .offset(offset));
single_port_ram SRAM31(.data(I31), .addr(addr), .we(we), .clk(clk), .q(q_I31));
single_port_ram_w SRAM_w31(.data(W31), .addr(addr_w), .we(we), .clk(clk), .q(q_W31), .offset(offset));
single_port_ram SRAM32(.data(I32), .addr(addr), .we(we), .clk(clk), .q(q_I32));
single_port_ram_w SRAM_w32(.data(W32), .addr(addr_w), .we(we), .clk(clk), .q(q_W32), .offset(offset));
single_port_ram SRAM33(.data(I33), .addr(addr), .we(we), .clk(clk), .q(q_I33));
single_port_ram_w SRAM_w33(.data(W33), .addr(addr_w), .we(we), .clk(clk), .q(q_W33), .offset(offset));
single_port_ram SRAM34(.data(I34), .addr(addr), .we(we), .clk(clk), .q(q_I34));
single_port_ram_w SRAM_w34(.data(W34), .addr(addr_w), .we(we), .clk(clk), .q(q_W34), .offset(offset));
single_port_ram SRAM35(.data(I35), .addr(addr), .we(we), .clk(clk), .q(q_I35));
single_port_ram_w SRAM_w35(.data(W35), .addr(addr_w), .we(we), .clk(clk), .q(q_W35), .offset(offset));
single_port_ram SRAM36(.data(I36), .addr(addr), .we(we), .clk(clk), .q(q_I36));
single_port_ram_w SRAM_w36(.data(W36), .addr(addr_w), .we(we), .clk(clk), .q(q_W36), .offset(offset));
single_port_ram SRAM37(.data(I37), .addr(addr), .we(we), .clk(clk), .q(q_I37));
single_port_ram_w SRAM_w37(.data(W37), .addr(addr_w), .we(we), .clk(clk), .q(q_W37), .offset(offset));
single_port_ram SRAM38(.data(I38), .addr(addr), .we(we), .clk(clk), .q(q_I38));
single_port_ram_w SRAM_w38(.data(W38), .addr(addr_w), .we(we), .clk(clk), .q(q_W38), .offset(offset));
single_port_ram SRAM39(.data(I39), .addr(addr), .we(we), .clk(clk), .q(q_I39));
single_port_ram_w SRAM_w39(.data(W39), .addr(addr_w), .we(we), .clk(clk), .q(q_W39), .offset(offset));
single_port_ram SRAM40(.data(I40), .addr(addr), .we(we), .clk(clk), .q(q_I40));
single_port_ram_w SRAM_w40(.data(W40), .addr(addr_w), .we(we), .clk(clk), .q(q_W40), .offset(offset));
single_port_ram SRAM41(.data(I41), .addr(addr), .we(we), .clk(clk), .q(q_I41));
single_port_ram_w SRAM_w41(.data(W41), .addr(addr_w), .we(we), .clk(clk), .q(q_W41), .offset(offset));
single_port_ram SRAM42(.data(I42), .addr(addr), .we(we), .clk(clk), .q(q_I42));
single_port_ram_w SRAM_w42(.data(W42), .addr(addr_w), .we(we), .clk(clk), .q(q_W42), .offset(offset));
single_port_ram SRAM43(.data(I43), .addr(addr), .we(we), .clk(clk), .q(q_I43));
single_port_ram_w SRAM_w43(.data(W43), .addr(addr_w), .we(we), .clk(clk), .q(q_W43), .offset(offset));
single_port_ram SRAM44(.data(I44), .addr(addr), .we(we), .clk(clk), .q(q_I44));
single_port_ram_w SRAM_w44(.data(W44), .addr(addr_w), .we(we), .clk(clk), .q(q_W44), .offset(offset));
single_port_ram SRAM45(.data(I45), .addr(addr), .we(we), .clk(clk), .q(q_I45));
single_port_ram_w SRAM_w45(.data(W45), .addr(addr_w), .we(we), .clk(clk), .q(q_W45), .offset(offset));
single_port_ram SRAM46(.data(I46), .addr(addr), .we(we), .clk(clk), .q(q_I46));
single_port_ram_w SRAM_w46(.data(W46), .addr(addr_w), .we(we), .clk(clk), .q(q_W46), .offset(offset));
single_port_ram SRAM47(.data(I47), .addr(addr), .we(we), .clk(clk), .q(q_I47));
single_port_ram_w SRAM_w47(.data(W47), .addr(addr_w), .we(we), .clk(clk), .q(q_W47), .offset(offset));
single_port_ram SRAM48(.data(I48), .addr(addr), .we(we), .clk(clk), .q(q_I48));
single_port_ram_w SRAM_w48(.data(W48), .addr(addr_w), .we(we), .clk(clk), .q(q_W48), .offset(offset));
single_port_ram SRAM49(.data(I49), .addr(addr), .we(we), .clk(clk), .q(q_I49));
single_port_ram_w SRAM_w49(.data(W49), .addr(addr_w), .we(we), .clk(clk), .q(q_W49), .offset(offset));
single_port_ram SRAM50(.data(I50), .addr(addr), .we(we), .clk(clk), .q(q_I50));
single_port_ram_w SRAM_w50(.data(W50), .addr(addr_w), .we(we), .clk(clk), .q(q_W50), .offset(offset));
single_port_ram SRAM51(.data(I51), .addr(addr), .we(we), .clk(clk), .q(q_I51));
single_port_ram_w SRAM_w51(.data(W51), .addr(addr_w), .we(we), .clk(clk), .q(q_W51), .offset(offset));
single_port_ram SRAM52(.data(I52), .addr(addr), .we(we), .clk(clk), .q(q_I52));
single_port_ram_w SRAM_w52(.data(W52), .addr(addr_w), .we(we), .clk(clk), .q(q_W52), .offset(offset));
single_port_ram SRAM53(.data(I53), .addr(addr), .we(we), .clk(clk), .q(q_I53));
single_port_ram_w SRAM_w53(.data(W53), .addr(addr_w), .we(we), .clk(clk), .q(q_W53), .offset(offset));
single_port_ram SRAM54(.data(I54), .addr(addr), .we(we), .clk(clk), .q(q_I54));
single_port_ram_w SRAM_w54(.data(W54), .addr(addr_w), .we(we), .clk(clk), .q(q_W54), .offset(offset));
single_port_ram SRAM55(.data(I55), .addr(addr), .we(we), .clk(clk), .q(q_I55));
single_port_ram_w SRAM_w55(.data(W55), .addr(addr_w), .we(we), .clk(clk), .q(q_W55), .offset(offset));
single_port_ram SRAM56(.data(I56), .addr(addr), .we(we), .clk(clk), .q(q_I56));
single_port_ram_w SRAM_w56(.data(W56), .addr(addr_w), .we(we), .clk(clk), .q(q_W56), .offset(offset));
single_port_ram SRAM57(.data(I57), .addr(addr), .we(we), .clk(clk), .q(q_I57));
single_port_ram_w SRAM_w57(.data(W57), .addr(addr_w), .we(we), .clk(clk), .q(q_W57), .offset(offset));
single_port_ram SRAM58(.data(I58), .addr(addr), .we(we), .clk(clk), .q(q_I58));
single_port_ram_w SRAM_w58(.data(W58), .addr(addr_w), .we(we), .clk(clk), .q(q_W58), .offset(offset));
single_port_ram SRAM59(.data(I59), .addr(addr), .we(we), .clk(clk), .q(q_I59));
single_port_ram_w SRAM_w59(.data(W59), .addr(addr_w), .we(we), .clk(clk), .q(q_W59), .offset(offset));
single_port_ram SRAM60(.data(I60), .addr(addr), .we(we), .clk(clk), .q(q_I60));
single_port_ram_w SRAM_w60(.data(W60), .addr(addr_w), .we(we), .clk(clk), .q(q_W60), .offset(offset));
single_port_ram SRAM61(.data(I61), .addr(addr), .we(we), .clk(clk), .q(q_I61));
single_port_ram_w SRAM_w61(.data(W61), .addr(addr_w), .we(we), .clk(clk), .q(q_W61), .offset(offset));
single_port_ram SRAM62(.data(I62), .addr(addr), .we(we), .clk(clk), .q(q_I62));
single_port_ram_w SRAM_w62(.data(W62), .addr(addr_w), .we(we), .clk(clk), .q(q_W62), .offset(offset));
single_port_ram SRAM63(.data(I63), .addr(addr), .we(we), .clk(clk), .q(q_I63));
single_port_ram_w SRAM_w63(.data(W63), .addr(addr_w), .we(we), .clk(clk), .q(q_W63), .offset(offset));
single_port_ram SRAM64(.data(I64), .addr(addr), .we(we), .clk(clk), .q(q_I64));
single_port_ram_w SRAM_w64(.data(W64), .addr(addr_w), .we(we), .clk(clk), .q(q_W64), .offset(offset));
single_port_ram SRAM65(.data(I65), .addr(addr), .we(we), .clk(clk), .q(q_I65));
single_port_ram_w SRAM_w65(.data(W65), .addr(addr_w), .we(we), .clk(clk), .q(q_W65), .offset(offset));
single_port_ram SRAM66(.data(I66), .addr(addr), .we(we), .clk(clk), .q(q_I66));
single_port_ram_w SRAM_w66(.data(W66), .addr(addr_w), .we(we), .clk(clk), .q(q_W66), .offset(offset));
single_port_ram SRAM67(.data(I67), .addr(addr), .we(we), .clk(clk), .q(q_I67));
single_port_ram_w SRAM_w67(.data(W67), .addr(addr_w), .we(we), .clk(clk), .q(q_W67), .offset(offset));
single_port_ram SRAM68(.data(I68), .addr(addr), .we(we), .clk(clk), .q(q_I68));
single_port_ram_w SRAM_w68(.data(W68), .addr(addr_w), .we(we), .clk(clk), .q(q_W68), .offset(offset));
single_port_ram SRAM69(.data(I69), .addr(addr), .we(we), .clk(clk), .q(q_I69));
single_port_ram_w SRAM_w69(.data(W69), .addr(addr_w), .we(we), .clk(clk), .q(q_W69), .offset(offset));
single_port_ram SRAM70(.data(I70), .addr(addr), .we(we), .clk(clk), .q(q_I70));
single_port_ram_w SRAM_w70(.data(W70), .addr(addr_w), .we(we), .clk(clk), .q(q_W70), .offset(offset));
single_port_ram SRAM71(.data(I71), .addr(addr), .we(we), .clk(clk), .q(q_I71));
single_port_ram_w SRAM_w71(.data(W71), .addr(addr_w), .we(we), .clk(clk), .q(q_W71), .offset(offset));
single_port_ram SRAM72(.data(I72), .addr(addr), .we(we), .clk(clk), .q(q_I72));
single_port_ram_w SRAM_w72(.data(W72), .addr(addr_w), .we(we), .clk(clk), .q(q_W72), .offset(offset));
single_port_ram SRAM73(.data(I73), .addr(addr), .we(we), .clk(clk), .q(q_I73));
single_port_ram_w SRAM_w73(.data(W73), .addr(addr_w), .we(we), .clk(clk), .q(q_W73), .offset(offset));
single_port_ram SRAM74(.data(I74), .addr(addr), .we(we), .clk(clk), .q(q_I74));
single_port_ram_w SRAM_w74(.data(W74), .addr(addr_w), .we(we), .clk(clk), .q(q_W74), .offset(offset));
single_port_ram SRAM75(.data(I75), .addr(addr), .we(we), .clk(clk), .q(q_I75));
single_port_ram_w SRAM_w75(.data(W75), .addr(addr_w), .we(we), .clk(clk), .q(q_W75), .offset(offset));
single_port_ram SRAM76(.data(I76), .addr(addr), .we(we), .clk(clk), .q(q_I76));
single_port_ram_w SRAM_w76(.data(W76), .addr(addr_w), .we(we), .clk(clk), .q(q_W76), .offset(offset));
single_port_ram SRAM77(.data(I77), .addr(addr), .we(we), .clk(clk), .q(q_I77));
single_port_ram_w SRAM_w77(.data(W77), .addr(addr_w), .we(we), .clk(clk), .q(q_W77), .offset(offset));
single_port_ram SRAM78(.data(I78), .addr(addr), .we(we), .clk(clk), .q(q_I78));
single_port_ram_w SRAM_w78(.data(W78), .addr(addr_w), .we(we), .clk(clk), .q(q_W78), .offset(offset));
single_port_ram SRAM79(.data(I79), .addr(addr), .we(we), .clk(clk), .q(q_I79));
single_port_ram_w SRAM_w79(.data(W79), .addr(addr_w), .we(we), .clk(clk), .q(q_W79), .offset(offset));
single_port_ram SRAM80(.data(I80), .addr(addr), .we(we), .clk(clk), .q(q_I80));
single_port_ram_w SRAM_w80(.data(W80), .addr(addr_w), .we(we), .clk(clk), .q(q_W80), .offset(offset));
single_port_ram SRAM81(.data(I81), .addr(addr), .we(we), .clk(clk), .q(q_I81));
single_port_ram_w SRAM_w81(.data(W81), .addr(addr_w), .we(we), .clk(clk), .q(q_W81), .offset(offset));
single_port_ram SRAM82(.data(I82), .addr(addr), .we(we), .clk(clk), .q(q_I82));
single_port_ram_w SRAM_w82(.data(W82), .addr(addr_w), .we(we), .clk(clk), .q(q_W82), .offset(offset));
single_port_ram SRAM83(.data(I83), .addr(addr), .we(we), .clk(clk), .q(q_I83));
single_port_ram_w SRAM_w83(.data(W83), .addr(addr_w), .we(we), .clk(clk), .q(q_W83), .offset(offset));
single_port_ram SRAM84(.data(I84), .addr(addr), .we(we), .clk(clk), .q(q_I84));
single_port_ram_w SRAM_w84(.data(W84), .addr(addr_w), .we(we), .clk(clk), .q(q_W84), .offset(offset));
single_port_ram SRAM85(.data(I85), .addr(addr), .we(we), .clk(clk), .q(q_I85));
single_port_ram_w SRAM_w85(.data(W85), .addr(addr_w), .we(we), .clk(clk), .q(q_W85), .offset(offset));
single_port_ram SRAM86(.data(I86), .addr(addr), .we(we), .clk(clk), .q(q_I86));
single_port_ram_w SRAM_w86(.data(W86), .addr(addr_w), .we(we), .clk(clk), .q(q_W86), .offset(offset));
single_port_ram SRAM87(.data(I87), .addr(addr), .we(we), .clk(clk), .q(q_I87));
single_port_ram_w SRAM_w87(.data(W87), .addr(addr_w), .we(we), .clk(clk), .q(q_W87), .offset(offset));
single_port_ram SRAM88(.data(I88), .addr(addr), .we(we), .clk(clk), .q(q_I88));
single_port_ram_w SRAM_w88(.data(W88), .addr(addr_w), .we(we), .clk(clk), .q(q_W88), .offset(offset));
single_port_ram SRAM89(.data(I89), .addr(addr), .we(we), .clk(clk), .q(q_I89));
single_port_ram_w SRAM_w89(.data(W89), .addr(addr_w), .we(we), .clk(clk), .q(q_W89), .offset(offset));
single_port_ram SRAM90(.data(I90), .addr(addr), .we(we), .clk(clk), .q(q_I90));
single_port_ram_w SRAM_w90(.data(W90), .addr(addr_w), .we(we), .clk(clk), .q(q_W90), .offset(offset));
single_port_ram SRAM91(.data(I91), .addr(addr), .we(we), .clk(clk), .q(q_I91));
single_port_ram_w SRAM_w91(.data(W91), .addr(addr_w), .we(we), .clk(clk), .q(q_W91), .offset(offset));
single_port_ram SRAM92(.data(I92), .addr(addr), .we(we), .clk(clk), .q(q_I92));
single_port_ram_w SRAM_w92(.data(W92), .addr(addr_w), .we(we), .clk(clk), .q(q_W92), .offset(offset));
single_port_ram SRAM93(.data(I93), .addr(addr), .we(we), .clk(clk), .q(q_I93));
single_port_ram_w SRAM_w93(.data(W93), .addr(addr_w), .we(we), .clk(clk), .q(q_W93), .offset(offset));
single_port_ram SRAM94(.data(I94), .addr(addr), .we(we), .clk(clk), .q(q_I94));
single_port_ram_w SRAM_w94(.data(W94), .addr(addr_w), .we(we), .clk(clk), .q(q_W94), .offset(offset));
single_port_ram SRAM95(.data(I95), .addr(addr), .we(we), .clk(clk), .q(q_I95));
single_port_ram_w SRAM_w95(.data(W95), .addr(addr_w), .we(we), .clk(clk), .q(q_W95), .offset(offset));
single_port_ram SRAM96(.data(I96), .addr(addr), .we(we), .clk(clk), .q(q_I96));
single_port_ram_w SRAM_w96(.data(W96), .addr(addr_w), .we(we), .clk(clk), .q(q_W96), .offset(offset));
single_port_ram SRAM97(.data(I97), .addr(addr), .we(we), .clk(clk), .q(q_I97));
single_port_ram_w SRAM_w97(.data(W97), .addr(addr_w), .we(we), .clk(clk), .q(q_W97), .offset(offset));
single_port_ram SRAM98(.data(I98), .addr(addr), .we(we), .clk(clk), .q(q_I98));
single_port_ram_w SRAM_w98(.data(W98), .addr(addr_w), .we(we), .clk(clk), .q(q_W98), .offset(offset));
single_port_ram SRAM99(.data(I99), .addr(addr), .we(we), .clk(clk), .q(q_I99));
single_port_ram_w SRAM_w99(.data(W99), .addr(addr_w), .we(we), .clk(clk), .q(q_W99), .offset(offset));
single_port_ram SRAM100(.data(I100), .addr(addr), .we(we), .clk(clk), .q(q_I100));
single_port_ram_w SRAM_w100(.data(W100), .addr(addr_w), .we(we), .clk(clk), .q(q_W100), .offset(offset));
single_port_ram SRAM101(.data(I101), .addr(addr), .we(we), .clk(clk), .q(q_I101));
single_port_ram_w SRAM_w101(.data(W101), .addr(addr_w), .we(we), .clk(clk), .q(q_W101), .offset(offset));
single_port_ram SRAM102(.data(I102), .addr(addr), .we(we), .clk(clk), .q(q_I102));
single_port_ram_w SRAM_w102(.data(W102), .addr(addr_w), .we(we), .clk(clk), .q(q_W102), .offset(offset));
single_port_ram SRAM103(.data(I103), .addr(addr), .we(we), .clk(clk), .q(q_I103));
single_port_ram_w SRAM_w103(.data(W103), .addr(addr_w), .we(we), .clk(clk), .q(q_W103), .offset(offset));
single_port_ram SRAM104(.data(I104), .addr(addr), .we(we), .clk(clk), .q(q_I104));
single_port_ram_w SRAM_w104(.data(W104), .addr(addr_w), .we(we), .clk(clk), .q(q_W104), .offset(offset));
single_port_ram SRAM105(.data(I105), .addr(addr), .we(we), .clk(clk), .q(q_I105));
single_port_ram_w SRAM_w105(.data(W105), .addr(addr_w), .we(we), .clk(clk), .q(q_W105), .offset(offset));
single_port_ram SRAM106(.data(I106), .addr(addr), .we(we), .clk(clk), .q(q_I106));
single_port_ram_w SRAM_w106(.data(W106), .addr(addr_w), .we(we), .clk(clk), .q(q_W106), .offset(offset));
single_port_ram SRAM107(.data(I107), .addr(addr), .we(we), .clk(clk), .q(q_I107));
single_port_ram_w SRAM_w107(.data(W107), .addr(addr_w), .we(we), .clk(clk), .q(q_W107), .offset(offset));
single_port_ram SRAM108(.data(I108), .addr(addr), .we(we), .clk(clk), .q(q_I108));
single_port_ram_w SRAM_w108(.data(W108), .addr(addr_w), .we(we), .clk(clk), .q(q_W108), .offset(offset));
single_port_ram SRAM109(.data(I109), .addr(addr), .we(we), .clk(clk), .q(q_I109));
single_port_ram_w SRAM_w109(.data(W109), .addr(addr_w), .we(we), .clk(clk), .q(q_W109), .offset(offset));
single_port_ram SRAM110(.data(I110), .addr(addr), .we(we), .clk(clk), .q(q_I110));
single_port_ram_w SRAM_w110(.data(W110), .addr(addr_w), .we(we), .clk(clk), .q(q_W110), .offset(offset));
single_port_ram SRAM111(.data(I111), .addr(addr), .we(we), .clk(clk), .q(q_I111));
single_port_ram_w SRAM_w111(.data(W111), .addr(addr_w), .we(we), .clk(clk), .q(q_W111), .offset(offset));
single_port_ram SRAM112(.data(I112), .addr(addr), .we(we), .clk(clk), .q(q_I112));
single_port_ram_w SRAM_w112(.data(W112), .addr(addr_w), .we(we), .clk(clk), .q(q_W112), .offset(offset));
single_port_ram SRAM113(.data(I113), .addr(addr), .we(we), .clk(clk), .q(q_I113));
single_port_ram_w SRAM_w113(.data(W113), .addr(addr_w), .we(we), .clk(clk), .q(q_W113), .offset(offset));
single_port_ram SRAM114(.data(I114), .addr(addr), .we(we), .clk(clk), .q(q_I114));
single_port_ram_w SRAM_w114(.data(W114), .addr(addr_w), .we(we), .clk(clk), .q(q_W114), .offset(offset));
single_port_ram SRAM115(.data(I115), .addr(addr), .we(we), .clk(clk), .q(q_I115));
single_port_ram_w SRAM_w115(.data(W115), .addr(addr_w), .we(we), .clk(clk), .q(q_W115), .offset(offset));
single_port_ram SRAM116(.data(I116), .addr(addr), .we(we), .clk(clk), .q(q_I116));
single_port_ram_w SRAM_w116(.data(W116), .addr(addr_w), .we(we), .clk(clk), .q(q_W116), .offset(offset));
single_port_ram SRAM117(.data(I117), .addr(addr), .we(we), .clk(clk), .q(q_I117));
single_port_ram_w SRAM_w117(.data(W117), .addr(addr_w), .we(we), .clk(clk), .q(q_W117), .offset(offset));
single_port_ram SRAM118(.data(I118), .addr(addr), .we(we), .clk(clk), .q(q_I118));
single_port_ram_w SRAM_w118(.data(W118), .addr(addr_w), .we(we), .clk(clk), .q(q_W118), .offset(offset));
single_port_ram SRAM119(.data(I119), .addr(addr), .we(we), .clk(clk), .q(q_I119));
single_port_ram_w SRAM_w119(.data(W119), .addr(addr_w), .we(we), .clk(clk), .q(q_W119), .offset(offset));
single_port_ram SRAM120(.data(I120), .addr(addr), .we(we), .clk(clk), .q(q_I120));
single_port_ram_w SRAM_w120(.data(W120), .addr(addr_w), .we(we), .clk(clk), .q(q_W120), .offset(offset));
single_port_ram SRAM121(.data(I121), .addr(addr), .we(we), .clk(clk), .q(q_I121));
single_port_ram_w SRAM_w121(.data(W121), .addr(addr_w), .we(we), .clk(clk), .q(q_W121), .offset(offset));
single_port_ram SRAM122(.data(I122), .addr(addr), .we(we), .clk(clk), .q(q_I122));
single_port_ram_w SRAM_w122(.data(W122), .addr(addr_w), .we(we), .clk(clk), .q(q_W122), .offset(offset));
single_port_ram SRAM123(.data(I123), .addr(addr), .we(we), .clk(clk), .q(q_I123));
single_port_ram_w SRAM_w123(.data(W123), .addr(addr_w), .we(we), .clk(clk), .q(q_W123), .offset(offset));
single_port_ram SRAM124(.data(I124), .addr(addr), .we(we), .clk(clk), .q(q_I124));
single_port_ram_w SRAM_w124(.data(W124), .addr(addr_w), .we(we), .clk(clk), .q(q_W124), .offset(offset));
single_port_ram SRAM125(.data(I125), .addr(addr), .we(we), .clk(clk), .q(q_I125));
single_port_ram_w SRAM_w125(.data(W125), .addr(addr_w), .we(we), .clk(clk), .q(q_W125), .offset(offset));
single_port_ram SRAM126(.data(I126), .addr(addr), .we(we), .clk(clk), .q(q_I126));
single_port_ram_w SRAM_w126(.data(W126), .addr(addr_w), .we(we), .clk(clk), .q(q_W126), .offset(offset));
single_port_ram SRAM127(.data(I127), .addr(addr), .we(we), .clk(clk), .q(q_I127));
single_port_ram_w SRAM_w127(.data(W127), .addr(addr_w), .we(we), .clk(clk), .q(q_W127), .offset(offset));





always #10 clk = ~clk;
initial begin
  #0
  clk=0;
end

initial begin
    $dumpfile("top.vcd");
    $dumpvars(0, top_tb);
//sram initial
  #0
  we=0;
  rst=1;
  
  
  quit

  //1.25 1.5
  #5
  we=1;
  addr = 6'd0;
  data_a = {8'b`H1,8'b`LP25 };//1.25
  data_b = {8'b`H1,8'b`LP5 };//1.5

  //2.5 1.5
  #20
  addr = 6'd1;
  data_a = {8'b`H2,8'b`LP5 };//2.5
  data_b = {8'b`H1,8'b`LP5 };//1.5

  //2.5 5
  #20
  addr = 6'd2;
  data_a = {8'b`H2,8'b`LP5 };//2.5
  data_b = {8'b`H5,8'b`L0 };//5

  //2 2
  #20
  addr = 6'd3;
  data_a = {8'b`H2,8'b`L0 };//2
  data_b = {8'b`H2,8'b`L0 };//2

  //3 5
  #20
  addr = 6'd4;
  data_a = {8'b`H3,8'b`L0 };//3
  data_b = {8'b`H5,8'b`L0 };//5

  //2 3
  #20
  addr = 6'd5;
  data_a = {8'b`H2,8'b`L0 };//2
  data_b = {8'b`H3,8'b`L0 };//3

  //1.25 3.5
  #20
  addr = 6'd6;
  data_a = {8'b`H1,8'b`LP25 };//1.25
  data_b = {8'b`H3,8'b`LP5 };//3.5

  //3.5 5
  #20
  addr = 6'd7;
  data_a = {8'b`H3,8'b`LP5 };//3.5
  data_b = {8'b`H5,8'b`L0 };//5

  //4.5 4
  #20
  addr = 6'd8;
  data_a = {8'b`H4,8'b`LP5 };//4.5
  data_b = {8'b`H4,8'b`L0 };//4

  //2 3
  #20
  addr = 6'd9;
  data_a = {8'b`H2,8'b`L0 };//2
  data_b = {8'b`H3,8'b`L0 };//3

  #20
  we = 0;
  addr=0;
  //addr = 12; //for test
  //#100
  rst = 0;
  //#20 addr = 0;
  #20 addr = 1;
  #20 addr = 2;
  #20 addr = 3;
  #20 addr = 4;
  #20 addr = 5;
  #20 addr = 6;
  #20 addr = 7;
  #20 addr = 8;
  #20 addr = 9;
  
  #200
  $finish;
end

endmodule


  
  