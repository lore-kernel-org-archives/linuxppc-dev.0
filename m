Message-Id: <200112271744.MAA03341@missioncriticallinux.com>
From: mod+linuxppc-dev@MissionCriticalLinux.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Changes to gt64260 interrupt support code
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_17755128640"
Date: Thu, 27 Dec 2001 12:44:24 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_17755128640
Content-Type: text/plain



Please introduce these changes into the linuxppc
sources in order that the existing gt64260 interrupt
support code be usable on platforms other than the
Galileo Eval Board.

The current gt64260 interrupt support code forces
use of particular Linux irqs (starting from 0) for
particular GT64260 interrupt sources.  These changes
allow use of that support code in other platforms and
(of particular interest in my situation) in combination
with other interrupt controllers (like the elegant
and flexible 8259) that also want to map *their*
interrupt sources to the Linux irqs starting at 0...


Regards,
          Michael O'Donnell
        Mission Critical Linux



--==_Exmh_17755128640
Content-Type: text/plain ; name="gt64260irqPatch"
Content-Description: gt64260irqPatch
Content-Transfer-Encoding: x-uuencode
Content-Disposition: attachment; filename="gt64260irqPatch"

begin 664 gt64260irqPatch
M/3T]/3T@:6YC;'5D92]A<VTM<'!C+V=T-C0R-C`N:"`Q+C8@=G,@961I=&5D
M(#T]/3T]"BTM+2`Q+C8O:6YC;'5D92]A<VTM<'!C+V=T-C0R-C`N:`E-;VX@
M1&5C(#$W(#$W.C,U.C$W(#(P,#$**RLK(&5D:71E9"]I;F-L=61E+V%S;2UP
M<&,O9W0V-#(V,"YH"51H=2!$96,@,C<@,3<Z-#`Z,3(@,C`P,0I`0"`M,S`L
M-B`K,S`L-R!`0`H@"B`*(&5X=&5R;B!U,S(@("`@(&=T-C0R-C!?8F%S93L*
M*V5X=&5R;B!U,S(@("`@(&=T-C0R-C!?9FER<W1)4E$[("`@("`O*B!792!H
M86YD;&4@=&AE(&YE>'0@.38@25)1<R!F<F]M(&AE<F4@*B\*(&5X=&5R;B!U
M,S(@("`@(&=T-C0R-C!?<F5V:7-I;VX["B!E>'1E<FX@=3@@("`@("!G=#8T
M,C8P7W!C:5]E>&-L=61E7V)R:61G93L*(`H]/3T]/2!A<F-H+W!P8R]K97)N
M96PO9W0V-#(V,%]P:6,N8R`Q+C4@=G,@961I=&5D(#T]/3T]"BTM+2`Q+C4O
M87)C:"]P<&,O:V5R;F5L+V=T-C0R-C!?<&EC+F,)5&AU($1E8R`R,"`Q.#HP
M,CHP-"`R,#`Q"BLK*R!E9&ET960O87)C:"]P<&,O:V5R;F5L+V=T-C0R-C!?
M<&EC+F,)5&AU($1E8R`R-R`Q.#HP,CHS-"`R,#`Q"D!`("TV-RPV("LV-RPX
M($!`"B`)3E5,3`D)"0DO*B!S971?869F:6YI='D@*B\*('T["B`**W4S,B!G
M=#8T,C8P7V9I<G-T25)1(#T@,#L@("`@("`O*B!'5#8T,C8P(&AA;F1L97,@
M=&AE(&YE>'0@.38@25)1<R!F<F]M(&AE<F4@*B\**PH@+RH@9W0V-#(V,%]I
M;FET7VER<2@I"B`@*@H@("H@(%1H:7,@9G5N8W1I;VX@:6YI=&EA;&EZ97,@
M=&AE(&EN=&5R<G5P="!C;VYT<F]L;&5R+B!)="!A<W-I9VYS"D!`("TQ,#,L
M,3$@*S$P-2PQ,2!`0`H@"4=4-C0R-C!?4D5'7U=2251%*$=4-C0R-C!?24-?
M0U!57TE.5%)?34%32U](22P@<'!C7V-A8VAE9%]I<G%?;6%S:ULQ72D["B`*
M(`DO*B!U<V4@=&AE(&=T-C0R-C`@9F]R(&%L;"`H<&]S<VEB;&4I(&EN=&5R
M<G5P="!S;W5R8V5S("HO"BT)9F]R("AI/3`[(&D\.38[(&DK*RD**PEF;W(H
M(&D@/2!G=#8T,C8P7V9I<G-T25)1.R`@:2`\("AG=#8T,C8P7V9I<G-T25)1
M("L@.38I.R`@:2LK("D@('L*(`D):7)Q7V1E<V-;:5TN:&%N9&QE<B`]("9G
M=#8T,C8P7W!I8SL**PE]"B`*(`EI9B`H('!P8U]M9"YP<F]G<F5S<R`I('!P
M8U]M9"YP<F]G<F5S<R@B9W0V-#(V,%]I;FET7VER<3H@97AI="(L(#!X,"D[
M"BT)<F5T=7)N.PH@?0H@"B`*0$`@+3$U,RPQ-"`K,34U+#$W($!`"B`)"0D)
M"6ER<2`](&ER<5]G<'`@*R`V-#L*(`D)"0D)1U0V-#(V,%]214=?5U))5$4H
M1U0V-#(V,%]'4%!?24Y44E]#055312P@?B@Q/#PH:7)Q+38T*2DI.PH@"0D)
M"7T*+0D)"7T*+0D)"65L<V4@>PHK"0D)?2!E;'-E('L*(`D)"0EI<G$@*ST@
M,S(["B`)"0E]"B`)"7T*(`E]"B`*+0ER971U<FX@:7)Q.PHK"6EF*"!I<G$@
M/"`P("D@('L**PD)<F5T=7)N*"!I<G$@*3L**PE](&5L<V4@('L**PD)<F5T
M=7)N*"!G=#8T,C8P7V9I<G-T25)1("L@:7)Q("D["BL)?0H@?0H@"B`O*B!G
M=#8T,C8P7W5N;6%S:U]I<G$H*0I`0"`M,3@P+#8@*S$X-2PW($!`"B!S=&%T
M:6,@=F]I9`H@9W0V-#(V,%]U;FUA<VM?:7)Q*'5N<VEG;F5D(&EN="!I<G$I
M"B!["BL):7)Q("T](&=T-C0R-C!?9FER<W1)4E$["B`):68@*&ER<2`^(#,Q
M*2!["B`)"6EF("AI<G$@/B`V,RD@>PH@"0D)+RH@=6YM87-K($=04"!I<G$@
M*B\*0$`@+3(Q-2PV("LR,C$L-R!`0`H@<W1A=&EC('9O:60*(&=T-C0R-C!?
M;6%S:U]I<G$H=6YS:6=N960@:6YT(&ER<2D*('L**PEI<G$@+3T@9W0V-#(V
M,%]F:7)S=$E243L*(`EI9B`H:7)Q(#X@,S$I('L*(`D):68@*&ER<2`^(#8S
M*2!["B`)"0DO*B!M87-K($=04"!I<G$@*B\*0$`@+3(S-"PV("LR-#$L-2!`
M0`H@"6EF("AI<G$@/3T@,S8I('L@+RH@4V5E;7,@;F5C97-S87)Y(&9O<B!3
M1$U!(&EN=&5R<G5P=',@*B\*(`D)=61E;&%Y*#$I.PH@"7T*+0HM"7)E='5R
M;CL*('T**PH]/3T]/2!D<FEV97)S+VYE="]G=#8T,C8P7V5T:"YC(#$N-B!V
M<R!E9&ET960@/3T]/3T*+2TM(#$N-B]D<FEV97)S+VYE="]G=#8T,C8P7V5T
M:"YC"51U92!.;W8@,C`@,3,Z,C4Z-#8@,C`P,0HK*RL@961I=&5D+V1R:79E
M<G,O;F5T+V=T-C0R-C!?971H+F,)5&AU($1E8R`R-R`Q-SHS.3HQ,B`R,#`Q
M"D!`("TX-S(L,3(@*S@Y."PQ,B!`0`H@("`@("`@("`@159"-C0R-C!?151(
M7VER<5MP;W)T72LK("`@("`I"B`@("`@>PH@(V5N9&EF"BT@("`@("`@(')E
M='9A;"`](')E<75E<W1?:7)Q*"!'5#8T,C8P7T542%]I<G%;<&]R=%TL"BL@
M("`@("`@(')E='9A;"`](')E<75E<W1?:7)Q*"!'5#8T,C8P7T542%]I<G%;
M<&]R=%T@*R!G=#8T,C8P7V9I<G-T25)1+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@9W0V-#(V,%]E=&A?:6YT7VAA;F1L97(L"B`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("A305])3E1%4E)54%0@?"!305]304U0
M3$5?4D%.1$]-*2P*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(D=4
M-C0R-C!?171H(BP@9&5V("D["B`@("`@("`@(&EF*"`A<F5T=F%L("D@('L*
M+2`@("`@("`@("`@(&1E=BT^:7)Q(#T@1U0V-#(V,%]%5$A?:7)Q6W!O<G1=
M.PHK("`@("`@("`@("`@9&5V+3YI<G$@/2!'5#8T,C8P7T542%]I<G%;<&]R
M=%T@*R!G=#8T,C8P7V9I<G-T25)1.PH@("`@("`@("`@("`@<')I;G1K*"`B
M9W0V-#(V,%]E=&A?;W!E;B`Z($%S<VEG;F5D($E242`E9"!T;R!G=#8T,C8P
M7V5T:"5D7&XB+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("!D978M/FER<2P@<&]R="`I
4.PH@(VEF(#`@+RH@6%A86"`J+PH`
`
end

--==_Exmh_17755128640--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
