/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : S-2021.06-SP4
// Date      : Thu May  2 09:56:54 2024
/////////////////////////////////////////////////////////////


module inccomp ( C, ck, rst, INCA, INCB );
  output [7:0] C;
  input ck, rst, INCA, INCB;
  wire   N8, N9, N10, N11, N12, N13, N14, N15, N33, N34, N35, N36, N37, N38,
         N39, N40, lt_gt_47_B_0_, lt_gt_47_B_1_, lt_gt_47_B_2_, lt_gt_47_B_3_,
         lt_gt_47_B_4_, lt_gt_47_B_5_, lt_gt_47_B_6_, lt_gt_47_B_7_,
         lt_gt_47_A_0_, lt_gt_47_A_1_, lt_gt_47_A_2_, lt_gt_47_A_3_,
         lt_gt_47_A_4_, lt_gt_47_A_5_, lt_gt_47_A_6_, lt_gt_47_A_7_, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94;
  wire   [7:0] syncha;
  wire   [7:0] synchb;
  wire   [7:2] r73_carry;
  wire   [7:2] r72_carry;

  DFFR_X1 syncha_reg_0_ ( .D(lt_gt_47_B_0_), .CK(ck), .RN(n86), .Q(syncha[0])
         );
  DFFR_X1 syncha_reg_1_ ( .D(lt_gt_47_B_1_), .CK(ck), .RN(n86), .Q(syncha[1])
         );
  DFFR_X1 syncha_reg_2_ ( .D(lt_gt_47_B_2_), .CK(ck), .RN(n86), .Q(syncha[2])
         );
  DFFR_X1 syncha_reg_3_ ( .D(lt_gt_47_B_3_), .CK(ck), .RN(n86), .Q(syncha[3])
         );
  DFFR_X1 syncha_reg_4_ ( .D(lt_gt_47_B_4_), .CK(ck), .RN(n86), .Q(syncha[4])
         );
  DFFR_X1 syncha_reg_5_ ( .D(lt_gt_47_B_5_), .CK(ck), .RN(n86), .Q(syncha[5])
         );
  DFFR_X1 syncha_reg_6_ ( .D(lt_gt_47_B_6_), .CK(ck), .RN(n86), .Q(syncha[6])
         );
  DFFR_X1 syncha_reg_7_ ( .D(lt_gt_47_B_7_), .CK(ck), .RN(n86), .Q(syncha[7])
         );
  DFFR_X1 synchb_reg_0_ ( .D(lt_gt_47_A_0_), .CK(ck), .RN(n86), .Q(synchb[0])
         );
  DFFR_X1 synchb_reg_1_ ( .D(lt_gt_47_A_1_), .CK(ck), .RN(n86), .Q(synchb[1])
         );
  DFFR_X1 synchb_reg_2_ ( .D(lt_gt_47_A_2_), .CK(ck), .RN(n86), .Q(synchb[2])
         );
  DFFR_X1 synchb_reg_3_ ( .D(lt_gt_47_A_3_), .CK(ck), .RN(n86), .Q(synchb[3])
         );
  DFFR_X1 synchb_reg_4_ ( .D(lt_gt_47_A_4_), .CK(ck), .RN(n86), .Q(synchb[4])
         );
  DFFR_X1 synchb_reg_5_ ( .D(lt_gt_47_A_5_), .CK(ck), .RN(n86), .Q(synchb[5])
         );
  DFFR_X1 synchb_reg_6_ ( .D(lt_gt_47_A_6_), .CK(ck), .RN(n86), .Q(synchb[6])
         );
  DFFR_X1 synchb_reg_7_ ( .D(lt_gt_47_A_7_), .CK(ck), .RN(n86), .Q(synchb[7])
         );
  DFFR_X1 C_reg_7_ ( .D(n87), .CK(ck), .RN(n86), .Q(C[7]) );
  DFFR_X1 C_reg_6_ ( .D(n88), .CK(ck), .RN(n86), .Q(C[6]) );
  DFFR_X1 C_reg_5_ ( .D(n89), .CK(ck), .RN(n86), .Q(C[5]) );
  DFFR_X1 C_reg_4_ ( .D(n90), .CK(ck), .RN(n86), .Q(C[4]) );
  DFFR_X1 C_reg_3_ ( .D(n91), .CK(ck), .RN(n86), .Q(C[3]) );
  DFFR_X1 C_reg_2_ ( .D(n92), .CK(ck), .RN(n86), .Q(C[2]) );
  DFFR_X1 C_reg_1_ ( .D(n93), .CK(ck), .RN(n86), .Q(C[1]) );
  DFFR_X1 C_reg_0_ ( .D(n94), .CK(ck), .RN(n86), .Q(C[0]) );
  INV_X1 U55 ( .A(rst), .ZN(n86) );
  MUX2_X1 U56 ( .A(lt_gt_47_B_7_), .B(lt_gt_47_A_7_), .S(n63), .Z(n87) );
  MUX2_X1 U57 ( .A(lt_gt_47_B_6_), .B(lt_gt_47_A_6_), .S(n63), .Z(n88) );
  MUX2_X1 U58 ( .A(lt_gt_47_B_5_), .B(lt_gt_47_A_5_), .S(n63), .Z(n89) );
  MUX2_X1 U59 ( .A(lt_gt_47_B_4_), .B(lt_gt_47_A_4_), .S(n63), .Z(n90) );
  MUX2_X1 U60 ( .A(lt_gt_47_B_3_), .B(lt_gt_47_A_3_), .S(n63), .Z(n91) );
  MUX2_X1 U61 ( .A(lt_gt_47_B_2_), .B(lt_gt_47_A_2_), .S(n63), .Z(n92) );
  MUX2_X1 U62 ( .A(lt_gt_47_B_1_), .B(lt_gt_47_A_1_), .S(n63), .Z(n93) );
  MUX2_X1 U63 ( .A(lt_gt_47_B_0_), .B(lt_gt_47_A_0_), .S(n63), .Z(n94) );
  AOI21_X1 U64 ( .B1(n64), .B2(lt_gt_47_A_7_), .A(n65), .ZN(n63) );
  INV_X1 U65 ( .A(n66), .ZN(n65) );
  OAI221_X1 U66 ( .B1(lt_gt_47_B_6_), .B2(n67), .C1(lt_gt_47_A_7_), .C2(n64), 
        .A(n68), .ZN(n66) );
  OAI21_X1 U67 ( .B1(lt_gt_47_A_6_), .B2(n69), .A(n70), .ZN(n68) );
  OAI21_X1 U68 ( .B1(lt_gt_47_B_5_), .B2(n71), .A(n72), .ZN(n70) );
  OAI221_X1 U69 ( .B1(lt_gt_47_A_5_), .B2(n73), .C1(lt_gt_47_A_4_), .C2(n74), 
        .A(n75), .ZN(n72) );
  OAI221_X1 U70 ( .B1(lt_gt_47_B_4_), .B2(n76), .C1(lt_gt_47_B_3_), .C2(n77), 
        .A(n78), .ZN(n75) );
  OAI221_X1 U71 ( .B1(lt_gt_47_A_3_), .B2(n79), .C1(lt_gt_47_A_2_), .C2(n80), 
        .A(n81), .ZN(n78) );
  OAI221_X1 U72 ( .B1(lt_gt_47_B_2_), .B2(n82), .C1(lt_gt_47_B_0_), .C2(n83), 
        .A(n84), .ZN(n81) );
  INV_X1 U73 ( .A(n85), .ZN(n84) );
  AOI21_X1 U74 ( .B1(n83), .B2(lt_gt_47_B_0_), .A(lt_gt_47_B_1_), .ZN(n85) );
  INV_X1 U75 ( .A(lt_gt_47_A_1_), .ZN(n83) );
  INV_X1 U76 ( .A(lt_gt_47_A_2_), .ZN(n82) );
  INV_X1 U77 ( .A(lt_gt_47_B_2_), .ZN(n80) );
  INV_X1 U78 ( .A(lt_gt_47_B_3_), .ZN(n79) );
  INV_X1 U79 ( .A(lt_gt_47_A_3_), .ZN(n77) );
  INV_X1 U80 ( .A(lt_gt_47_A_4_), .ZN(n76) );
  INV_X1 U81 ( .A(lt_gt_47_B_4_), .ZN(n74) );
  INV_X1 U82 ( .A(lt_gt_47_B_5_), .ZN(n73) );
  INV_X1 U83 ( .A(lt_gt_47_A_5_), .ZN(n71) );
  INV_X1 U84 ( .A(lt_gt_47_B_6_), .ZN(n69) );
  INV_X1 U85 ( .A(lt_gt_47_A_6_), .ZN(n67) );
  INV_X1 U86 ( .A(lt_gt_47_B_7_), .ZN(n64) );
  MUX2_X1 U87 ( .A(syncha[7]), .B(N15), .S(INCA), .Z(lt_gt_47_B_7_) );
  MUX2_X1 U88 ( .A(syncha[6]), .B(N14), .S(INCA), .Z(lt_gt_47_B_6_) );
  MUX2_X1 U89 ( .A(syncha[5]), .B(N13), .S(INCA), .Z(lt_gt_47_B_5_) );
  MUX2_X1 U90 ( .A(syncha[4]), .B(N12), .S(INCA), .Z(lt_gt_47_B_4_) );
  MUX2_X1 U91 ( .A(syncha[3]), .B(N11), .S(INCA), .Z(lt_gt_47_B_3_) );
  MUX2_X1 U92 ( .A(syncha[2]), .B(N10), .S(INCA), .Z(lt_gt_47_B_2_) );
  MUX2_X1 U93 ( .A(syncha[1]), .B(N9), .S(INCA), .Z(lt_gt_47_B_1_) );
  MUX2_X1 U94 ( .A(syncha[0]), .B(N8), .S(INCA), .Z(lt_gt_47_B_0_) );
  MUX2_X1 U95 ( .A(synchb[7]), .B(N40), .S(INCB), .Z(lt_gt_47_A_7_) );
  MUX2_X1 U96 ( .A(synchb[6]), .B(N39), .S(INCB), .Z(lt_gt_47_A_6_) );
  MUX2_X1 U97 ( .A(synchb[5]), .B(N38), .S(INCB), .Z(lt_gt_47_A_5_) );
  MUX2_X1 U98 ( .A(synchb[4]), .B(N37), .S(INCB), .Z(lt_gt_47_A_4_) );
  MUX2_X1 U99 ( .A(synchb[3]), .B(N36), .S(INCB), .Z(lt_gt_47_A_3_) );
  MUX2_X1 U100 ( .A(synchb[2]), .B(N35), .S(INCB), .Z(lt_gt_47_A_2_) );
  MUX2_X1 U101 ( .A(synchb[1]), .B(N34), .S(INCB), .Z(lt_gt_47_A_1_) );
  MUX2_X1 U102 ( .A(synchb[0]), .B(N33), .S(INCB), .Z(lt_gt_47_A_0_) );
  XOR2_X1 r73_U2 ( .A(r73_carry[7]), .B(synchb[7]), .Z(N40) );
  INV_X1 r73_U1 ( .A(synchb[0]), .ZN(N33) );
  HA_X1 r73_U1_1_1 ( .A(synchb[1]), .B(synchb[0]), .CO(r73_carry[2]), .S(N34)
         );
  HA_X1 r73_U1_1_2 ( .A(synchb[2]), .B(r73_carry[2]), .CO(r73_carry[3]), .S(
        N35) );
  HA_X1 r73_U1_1_3 ( .A(synchb[3]), .B(r73_carry[3]), .CO(r73_carry[4]), .S(
        N36) );
  HA_X1 r73_U1_1_4 ( .A(synchb[4]), .B(r73_carry[4]), .CO(r73_carry[5]), .S(
        N37) );
  HA_X1 r73_U1_1_5 ( .A(synchb[5]), .B(r73_carry[5]), .CO(r73_carry[6]), .S(
        N38) );
  HA_X1 r73_U1_1_6 ( .A(synchb[6]), .B(r73_carry[6]), .CO(r73_carry[7]), .S(
        N39) );
  XOR2_X1 r72_U2 ( .A(r72_carry[7]), .B(syncha[7]), .Z(N15) );
  INV_X1 r72_U1 ( .A(syncha[0]), .ZN(N8) );
  HA_X1 r72_U1_1_1 ( .A(syncha[1]), .B(syncha[0]), .CO(r72_carry[2]), .S(N9)
         );
  HA_X1 r72_U1_1_2 ( .A(syncha[2]), .B(r72_carry[2]), .CO(r72_carry[3]), .S(
        N10) );
  HA_X1 r72_U1_1_3 ( .A(syncha[3]), .B(r72_carry[3]), .CO(r72_carry[4]), .S(
        N11) );
  HA_X1 r72_U1_1_4 ( .A(syncha[4]), .B(r72_carry[4]), .CO(r72_carry[5]), .S(
        N12) );
  HA_X1 r72_U1_1_5 ( .A(syncha[5]), .B(r72_carry[5]), .CO(r72_carry[6]), .S(
        N13) );
  HA_X1 r72_U1_1_6 ( .A(syncha[6]), .B(r72_carry[6]), .CO(r72_carry[7]), .S(
        N14) );
endmodule

