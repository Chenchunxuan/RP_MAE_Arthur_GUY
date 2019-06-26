r_LOX_Tank = 1.16;
r_LH2_Tank = 1.38; 


// ----- modeling -----

Delete Model;

x = 0;
y = 0;
z = 0;
j = 0;



// ----- Tanks -----


Mesh.Algorithm = 6;

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
Point(1+x) = {sh1,sh2,sh3 - r,lc};
Point(2+x) = {r+sh1,sh2,sh3 - r,lc};
Point(3+x) = {sh1,r+sh2,sh3 - r,lc};
Circle(1+y) = {2+x,1+x,3+x};
Point(4+x) = {-r+sh1,sh2,sh3- r,lc};
Point(5+x) = {sh1,-r+sh2,sh3 - r,lc};
Circle(2+y) = {3+x,1+x,4+x};
Circle(3+y) = {4+x,1+x,5+x};
Circle(4+y) = {5+x,1+x,2+x};
Point(6+x) = {sh1,sh2,sh3,lc};
Point(7+x) = {sh1,sh2,-2*r + sh3,lc};
Circle(5+y) = {3+x,1+x,6+x};
Circle(6+y) = {6+x,1+x,5+x};
Circle(7+y) = {5+x,1+x,7+x};
Circle(8+y) = {7+x,1+x,3+x};
Circle(9+y) = {2+x,1+x,7+x};
Circle(10+y) = {7+x,1+x,4+x};
Circle(11+y) = {4+x,1+x,6+x};
Circle(12+y) = {6+x,1+x,2+x};
Curve Loop(13+y) = {2+y,8+y,-10-y};
Surface(14+y) = {13+y};
Curve Loop(15+y) = {10+y,3+y,7+y};
Surface(16+y) = {15+y};
Curve Loop(17+y) = {-8-y,-9-y,1+y};
Surface(18+y) = {17+y};
Curve Loop(19+y) = {-11-y,-2-y,5+y};
Surface(20+y) = {19+y};
Curve Loop(21+y) = {-5-y,-12-y,-1-y};
Surface(22+y) = {21+y};
Curve Loop(23+y) = {-3-y,11+y,6+y};
Surface(24+y) = {23+y};
Curve Loop(25+y) = {-7-y,4+y,9+y};
Surface(26+y) = {25+y};
Curve Loop(27+y) = {-4-y,12+y,-6-y};
Surface(28+y) = {27+y};


x = 7*j;
y = 30*j;
z = j;

EndFor
    

// ------- Cylinder -------

Point(37) = {2., 0, 0, 1.0};	Point(38) = {2., 0, 2.6, 1.0};
Point(39) = {-2., 0, 0, 1.0};	Point(40) = {0, -2., 2.6, 1.0};
Point(41) = {0, 2., 2.6, 1.0};	Point(42) = {0, 2., 0, 1.0};
Point(43) = {0, -2., 0, 1.0};	Point(44) = {-2., 0, 2.6, 1.0};

Line(113) = {38, 37};	Line(114) = {40, 43};
Line(115) = {41, 42};	Line(116) = {44, 39};

Point(45) = {0, 0, 0, 1.0};	
Point(46) = {0, 0, 2.6, 1.0};
Circle(117) = {40, 46, 38};	Circle(118) = {38, 46, 41};
Circle(119) = {41, 46, 44};	Circle(120) = {44, 46, 40};
Circle(121) = {37, 45, 42};	Circle(122) = {42, 45, 39};
Circle(123) = {39, 45, 43};	Circle(124) = {43, 45, 37};

Curve Loop(120) = {118, 115, -121, -113};
Surface(120) = {120};
Curve Loop(121) = {117, 113, -124, -114};
Surface(121) = {121};
Curve Loop(122) = {123, -114, -120, 116};
Surface(122) = {122};
Curve Loop(123) = {122, -116, -119, 115};
Surface(123) = {123};
Curve Loop(125) = {119, 120, 117, 118};
Plane Surface(125) = {125};

// Meshing Cylinder

Transfinite Line{113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124} = 8;
Transfinite Surface{120, 121, 122, 123};
Recombine Surface{120, 121, 122, 123};


// ------- Platform --------------------

Point(29) = {1.5, 3.6, 0, 1.0}; 		Point(30) = {-1.5, 3.6, 0, 1.0};
Point(31) = {-1.5, -3.6, 0, 1.0};		Point(32) = {1.5, -3.6, 0, 1.0};
Point(33) = {3.6, -1.5, 0, 1.0}; 		Point(34) = {3.6, 1.5, 0, 1.0};
Point(35) = {-3.6, 1.5, 0, 1.0}; 		Point(36) = {-3.6, -1.5, 0, 1.0}; 

Line(141) = {36, 31};	Line(142) = {32, 31};
Line(143) = {32, 33};	Line(144) = {33, 34};
Line(145) = {34, 29};	Line(146) = {29, 30};
Line(147) = {30, 35};	Line(148) = {35, 36};

// middle reinforcement 
Point(59) = {0, 1, 0, 1.0};	Point(60) = {0, -1, 0, 1.0};
Point(61) = {1, 0, 0, 1.0};	Point(62) = {-1, 0, 0, 1.0};

Circle(125) = {59, 45, 61};	Circle(126) = {61, 45, 60};	
Circle(127) = {60, 45, 62};	Circle(128) = {62, 45, 59};

Curve Loop(126) = {145, 146, 147, 148, 141, -142, 143, 144};
Curve Loop(127) = {121, 122, 123, 124};
Plane Surface(126) = {126, 127};
Curve Loop(128) = {127, 128, 125, 126};
Plane Surface(127) = {127, 128};
Plane Surface(128) = {128};

// --------- structure ----------

Point(51) = { 4.6 , 4.6, -5, 1.0}; 
Point(52) = { 4.6 , -4.6 , -5, 1.0}; 
Point(53) = { -4.6 , 4.6, -5, 1.0}; 
Point(54) = { -4.6 , -4.6 , -5, 1.0}; 

Point(55) = { 3.2, 3.2, - 1, 1.0};
Point(56) = { -3.2, 3.2, - 1, 1.0};
Point(57) = { 3.2, -3.2, - 1, 1.0};
Point(58) = { -3.2, -3.2, - 1, 1.0};

Point(67) = { 3.6, -1.5, -3., 1.0};	Point(71) = { -3.6, -1.5, -3., 1.0};
Point(68) = { 3.6, 1.5, -3., 1.0};	Point(72) = { -3.6, 1.5, -3., 1.0};
Point(69) = { 1.5, 3.6, -3., 1.0};	Point(73) = { -1.5, 3.6, -3., 1.0};
Point(70) = { 1.5, -3.6, -3., 1.0};	Point(74) = { -1.5, -3.6, -3., 1.0};

Point(75) = { 1.5, 1.5, -3, 1.0};	Point(76) = { -1.5, 1.5, -3, 1.0};
Point(77) = { 1.5, -1.5, -3, 1.0};	Point(78) = { -1.5, -1.5, -3, 1.0};

// Legs

Line(149) = {35, 56};	Line(150) = {30, 56};
Line(151) = {56, 53};	Line(153) = {53, 72};	
Line(154) = {53, 73};	Line(173) = {56, 72};	
Line(174) = {56, 73};

Line(155) = {36, 58};	Line(156) = {58, 31};
Line(157) = {58, 54};	Line(159) = {54, 74};	
Line(160) = {54, 71};	Line(175) = {58, 74};
Line(176) = {58, 71};

Line(161) = {32, 57};	Line(162) = {57, 33};
Line(163) = {57, 52};	Line(165) = {52, 67};	
Line(166) = {52, 70};	Line(177) = {57, 70};	
Line(178) = {57, 67};

Line(167) = {34, 55};	Line(168) = {55, 29};
Line(169) = {55, 51};	Line(171) = {51, 69};	
Line(172) = {51, 68};	Line(179) = {55, 68};	
Line(180) = {55, 69};

// Substructure

Line(181) = {69, 73};	Line(182) = {73, 72};
Line(183) = {72, 71};	Line(184) = {71, 74};
Line(185) = {74, 70};	Line(186) = {70, 67};
Line(187) = {67, 68};	Line(188) = {68, 69};
Line(189) = {59, 75};	Line(190) = {61, 75};
Line(191) = {59, 76};	Line(192) = {76, 62};
Line(193) = {62, 78};	Line(194) = {78, 60};
Line(195) = {77, 60};	Line(196) = {77, 61};
Line(197) = {72, 14};	Line(198) = {76, 14};
Line(199) = {14, 78};	Line(200) = {14, 71};
Line(201) = {71, 78};	Line(202) = {76, 72};
Line(203) = {76, 78};	Line(204) = {78, 77};
Line(205) = {77, 75};	Line(206) = {75, 76};
Line(207) = {75, 21};	Line(208) = {21, 69};
Line(209) = {21, 73};	Line(210) = {76, 21};
Line(211) = {75, 69};	Line(212) = {76, 73};
Line(213) = {75, 68};	Line(214) = {77, 67};
Line(215) = {67, 7};	Line(216) = {7, 68};
Line(217) = {7, 75};	Line(218) = {7, 77};
Line(219) = {77, 70};	Line(220) = {78, 74};
Line(221) = {74, 28};	Line(222) = {28, 78};
Line(223) = {28, 70};	Line(224) = {28, 77};
Line(225) = {31, 74};	Line(226) = {70, 32};
Line(227) = {33, 67};	Line(228) = {68, 34};
Line(229) = {29, 69};	Line(230) = {30, 73};
Line(231) = {35, 72};	Line(232) = {36, 71};

Line(233) = {29, 20};	Line(234) = {20, 42};
Line(235) = {20, 30};
	
Line(236) = {39, 13};	Line(237) = {13, 35};
Line(238) = {36, 13};

Line(239) = {43, 27};	Line(240) = {27, 31};
Line(241) = {32, 27};

Line(242) = {37, 6};	Line(243) = {6, 33};
Line(244) = {34, 6};


Curve Loop(129) = {145, 229, -188, 228};
Plane Surface(129) = {129};
Curve Loop(130) = {147, 231, -182, -230};
Plane Surface(130) = {130};
Curve Loop(131) = {141, 225, -184, -232};
Plane Surface(131) = {131};
Curve Loop(132) = {226, 143, 227, -186};
Plane Surface(132) = {132};
Curve Loop(133) = {185, -219, -204, 220};
Plane Surface(133) = {133};
Curve Loop(134) = {186, -214, 219};
Plane Surface(134) = {134};
Curve Loop(135) = {187, -213, -205, 214};
Plane Surface(135) = {135};
Curve Loop(136) = {188, -211, 213};
Plane Surface(136) = {136};
Curve Loop(137) = {206, 212, -181, -211};
Plane Surface(137) = {137};
Curve Loop(138) = {202, -182, -212};
Plane Surface(138) = {138};
Curve Loop(139) = {203, -201, -183, -202};
Plane Surface(139) = {139};
Curve Loop(140) = {220, -184, 201};
Plane Surface(140) = {140};

Transfinite Line{145, 229, -188, 228,147, 231, -182, -230,141, 225, -184, -232,226, 143, 227, -186} = 6;
Transfinite Surface{129, 130, 131, 132};
Recombine Surface{129, 130, 131, 132};

Transfinite Line{185, -219, -204, 220, 187, -213, -205, 214, 206, 212, -181, -211, 203, -201, -183, -202} = 6;
Transfinite Surface{133, 135, 137, 139};
Recombine Surface{133, 135, 137, 139};

// Pads

Point(79) = {4.6, - 5.1, -5};	Point(80) = {4.6, - 4.1, -5};
Point(81) = {-4.6, - 5.1, -5};	Point(82) = {-4.6, - 4.1, -5};
Point(83) = {4.6,  5.1, -5};	Point(84) = {4.6,  4.1, -5};
Point(85) = {-4.6,  5.1, -5};	Point(86) = {-4.6,  4.1, -5};

Circle(245) = {79, 52, 80};	Circle(246) = {80, 52, 79};
Circle(247) = {81, 54, 82};	Circle(248) = {82, 54, 81};
Circle(249) = {83, 51, 84};	Circle(250) = {84, 51, 83};
Circle(251) = {85, 53, 86};	Circle(252) = {86, 53, 85};

Curve Loop(141) = {246, 245};
Plane Surface(141) = {141};
Curve Loop(142) = {247, 248};
Plane Surface(142) = {142};
Curve Loop(143) = {252, 251};
Plane Surface(143) = {143};
Curve Loop(144) = {249, 250};
Plane Surface(144) = {144};
//+
Physical Curve("MStruts") = {157, 163, 169, 151};
//+
Physical Curve("SStruts") = {165, 166, 178, 162, 161, 177, 167, 179, 168, 180, 172, 171, 154, 153, 173, 174, 150, 149, 160, 159, 175, 176, 155, 156};
//+
Physical Surface("Pads") = {142, 141, 144, 143};
//+
Physical Surface("Fuse") = {123, 120, 121, 122, 125};
//+
Physical Surface("Plat1") = {126};
//+
Physical Surface("Plat2") = {127};
//+
Physical Surface("Plat3") = {128};
//+
Physical Surface("Platside") = {132, 129, 130, 131};
//+
Physical Surface("Plattr") = {134, 140, 138, 136};
//+
Physical Surface("Platbot") = {133, 139, 137, 135};
//+
Physical Curve("Struct") = {191, 189, 192, 193, 194, 195, 196, 190, 233, 235, 234, 244, 243, 242, 241, 240, 239, 237, 236, 238, 197, 198, 200, 199, 221, 222, 223, 224, 218, 215, 216, 217, 207, 210, 208, 209};
//+
Physical Surface("LOX") = {52, 44, 50, 54, 46, 56, 58, 48, 28, 14, 24, 18, 26, 22, 20, 16};
//+
Physical Surface("LH2") = {78, 86, 76, 74, 80, 84, 82, 88, 118, 106, 116, 108, 112, 110, 104, 114};
