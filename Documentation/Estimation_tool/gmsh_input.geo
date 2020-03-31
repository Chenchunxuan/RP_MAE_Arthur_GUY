r_LOX_Tank = 1.37;
r_LH2_Tank = 1.63; 

// ----- modeling -----

Delete Model;

x = 0;
y = 0;
z = 0;
j = 0;

// ----- Tanks -----


For ( 1 : 4 )

j = j + 1;


If ( j == 1 )  // 1st Tank
r = r_LOX_Tank;
sh1 = 2.55; // shift on x axis
sh2 = 0;     // shift on y axis
sh3 = - 0.3;
EndIf

If ( j == 2 )   // 2nd Tank
r = r_LOX_Tank;
sh1 = -2.55;
sh2 = 0;
sh3 = - 0.3;
EndIf

If ( j == 3 )  // 3rd Tank
r = r_LH2_Tank;
sh1 = 0;
sh2 = 2.55;
sh3 = - 0.1;
EndIf

If ( j == 4 )  // 4th Tank
r = r_LH2_Tank;
sh1 = 0;
sh2 = -2.55;
sh3 = - 0.1;
EndIf

lc = .55;
Point(6+x) = {sh1,sh2,sh3,lc};
Point(7+x) = {sh1,sh2,-2*r + sh3,lc};


x = 7*j;


EndFor

// --------------- Beam Structure --------------------

Point(29) = {1.5, 3.6, 0, 0.4}; 		Point(30) = {-1.5, 3.6, 0, 0.4};
Point(31) = {-1.5, -3.6, 0, 0.4};		Point(32) = {1.5, -3.6, 0, 0.4};
Point(33) = {3.6, -1.5, 0, 0.4}; 		Point(34) = {3.6, 1.5, 0, 0.4};
Point(35) = {-3.6, 1.5, 0, 0.4}; 		Point(36) = {-3.6, -1.5, 0, 0.4}; 

Line(141) = {36, 31};	Line(142) = {32, 31};
Line(143) = {32, 33};	Line(144) = {33, 34};
Line(145) = {34, 29};	Line(146) = {29, 30};
Line(147) = {30, 35};	Line(148) = {35, 36};

Point(37) = {1.5, 3.6, -3.7, 0.4}; 		Point(38) = {-1.5, 3.6, -3.7, 0.4};
Point(39) = {-1.5, -3.6, -3.7, 0.4};		Point(40) = {1.5, -3.6, -3.7, 0.4};
Point(41) = {3.6, -1.5, -3.7, 0.4}; 		Point(42) = {3.6, 1.5, -3.7, 0.4};
Point(43) = {-3.6, 1.5, -3.7, 0.4}; 		Point(44) = {-3.6, -1.5, -3.7, 0.4}; 

Line(149) = {29, 37};	Line(150) = {30, 38};
Line(151) = {31, 39};	Line(152) = {32, 40};
Line(153) = {33, 41};	Line(154) = {34, 42};
Line(155) = {35, 43};	Line(156) = {36, 44};

Line(157) = {44, 39};	Line(158) = {40, 39};
Line(159) = {40, 41};	Line(160) = {41, 42};
Line(161) = {42, 37};	Line(162) = {37, 38};
Line(163) = {38, 43};	Line(164) = {43, 44};

Point(45) = {1.5, 1.5, 0, 0.4}; 		Point(46) = {1.5, 1.5, -3.7, 0.4};
Point(47) = {-1.5, 1.5, 0, 0.4};		Point(48) = {-1.5, 1.5, -3.7, 0.4};
Point(49) = {1.5, -1.5, 0, 0.4}; 		Point(50) = {1.5, -1.5, -3.7, 0.4};
Point(51) = {-1.5, -1.5, 0, 0.4}; 		Point(52) = {-1.5, -1.5, -3.7, 0.4};

Line(165) = {36, 51};	Line(166) = {51, 31};	Line(167) = {51, 49};
Line(168) = {32, 49};	Line(169) = {49, 33};	Line(170) = {49, 45};
Line(171) = {45, 34};	Line(172) = {45, 29};	Line(173) = {45, 47};
Line(174) = {47, 30};	Line(175) = {35, 47};	Line(176) = {47, 51};

Line(177) = {40, 50};	Line(178) = {41, 50};	Line(179) = {50, 52};
Line(180) = {52, 44};	Line(181) = {39, 52};	Line(182) = {52, 48};
Line(183) = {48, 38};	Line(184) = {43, 48};	Line(185) = {48, 46};
Line(186) = {46, 42};	Line(187) = {37, 46};	Line(188) = {46, 50};

Line(229) = {50, 49};
Line(230) = {51, 52};
Line(231) = {47, 48};
Line(232) = {45, 46};

// -------------- Tanks ----------------

//LH2
Line(189) = {20, 21};	Line(191) = {27, 28}; 

//LH2 TOP SUPPORT
Line(193) = {31, 27};	Line(194) = {27, 51};
Line(195) = {27, 49};	Line(196) = {32, 27};
Line(197) = {20, 47};	Line(198) = {20, 30};
Line(199) = {20, 29};	Line(200) = {45, 20};

//LH2 BOT SUPPORT
Line(201) = {40, 28};	Line(202) = {50, 28};
Line(203) = {28, 52};	Line(204) = {28, 39};
Line(205) = {37, 21};	Line(206) = {21, 46};
Line(207) = {48, 21};	Line(208) = {21, 38};

//LOX
Line(190) = {13, 14};	Line(192) = {7, 6};  

//LOX TOP SUPPORT
Line(209) = {35, 13};	Line(210) = {13, 36};
Line(211) = {51, 13};	Line(212) = {13, 47};
Line(213) = {45, 6};	Line(214) = {49, 6};
Line(215) = {6, 33};	Line(216) = {6, 34};

//LOX BOT SUPPORT
Line(217) = {7, 50};	Line(218) = {41, 7};
Line(219) = {7, 42};	Line(220) = {46, 7};
Line(221) = {44, 14};	Line(222) = {14, 43};
Line(223) = {48, 14};	Line(224) = {14, 52};

// ---------------- Cylinder -----------------

Point(53) = {0, 0, 0, 0.4};	Point(54) = {0, 0, 2.4, 0.4};

//BOT
Circle(225) = {47, 53, 45};
Circle(226) = {45, 53, 49};
Circle(227) = {49, 53, 51};
Circle(228) = {51, 53, 47};

//TOP
Point(55) = {1.5, -1.5, 2.4, 0.4}; 	Point(56) = {-1.5, 1.5, 2.4, 0.4};
Point(57) = {-1.5, -1.5, 2.4, 0.4}; 	Point(58) = {1.5, 1.5, 2.4, 0.4};

Circle(233) = {56, 54, 58};
Circle(234) = {58, 54, 55};
Circle(235) = {55, 54, 57};
Circle(236) = {57, 54, 56};

//SIDE
Line(237) = {55, 49};
Line(238) = {58, 45};
Line(239) = {56, 47};
Line(240) = {57, 51};

//SIDE SURFACES
Curve Loop(1) = {237, 227, -240, -235};
Surface(1) = {1};
Curve Loop(2) = {236, 239, -228, -240};
Surface(2) = {2};
Curve Loop(3) = {233, 238, -225, -239};
Surface(3) = {3};
Curve Loop(4) = {238, 226, -237, -234};
Surface(4) = {4};

//TOP & BOT SURFACES
Curve Loop(5) = {236, 233, 234, 235};
Surface(5) = {5};
Curve Loop(6) = {227, 228, 225, 226};
Surface(6) = {6};

//MESH

Transfinite Line{225, 226, 227, 228, 233, 234, 235, 236, 237, 238, 239, 240} = 8;
Transfinite Surface{1, 2, 3, 4};
Recombine Surface{1, 2, 3, 4};

// ---------------- Legs -------------------

Point(59) = { 4.6 , 4.6, -5.7, 0.4}; 
Point(60) = { 4.6 , -4.6 , -5.7, 0.4}; 
Point(61) = { -4.6 , 4.6, -5.7, 0.4}; 
Point(62) = { -4.6 , -4.6 , -5.7, 0.4}; 

Point(63) = { 3.4, 3.4, - 1.5, 0.4};
Point(64) = { -3.4, 3.4, - 1.5, 0.4};
Point(65) = { 3.4, -3.4, - 1.5, 0.4};
Point(66) = { -3.4, -3.4, - 1.5, 0.4};

Line(241) = {32, 65};
Line(242) = {65, 33};
Line(243) = {41, 65};
Line(244) = {65, 40};
Line(245) = {65, 60};
Line(246) = {41, 60};
Line(247) = {60, 40};
Line(248) = {34, 63};
Line(249) = {63, 29};
Line(250) = {42, 63};
Line(251) = {63, 37};
Line(252) = {63, 59};
Line(253) = {59, 37};
Line(254) = {42, 59};
Line(255) = {30, 64};
Line(256) = {64, 35};
Line(257) = {38, 64};
Line(258) = {64, 43};
Line(259) = {43, 61};
Line(260) = {61, 64};
Line(261) = {38, 61};
Line(262) = {36, 66};
Line(263) = {66, 31};
Line(264) = {39, 66};
Line(265) = {66, 44};
Line(266) = {66, 62};
Line(267) = {62, 39};
Line(268) = {44, 62};


// ------------------ Payload -------------------

Point(67) = { 0, 0, 0.6, 0.4};

Line(269) = {45, 67};
Line(270) = {67, 49};
Line(271) = {51, 67};
Line(272) = {67, 47};


// Converting some elements into bars (only 2 nodes for 1 element)

Transfinite Line{241, 242, 243, 244, 245, 246, 247, 248, 249, 250} = 2; //Legs
Transfinite Line{251, 252, 253, 254, 255, 256, 257, 258, 259, 260} = 2; //Legs
Transfinite Line{261, 262, 263, 264, 265, 266, 267, 268} = 2; //Legs
Transfinite Line{189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200} = 2; //Tanks
Transfinite Line{201, 202, 203, 204, 205, 206, 207, 208, 209, 210} = 2; //Tanks
Transfinite Line{211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224} = 2; //Tanks
Transfinite Line{269, 270, 271, 272} = 2; //Payload

// Making groups of similar elements

Physical Curve("1_HORIZONTAL_TOP_BEAM") = {169, 168, 171, 172, 170, 174, 175, 165, 166, 167, 176};
Physical Curve("2_HORIZONTAL_BOT_BEAM") = {178, 186, 187, 188, 177, 185, 183, 184, 180, 181, 182, 179};
Physical Curve("3_VERTICAL_EXT_BEAM") = {155, 150, 156, 151, 152, 153, 154, 149};
Physical Curve("4_VERTICAL_INT_BEAM") = {232, 231, 230, 229};
Physical Curve("5_HORIZONTAL_TOP_EDGE_BEAM") = {148, 147, 146, 145, 144, 143, 142, 141};
Physical Curve("6_HORIZONTAL_BOT_EDGE_BEAM") = {164, 157, 158, 159, 160, 161, 162, 163};
Physical Curve("7_CIRCLE_BOT_CYL_BEAM") = {228, 225, 226, 227};
Physical Curve("8_CIRCLE_TOP_CYL_BEAM") = {235, 236, 233, 234};
Physical Curve("9_SIDE_CYL_BEAM") = {239, 238, 237, 240};
Physical Curve("10_MAIN_BOT_LEGS_ROD") = {254, 253, 261, 259, 267, 268, 247, 246};
Physical Curve("11_MAIN_TOP_LEGS_ROD") = {245, 252, 260, 266};
Physical Curve("12_SEC_TOP_LEGS_ROD") = {248, 249, 255, 256, 263, 262, 241, 242};
Physical Curve("13_SEC_BOT_LEGS_ROD") = {257, 258, 264, 265, 244, 243, 250, 251};
Physical Curve("14_TOP_LH2") = {199, 200, 198, 197, 195, 196, 193, 194};
Physical Curve("15_TOP_LOX") = {209, 210, 211, 212, 216, 213, 215, 214};
Physical Curve("16_BOT_LH2") = {201, 202, 203, 204, 208, 207, 206, 205};
Physical Curve("17_BOT_LOX") = {222, 223, 224, 221, 219, 220, 218, 217};
Physical Curve("18_LOX") = {190, 192};
Physical Curve("19_LH2") = {189, 191};
Physical Curve("20_PAYLOAD") = {272, 271, 270, 269};
Physical Surface("21_TOP_CYL_SURFACE") = {5};
Physical Surface("22_BOT_CYL_SURFACE") = {6};
Physical Surface("23_SIDE_CYL_SURFACE") = {2, 3, 4, 1};

// Meshing


Mesh.SaveElementTagType=2;
Mesh.LabelType=2;
Mesh.Algorithm=6;
Mesh.BdfFieldFormat=0;
Mesh.Format = 31;

Mesh 1;
Mesh 2;
Coherence Mesh;
