Message-Id: <200201022154.QAA20087@missioncriticallinux.com>
From: mod+linuxppc-dev@MissionCriticalLinux.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Changes to gt64260 PCI arbiter enable code
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_18353280320"
Date: Wed, 02 Jan 2002 16:54:24 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_18353280320
Content-Type: text/plain; charset=us-ascii


Please introduce these changes into the linuxppc
sources in order that the existing generic
gt64260 setup code be usable on platforms other
than the Galileo Eval Board.

The current gt64260 setup contains incorrect
assumptions about internal arbiter setup based
solely upon the detected chip revision, when
this decision is actually platform-dependent;
such code is moved to platform-specific files.

Patch also corrects some comments.


Regards,
          Michael O'Donnell
        Mission Critical Linux



--==_Exmh_18353280320
Content-Type: text/plain ; name="arbiterPatch"; charset=us-ascii
Content-Description: arbiterPatch
Content-Transfer-Encoding: x-uuencode
Content-Disposition: attachment; filename="arbiterPatch"

begin 664 arbiterPatch
M/3T]/3T@87)C:"]P<&,O:V5R;F5L+V=T-C0R-C!?8V]M;6]N+F,@,2XV('9S
M(&5D:71E9"`]/3T]/0HM+2T@,2XV+V%R8V@O<'!C+VME<FYE;"]G=#8T,C8P
M7V-O;6UO;BYC"4UO;B!$96,@,3<@,3<Z,#DZ,C`@,C`P,0HK*RL@961I=&5D
M+V%R8V@O<'!C+VME<FYE;"]G=#8T,C8P7V-O;6UO;BYC"5=E9"!*86X@(#(@
M,38Z,C@Z,C$@,C`P,@I`0"`M,S,T+#$P("LS-38L-B!`0`H@"0E'5#8T,C8P
M7U)%4T547U)%1U]"2513*$=4-C0R-C!?4$-)7S!?0TU$+"`H0DE4-"!\($))
M5#4@?"!"250Y*2D["B`)"4=4-C0R-C!?4D53151?4D5'7T))5%,H1U0V-#(V
M,%]00TE?,5]#340L("A"250T('P@0DE4-2!\($))5#DI*3L*(`HM"0DO*B!&
M17(C,S4@*B\*+0D)1U0V-#(V,%]215-%5%]214=?0DE44RA'5#8T,C8P7U!#
M25\P7T%20DE415)?0TY43"P@0DE4,S$I.PHM"0E'5#8T,C8P7U)%4T547U)%
M1U]"2513*$=4-C0R-C!?4$-)7S%?05)"251%4E]#3E1,+"!"250S,2D["BT*
M(`D)+RH@1D5R(S4T("HO"B`)"4=4-C0R-C!?4D53151?4D5'7T))5%,H1U0V
M-#(V,%]#4%5?4TY/3U!?0D%315\P+"`P>&9F9F-F,#`P*3L*(`D)1U0V-#(V
M,%]215-%5%]214=?0DE44RA'5#8T,C8P7T-055]33D]/4%]"05-%7S$L(#!X
M9F9F8V8P,#`I.PI`0"`M,S0V+#(Q("LS-C0L,34@0$`*(`H@"0DO*B!2(S$X
M("HO"B`)"4=4-C0R-C!?4T547U)%1U]"2513*$=4-C0R-C!?4T1204U?0T].
M1DE'+"!"250R-BD["BT)?0HM"65L<V4@:68@*&=T-C0R-C!?<F5V:7-I;VX@
M/3T@1U0V-#(V,$$I('L**PHK"7T@96QS92!I9B`H9W0V-#(V,%]R979I<VEO
M;B`]/2!'5#8T,C8P02D@>PH@"0DO*B!2(S$X("HO"B`)"4=4-C0R-C!?4T54
M7U)%1U]"2513*$=4-C0R-C!?4T1204U?0T].1DE'+"!"250R-BD["B`*+0D)
M+RH@/S\@*B\*+0D)1U0V-#(V,%]3151?4D5'7T))5%,H1U0V-#(V,%]00TE?
M,%]!4D))5$527T-.5$PL($))5#,Q*3L*+0D)1U0V-#(V,%]3151?4D5'7T))
M5%,H1U0V-#(V,%]00TE?,5]!4D))5$527T-.5$PL($))5#,Q*3L*+0H@"0DO
M*B!.;R!L;VYG97(@97)R871A('-O('1U<FX@;VX@*B\*(`D)1U0V-#(V,%]3
M151?4D5'7T))5%,H1U0V-#(V,%]00TE?,%]#340L("A"250T('P@0DE4-2!\
M($))5#DI*3L*(`D)1U0V-#(V,%]3151?4D5'7T))5%,H1U0V-#(V,%]00TE?
M,5]#340L("A"250T('P@0DE4-2!\($))5#DI*3L*(`E]"BT*+0ER971U<FX[
M"B!]("\J(&=T-C0R-C!?8VAE8VM?97)R871A*"D@*B\*(`H@"D!`("TS.#4L
M,38@*S,Y-RPQ-"!`0`H@"0DO*B!3970@=7`@=&AE('=I;F1O=R!O;B!T:&4@
M0U!5('-I9&4@*B\*(`D)1U0V-#(V,%]214=?5U))5$4H8F]T7W)E9RP@*&)A
M<V5?861D<B`^/B`R,"D@?"!O=&AE<E]B:71S*3L*(`D)1U0V-#(V,%]214=?
M5U))5$4H=&]P7W)E9RP@*&)A<V5?861D<B`K('-I>F4@+2`Q*2`^/B`R,"D[
M"BT*+0E]"BT)96QS92![("\J($1I<V%B;&4@=VEN9&]W("HO"BT)"4=4-C0R
M-C!?4D5'7U=2251%*&)O=%]R96<L(#!X,#`P,#!F9F8@?"!O=&AE<E]B:71S
M*3L**PE](&5L<V4@>R`O*B!$:7-A8FQE('=I;F1O=R`J+PH@"0E'5#8T,C8P
M7U)%1U]74DE412AT;W!?<F5G+"`P>#`P,#`P,#`P*3L**PD)1U0V-#(V,%]2
M14=?5U))5$4H8F]T7W)E9RP@,'@P,#`P,&9F9B!\(&]T:&5R7V)I=',I.PH@
M"7T*(`H@"79A;"`]($=4-C0R-C!?4D5'7U)%040H8F]T7W)E9RD[("\J($9L
M=7-H($9)1D\@*B\*(`ER971U<FX@,#L*+7T@+RH@9W0V-#(V,%]C<'5?<V5T
M7S,R8FET7W=I;F1O=R@I("HO"BM]("\J(&=T-C0R-C!?<V5T7S,R8FET7W=I
M;F1O=R@I("HO"B`*('-T871I8R!I;G0*(&=T-C0R-C!?<V5T7S8T8FET7W=I
M;F1O=RAU,S(@8F%S95]A9&1R7VAI+`I`0"`M-#$X+#<@*S0R."PW($!`"B`)
M?0H@"B`)<F5T=7)N(')C.PHM?2`O*B!G=#8T,C8P7V-P=5]S971?-C1B:71?
M=VEN9&]W*"D@*B\**WT@+RH@9W0V-#(V,%]S971?-C1B:71?=VEN9&]W*"D@
M*B\*(`H@"B`O*@I`0"`M-#DR+#<@*S4P,BPW($!`"B`)"0D)("`@("`@1U0V
M-#(V,%]#4%5?0D]/5%]#4U]$14-/1$5?,%]43U`I.PH@"B`)<F5T=7)N(')C
M.PHM?2`O*B!G=#8T,C8P7V-P=5]S8W-?<V5T7W=I;F1O=R@I("HO"BM]("\J
M(&=T-C0R-C!?8W!U7V)O;W1?<V5T7W=I;F1O=R@I("HO"B`*("\J"B`@*B!G
M=#8T,C8P7V-P=5]S971?<&-I7VEO7W=I;F1O=R@I"CT]/3T](&%R8V@O<'!C
M+W!L871F;W)M<R]E=C8T,C8P7W!C:2YC(#$N-R!V<R!E9&ET960@/3T]/3T*
M+2TM(#$N-R]A<F-H+W!P8R]P;&%T9F]R;7,O978V-#(V,%]P8VDN8PE&<FD@
M1&5C(#(Q(#`S.C4Q.C`Q(#(P,#$**RLK(&5D:71E9"]A<F-H+W!P8R]P;&%T
M9F]R;7,O978V-#(V,%]P8VDN8PE7960@2F%N("`R(#$V.C(W.C,V(#(P,#(*
M0$`@+3$R,BPV("LQ,C(L,C`@0$`*(`D)<F5T=7)N(')C.PH@"7T*(`HK"2\J
M"BL)("H@16YA8FQI;F<@;V8@4$-)(&EN=&5R;F%L+79S+65X=&5R;F%L(&%R
M8FET<F%T:6]N"BL)("H@:7,@82!P;&%T9F]R;2T@86YD(&5R<F%T82UD97!E
M;F1E;G0@9&5C:7-I;VXN"BL)("HO"BL):68H(&=T-C0R-C!?<F5V:7-I;VX@
M/3T@1U0V-#(V,"`I("!["BL)"2\J($9%<B,S-2`J+PHK"0E'5#8T,C8P7U)%
M4T547U)%1U]"2513*$=4-C0R-C!?4$-)7S!?05)"251%4E]#3E1,+"!"250S
M,2D["BL)"4=4-C0R-C!?4D53151?4D5'7T))5%,H1U0V-#(V,%]00TE?,5]!
M4D))5$527T-.5$PL($))5#,Q*3L**PE](&5L<V4@:68H(&=T-C0R-C!?<F5V
M:7-I;VX@/3T@1U0V-#(V,$$@*2`@>PHK"0E'5#8T,C8P7U-%5%]214=?0DE4
M4RA'5#8T,C8P7U!#25\P7T%20DE415)?0TY43"P@0DE4,S$I.PHK"0E'5#8T
M,C8P7U-%5%]214=?0DE44RA'5#8T,C8P7U!#25\Q7T%20DE415)?0TY43"P@
M0DE4,S$I.PHK"7T**PHK"B`)1U0V-#(V,%]3151?4D5'7T))5%,H1U0V-#(V
M,%]#4%5?34%35$527T-.5$PL($))5#DI.R`O*B!/;FQY(#$@8W!U("HO"B`*
M(`DO*B!30U,@=VEN9&]W<R!N;W0@9&ES86)L960@86)O=F4L(&1I<V%B;&4@
186QL(&)U="!30U,@,"`J+PH`
`
end

--==_Exmh_18353280320--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
