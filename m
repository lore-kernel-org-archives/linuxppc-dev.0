Reply-To: <fabidi@ultsol.com>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Need to modify the Program Header info
Date: Tue, 27 Jan 2004 10:44:33 -0500
Message-ID: <704F2B356FCC3E49A909C625BD9E5C40021460@ultsol01.tewks.ultsol.local>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I have a situation where the program headers built into an ELF executable
seem like they are incorrect. The target is an MPC5200,  Here are the
program header and section header info:

Program Header:
    LOAD off    0x00000000 vaddr 0x80000000 paddr 0x80000000 align 2**16
         filesz 0x00009fc0 memsz 0x00009fc0 flags rwx

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00001f80  80008000  80008000  00008000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000040  80009f80  80009f80  00009f80  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  80009fc0  80009fc0  00009fc0  2**0
                  ALLOC
  3 .stab         0000219c  80009fc0  80009fc0  00009fc0  2**2
                  CONTENTS, READONLY, DEBUGGING
  4 .comment      00000098  8000d838  8000d838  0000c15c  2**0
                  CONTENTS, READONLY
  5 .stabstr      000016dc  8000c15c  8000c15c  0000c1f4  2**0
                  CONTENTS, READONLY, DEBUGGING

The Section header displays the correct load address, file offset and
Alignment information. The program header is incorrect. Does anyone know of
a way to modify the program header without messing around with the ld
script? I looked at objcopy and it seemed like it might do the trick but I
can't figure out what commands to use to change the program header
information.

Thanks for the help!!

Fahd Abidi
Field Applications Engineer
Ultimate Solutions, Inc.
=================================================
Professional Development Tools for Embedded Systems
Toll Free: 866-455-3383 x205
Facsimile: 978-926-3091
Email: fabidi@ultsol.com
www: http://www.ultsol.com
FAQ: http://www.ultsol.com/Faqs.htm


begin 666 ATT00047.htm
M/"%$3T-465!%($A434P@4%5"3$E#("(M+R]7,T,O+T141"!(5$U,(#,N,B\O
M14XB/@T*/$A434P^#0H\2$5!1#X-"CQ-151!($A45% M15%5258](D-O;G1E
M;G0M5'EP92(@0T].5$5.5#TB=&5X="]H=&UL.R!C:&%R<V5T/5=I;F1O=W,M
M,3(U,B(^#0H\345402!.04U%/2)'96YE<F%T;W(B($-/3E1%3E0](DU3($5X
M8VAA;F=E(%-E<G9E<B!V97)S:6]N(#8N,"XV,C0Y+C$B/@T*/%1)5$Q%/DYE
M960@=&\@;6]D:69Y('1H92!0<F]G<F%M($AE861E<B!I;F9O/"]4251,13X-
M"CPO2$5!1#X-"CQ"3T19/@T*/"$M+2!#;VYV97)T960@9G)O;2!T97AT+W!L
M86EN(&9O<FUA=" M+3X-"@T*/% ^/$9/3E0@4TE:13TR/DAE;&QO(&%L;"P\
M+T9/3E0^#0H\+U ^#0H-"CQ0/CQ&3TY4(%-)6D4],CY)(&AA=F4@82!S:71U
M871I;VX@=VAE<F4@=&AE('!R;V=R86T@:&5A9&5R<R!B=6EL="!I;G1O(&%N
M($5,1B!E>&5C=71A8FQE('-E96T@;&EK92!T:&5Y(&%R92!I;F-O<G)E8W0N
M(%1H92!T87)G970@:7,@86X@35!#-3(P,"PF;F)S<#L@2&5R92!A<F4@=&AE
M('!R;V=R86T@:&5A9&5R(&%N9"!S96-T:6]N(&AE861E<B!I;F9O.CPO1D].
M5#X\+U ^#0H-"CQ0/CQ&3TY4(%-)6D4],CY0<F]G<F%M($AE861E<CH\+T9/
M3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^)FYB<W [)FYB<W [)FYB<W [($Q/
M040@;V9F)FYB<W [)FYB<W [)FYB<W [(#!X,# P,# P,# @=F%D9'(@,'@X
M,# P,# P,"!P861D<B P>#@P,# P,# P(&%L:6=N(#(J*C$V/"]&3TY4/@T*
M#0H\0E(^/$9/3E0@4TE:13TR/B9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N
M8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R!F:6QE<WH@,'@P,# P.69C,"!M96US
M>B P># P,# Y9F,P(&9L86=S(')W>#PO1D].5#X-"CPO4#X-"@T*/% ^/$9/
M3E0@4TE:13TR/E-E8W1I;VYS.CPO1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4]
M,CY)9'@@3F%M929N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P
M.R9N8G-P.R9N8G-P.R9N8G-P.R!3:7IE)FYB<W [)FYB<W [)FYB<W [)FYB
M<W [)FYB<W [(%9-029N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N
M8G-P.R!,34$F;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#L@
M1FEL92!O9F8F;F)S<#L@06QG;CPO1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4]
M,CXF;F)S<#L@," N=&5X="9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P
M.R9N8G-P.R9N8G-P.R9N8G-P.R P,# P,68X,"9N8G-P.R X,# P.# P,"9N
M8G-P.R X,# P.# P,"9N8G-P.R P,# P.# P,"9N8G-P.R R*BHR/"]&3TY4
M/@T*#0H\0E(^/$9/3E0@4TE:13TR/B9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P
M.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N
M8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R!#3TY414Y44RP@
M04Q,3T,L($Q/040L(%)%041/3DQ9+"!#3T1%/"]&3TY4/@T*#0H\0E(^/$9/
M3E0@4TE:13TR/B9N8G-P.R Q("YD871A)FYB<W [)FYB<W [)FYB<W [)FYB
M<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [(# P,# P,#0P)FYB<W [(#@P
M,# Y9C@P)FYB<W [(#@P,# Y9C@P)FYB<W [(# P,# Y9C@P)FYB<W [(#(J
M*C(\+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^)FYB<W [)FYB<W [)FYB
M<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [
M)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [($-/
M3E1%3E13+"!!3$Q/0RP@3$]!1"P@1$%403PO1D].5#X-"@T*/$)2/CQ&3TY4
M(%-)6D4],CXF;F)S<#L@,B N8G-S)FYB<W [)FYB<W [)FYB<W [)FYB<W [
M)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [(# P,# P,# P)FYB<W [
M(#@P,# Y9F,P)FYB<W [(#@P,# Y9F,P)FYB<W [(# P,# Y9F,P)FYB<W [
M(#(J*C \+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^)FYB<W [)FYB<W [
M)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB
M<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [
M($%,3$]#/"]&3TY4/@T*#0H\0E(^/$9/3E0@4TE:13TR/B9N8G-P.R S("YS
M=&%B)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [
M)FYB<W [(# P,# R,3EC)FYB<W [(#@P,# Y9F,P)FYB<W [(#@P,# Y9F,P
M)FYB<W [(# P,# Y9F,P)FYB<W [(#(J*C(\+T9/3E0^#0H-"CQ"4CX\1D].
M5"!325I%/3(^)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [
M)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB
M<W [)FYB<W [)FYB<W [)FYB<W [($-/3E1%3E13+"!214%$3TY,62P@1$5"
M54='24Y'/"]&3TY4/@T*#0H\0E(^/$9/3E0@4TE:13TR/B9N8G-P.R T("YC
M;VUM96YT)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [(# P,# P,#DX
M)FYB<W [(#@P,#!D.#,X)FYB<W [(#@P,#!D.#,X)FYB<W [(# P,#!C,35C
M)FYB<W [(#(J*C \+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^)FYB<W [
M)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB
M<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [
M)FYB<W [($-/3E1%3E13+"!214%$3TY,63PO1D].5#X-"@T*/$)2/CQ&3TY4
M(%-)6D4],CXF;F)S<#L@-2 N<W1A8G-T<B9N8G-P.R9N8G-P.R9N8G-P.R9N
M8G-P.R9N8G-P.R P,# P,39D8R9N8G-P.R X,# P8S$U8R9N8G-P.R X,# P
M8S$U8R9N8G-P.R P,# P8S%F-"9N8G-P.R R*BHP/"]&3TY4/@T*#0H\0E(^
M/$9/3E0@4TE:13TR/B9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N
M8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P
M.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R!#3TY414Y44RP@4D5!1$].3%DL
M($1%0E5'1TE.1SPO1D].5#X-"CPO4#X-"@T*/% ^/$9/3E0@4TE:13TR/E1H
M92!396-T:6]N(&AE861E<B!D:7-P;&%Y<R!T:&4@8V]R<F5C="!L;V%D(&%D
M9')E<W,L(&9I;&4@;V9F<V5T(&%N9"!!;&EG;FUE;G0@:6YF;W)M871I;VXN
M(%1H92!P<F]G<F%M(&AE861E<B!I<R!I;F-O<G)E8W0N($1O97,@86YY;VYE
M(&MN;W<@;V8@82!W87D@=&\@;6]D:69Y('1H92!P<F]G<F%M(&AE861E<B!W
M:71H;W5T(&UE<W-I;F<@87)O=6YD('=I=&@@=&AE(&QD('-C<FEP=#\@22!L
M;V]K960@870@;V)J8V]P>2!A;F0@:70@<V5E;65D(&QI:V4@:70@;6EG:'0@
M9&\@=&AE('1R:6-K(&)U="!)(&-A;B=T(&9I9W5R92!O=70@=VAA="!C;VUM
M86YD<R!T;R!U<V4@=&\@8VAA;F=E('1H92!P<F]G<F%M(&AE861E<B!I;F9O
M<FUA=&EO;BX\+T9/3E0^/"]0/@T*#0H\4#X\1D].5"!325I%/3(^5&AA;FMS
M(&9O<B!T:&4@:&5L<"$A/"]&3TY4/@T*/"]0/@T*#0H\4#X\1D].5"!325I%
M/3(^1F%H9"!!8FED:3PO1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4],CY&:65L
M9"!!<'!L:6-A=&EO;G,@16YG:6YE97(\+T9/3E0^#0H-"CQ"4CX\1D].5"!3
M25I%/3(^56QT:6UA=&4@4V]L=71I;VYS+"!);F,N/"]&3TY4/@T*#0H\0E(^
M/$9/3E0@4TE:13TR/CT]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T\+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^
M4')O9F5S<VEO;F%L($1E=F5L;W!M96YT(%1O;VQS(&9O<B!%;6)E9&1E9"!3
M>7-T96US/"]&3TY4/@T*#0H\0E(^/$9/3E0@4TE:13TR/E1O;&P@1G)E93H@
M.#8V+30U-2TS,S@S('@R,#4\+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^
M1F%C<VEM:6QE.B Y-S@M.3(V+3,P.3$\+T9/3E0^#0H-"CQ"4CX\1D].5"!3
M25I%/3(^16UA:6PZ(&9A8FED:4!U;'1S;VPN8V]M/"]&3TY4/@T*#0H\0E(^
M/$9/3E0@4TE:13TR/G=W=SH@/$$@2%)%1CTB:'1T<#HO+W=W=RYU;'1S;VPN
M8V]M(CYH='1P.B\O=W=W+G5L='-O;"YC;VT\+T$^/"]&3TY4/@T*#0H\0E(^
M/$9/3E0@4TE:13TR/D9!43H@/$$@2%)%1CTB:'1T<#HO+W=W=RYU;'1S;VPN
M8V]M+T9A<7,N:'1M(CYH='1P.B\O=W=W+G5L='-O;"YC;VTO1F%Q<RYH=&T\
D+T$^/"]&3TY4/@T*/"]0/@T*#0H\+T)/1%D^#0H\+TA434P^
`
end


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
