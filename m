Message-Id: <200304211335.AA02623@kishinami.cs.fujitsu.co.jp>
From: KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>
Date: Mon, 21 Apr 2003 22:35:38 +0900
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH][BUGFIX][2.4.21] Fix PPC4xx Ethernet problem 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--------------------1249057652124064"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is multipart message.

----------------------1249057652124064
Content-Type: text/plain; charset=us-ascii

Dear maintainers;

Attached file is effective the failure not to generate the receive
completion interruption from EMAC to 405GP On-chip LAN device driver.
The failure condition is as follows.

- custom board designed based on the 405GP
- kernel 2.4.18
- 2.4.21 pre3 ibm_ocp LAN device driver and ported it to
  work on kernel 2.4.18
- repeater hub(10Mbps, half duplex)
- line is much loaded

The modification was applied from 2.4.21 pre3.
Please see the follows URL. It describes in detail.
http://lists.linuxppc.org/linuxppc-embedded/200304/msg00171.html
Please apply attached file.

Regards, Kishinami

-----
KISHINAMI Masaya
Fujitsu Limited (Japan)

----------------------1249057652124064
Content-Type: application/octet-stream;
	name="linux-PPC4xx.patch"
Content-Transfer-Encoding: X-uuencode
Content-Disposition: attachment;
	filename="linux-PPC4xx.patch"

begin 644 linux-PPC4xx.patch
M+2TM(&QI;G5X<'!C7S(N-"XR,2YP<F4S+V1R:79E<G,O;F5T+VEB;5]O8W`O
M:6)M7V]C<%]E;F5T+F,)5&AU($IA;B`R,R`P,3HS.#HT-R`R,#`S"BLK*R!L
M:6YU>'!P8U\R+C0N,C$N<')E,RYM;V1I9GDO9')I=F5R<R]N970O:6)M7V]C
M<"]I8FU?;V-P7V5N970N8PE-;VX@07!R(#(Q(#(Q.C(V.C4P(#(P,#,*0$`@
M+3(Q,"PV("LR,3`L.2!`0`H@(VEN8VQU9&4@(FEB;5]O8W!?96YE="YH(@H@
M(VEN8VQU9&4@(FEB;5]O8W!?;6%L+F@B"B`**R\J(&5N86)L92!R96-E:79E
M(&5R<F]R('!A8VME="`J+PHK(V1E9FEN92!20U9?15)2("`@($5-04-?4DU2
M7T%24E`@?"!%34%#7U)-4E]!4E`**PH@+RH@1F]R=V%R9"!D96-L87)A=&EO
M;G,@;V8@<V]M92!S=')U8W1U<F5S('1O('-U<'!O<G0@9&EF9F5R96YT(%!(
M67,@*B\*(`H@<W1A=&EC(&EN="!P<&,T,#5?96YE=%]O<&5N*'-T<G5C="!N
M971?9&5V:6-E("HI.PI`0"`M,S0P+#<@*S,T,RPY($!`"B`);W5T7V)E,S(H
M)F5M86-P+3YE;3!M<C$L(&UO9&5?<F5G*3L*(`H@"2\J(&5N86)L92!B<F]A
M9&-A<W0@86YD(&EN9&EV:61U86P@861D<F5S<R`J+PHM"6]U=%]B93,R*"9E
M;6%C<"T^96TP<FUR+"!%34%#7U)-4E])044@?"!%34%#7U)-4E]"044I.PHK
M("`@("`@("`O*B!A9&0@96YA8FQE(')E8V5I=F4@97)R;W(@<&%C:V5T("HO
M"BL);W5T7V)E,S(H)F5M86-P+3YE;3!R;7(L"BL@("`@("`@("`@("!20U9?
M15)2('P@($5-04-?4DU27TE!12!\($5-04-?4DU27T)!12D["B`*(`DO*B!S
M970@=')A;G-M:70@<F5Q=65S="!T:')E<VAO;&0@<F5G:7-T97(@*B\*(`EO
M=71?8F4S,B@F96UA8W`M/F5M,'1R='(L($5-04-?5%)44E\R-38I.PI`0"`M
M-#@R+#$U("LT.#<L,3<@0$`*(`EI9B`H9&5V+3YF;&%G<R`F($E&1E]04D]-
M25-#*2!["B`*(`D)+RH@268@<')O;6ES8W5O=7,@;6]D92!I<R!S970@=&AE
M;B!W92!D;R!N;W0@;F5E9"!A;GET:&EN9R!E;'-E("HO"BT)"6]U=%]B93,R
M*"9E;6%C<"T^96TP<FUR+"!%34%#7U)-4E]0344I.PHK("`@("`@("`@("`@
M("`@("\J(&%D9"!E;F%B;&4@<F5C96EV92!E<G)O<B!P86-K970@*B\**PD)
M;W5T7V)E,S(H)F5M86-P+3YE;3!R;7(L(%)#5E]%4E(@?"!%34%#7U)-4E]0
M344I.PH@"B`)?2!E;'-E(&EF("AD978M/F9L86=S("8@249&7T%,3$U53%1)
M('Q\(#,R(#P@9&5V+3YM8U]C;W5N="D@>PH@"B`)"2\J($UU<W0@8F4@<V5T
M=&EN9R!U<"!T;R!U<V4@;75L=&EC87-T+B`@3F]W(&-H96-K(&9O<B!P<F]M
M:7-C=6]U<PH@"0D@*B!M=6QT:6-A<W0*(`D)("HO"BL@("`@("`@("`@("`@
M("`@+RH@861D(&5N86)L92!R96-E:79E(&5R<F]R('!A8VME="`J+PH@"0EO
M=71?8F4S,B@F96UA8W`M/F5M,')M<BP*+0D)"2!%34%#7U)-4E])044@?"!%
M34%#7U)-4E]"044@?"!%34%#7U)-4E]034U%*3L**PD)"2`@4D-67T524B!\
M($5-04-?4DU27TE!12!\($5-04-?4DU27T)!12!\($5-04-?4DU27U!-344I
M.PH@"7T@96QS92!I9B`H9&5V+3YF;&%G<R`F($E&1E]-54Q424-!4U0@)B8@
M,"`\(&1E=BT^;6-?8V]U;G0I('L*(`H@"0EU;G-I9VYE9"!S:&]R="!E;3!G
M86AT6S1=(#T@>R`P+"`P+"`P+"`P('T["D!`("TU,3(L,30@*S4Q.2PQ-B!`
M0`H@"0EE;6%C<"T^96TP9V%H=#0@/2!E;3!G86AT6S-=.PH@"B`)"2\J(%1U
M<FX@;VX@;75L=&EC87-T(&%D9')E<W-I;F<@*B\**R`@("`@("`@("`@("`@
M("`O*B!A9&0@96YA8FQE(')E8V5I=F4@97)R;W(@<&%C:V5T("HO"B`)"6]U
M=%]B93,R*"9E;6%C<"T^96TP<FUR+`HM"0D)($5-04-?4DU27TE!12!\($5-
M04-?4DU27T)!12!\($5-04-?4DU27TU!12D["BL)"0D@4D-67T524B!\($5-
M04-?4DU27TE!12!\($5-04-?4DU27T)!12!\($5-04-?4DU27TU!12D["B`*
M(`E](&5L<V4@>PH@"0DO*B!)9B!M=6QT:6-A<W0@;6]D92!I<R!N;W0@<V5T
M('1H96X@=V4@87)E(`H@"0D@*B!T=7)N:6YG(&ET(&]F9B!A="!T:&ES('!O
M:6YT(`H@"0D@*B\*+0D);W5T7V)E,S(H)F5M86-P+3YE;3!R;7(L($5-04-?
M4DU27TE!12!\($5-04-?4DU27T)!12D["BL@("`@("`@("`@("`@("`@+RH@
M861D(&5N86)L92!R96-E:79E(&5R<F]R('!A8VME="`J+PHK"0EO=71?8F4S
M,B@F96UA8W`M/F5M,')M<BP@4D-67T524B!\($5-04-?4DU27TE!12!\($5-
504-?4DU27T)!12D["B`*(`E]"B`*
`
end

----------------------1249057652124064--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
