Reply-To: <fabidi@ultsol.com>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: "'Stephen Williams'" <612dlag102@sneakemail.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Suggested starting kernel for new PPC405GPr board
Date: Fri, 6 Feb 2004 10:49:42 -0500
Message-ID: <704F2B356FCC3E49A909C625BD9E5C40068B2E@ultsol01.tewks.ultsol.local>
In-Reply-To: <704F2B356FCC3E49A909C625BD9E5C400AB7B1@ultsol01.tewks.ultsol.local>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


try one from penguinppc.org, they maintain the PPC Linux tree. Kernel.org
has the x86 variety.

Fahd

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Stephen
Williams
Sent: Thursday, February 05, 2004 9:15 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Suggested starting kernel for new PPC405GPr board



So I've got my boot loader (u-boot) in seemingly good shape
on my new target board, it's time for me to start thinking
of getting an actual Linux kernel working here. This is
bound to be a FAQ, but are there suggestions for a starting
point? For example, is the kernel at www.kernel.org likely
to be useable?
--
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."




begin 666 ATT00024.htm
M/"%$3T-465!%($A434P@4%5"3$E#("(M+R]7,T,O+T141"!(5$U,(#,N,B\O
M14XB/@T*/$A434P^#0H\2$5!1#X-"CQ-151!($A45% M15%5258](D-O;G1E
M;G0M5'EP92(@0T].5$5.5#TB=&5X="]H=&UL.R!C:&%R<V5T/5=I;F1O=W,M
M,3(U,B(^#0H\345402!.04U%/2)'96YE<F%T;W(B($-/3E1%3E0](DU3($5X
M8VAA;F=E(%-E<G9E<B!V97)S:6]N(#8N,"XV,C0Y+C$B/@T*/%1)5$Q%/E)%
M.B!3=6=G97-T960@<W1A<G1I;F<@:V5R;F5L(&9O<B!N97<@4%!#-# U1U!R
M(&)O87)D/"]4251,13X-"CPO2$5!1#X-"CQ"3T19/@T*/"$M+2!#;VYV97)T
M960@9G)O;2!T97AT+W!L86EN(&9O<FUA=" M+3X-"@T*/% ^/$9/3E0@4TE:
M13TR/G1R>2!O;F4@9G)O;2!P96YG=6EN<'!C+F]R9RP@=&AE>2!M86EN=&%I
M;B!T:&4@4%!#($QI;G5X('1R964N($ME<FYE;"YO<F<@:&%S('1H92!X.#8@
M=F%R:65T>2X\+T9/3E0^#0H\+U ^#0H-"CQ0/CQ&3TY4(%-)6D4],CY&86AD
M/"]&3TY4/@T*/"]0/@T*#0H\4#X\1D].5"!325I%/3(^+2TM+2U/<FEG:6YA
M;"!-97-S86=E+2TM+2T\+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^1G)O
M;3H@;W=N97(M;&EN=7AP<&,M96UB961D961 ;&ES=',N;&EN=7AP<&,N;W)G
M/"]&3TY4/@T*#0H\0E(^/$9/3E0@4TE:13TR/EL\02!(4D5&/2)M86EL=&\Z
M;W=N97(M;&EN=7AP<&,M96UB961D961 ;&ES=',N;&EN=7AP<&,N;W)G(CYM
M86EL=&\Z;W=N97(M;&EN=7AP<&,M96UB961D961 ;&ES=',N;&EN=7AP<&,N
M;W)G/"]!/EU/;B!"96AA;&8@3V8@4W1E<&AE;CPO1D].5#X-"@T*/$)2/CQ&
M3TY4(%-)6D4],CY7:6QL:6%M<SPO1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4]
M,CY396YT.B!4:'5R<V1A>2P@1F5B<G5A<GD@,#4L(#(P,#0@.3HQ-2!033PO
M1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4],CY4;SH@;&EN=7AP<&,M96UB961D
M961 ;&ES=',N;&EN=7AP<&,N;W)G/"]&3TY4/@T*#0H\0E(^/$9/3E0@4TE:
M13TR/E-U8FIE8W0Z(%-U9V=E<W1E9"!S=&%R=&EN9R!K97)N96P@9F]R(&YE
M=R!04$,T,#5'4'(@8F]A<F0\+T9/3E0^#0H\+U ^#0H\0E(^#0H\0E(^#0H-
M"CQ0/CQ&3TY4(%-)6D4],CY3;R!))W9E(&=O="!M>2!B;V]T(&QO861E<B H
M=2UB;V]T*2!I;B!S965M:6YG;'D@9V]O9"!S:&%P93PO1D].5#X-"@T*/$)2
M/CQ&3TY4(%-)6D4],CYO;B!M>2!N97<@=&%R9V5T(&)O87)D+"!I="=S('1I
M;64@9F]R(&UE('1O('-T87)T('1H:6YK:6YG/"]&3TY4/@T*#0H\0E(^/$9/
M3E0@4TE:13TR/F]F(&=E='1I;F<@86X@86-T=6%L($QI;G5X(&ME<FYE;"!W
M;W)K:6YG(&AE<F4N(%1H:7,@:7,\+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%
M/3(^8F]U;F0@=&\@8F4@82!&05$L(&)U="!A<F4@=&AE<F4@<W5G9V5S=&EO
M;G,@9F]R(&$@<W1A<G1I;F<\+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^
M<&]I;G0_($9O<B!E>&%M<&QE+"!I<R!T:&4@:V5R;F5L(&%T('=W=RYK97)N
M96PN;W)G(&QI:V5L>3PO1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4],CYT;R!B
M92!U<V5A8FQE/SPO1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4],CXM+3PO1D].
M5#X-"@T*/$)2/CQ&3TY4(%-)6D4],CY3=&5V92!7:6QL:6%M<R9N8G-P.R9N
M8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P
M.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R F<75O=#M4
M:&4@=V]O9',@87)E(&QO=F5L>2P@9&%R:R!A;F0@9&5E<"X\+T9/3E0^#0H-
M"CQ"4CX\1D].5"!325I%/3(^<W1E=F4@870@:6-A<G5S+F-O;29N8G-P.R9N
M8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P
M.R9N8G-P.R!"=70@22!H879E('!R;VUI<V5S('1O(&ME97 L/"]&3TY4/@T*
M#0H\0E(^/$9/3E0@4TE:13TR/CQ!($A2148](FAT=' Z+R]W=W<N:6-A<G5S
M+F-O;2(^:'1T<#HO+W=W=RYI8V%R=7,N8V]M/"]!/B9N8G-P.R9N8G-P.R9N
M8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R!A;F0@;&EN97,@
M=&\@8V]D92!B969O<F4@22!S;&5E<"P\+T9/3E0^#0H-"CQ"4CX\1D].5"!3
M25I%/3(^/$$@2%)%1CTB:'1T<#HO+W=W=RYP:6-T=7)E;"YC;VTB/FAT=' Z
M+R]W=W<N<&EC='5R96PN8V]M/"]!/B9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P
M.R9N8G-P.R9N8G-P.R!!;F0@;&EN97,@=&\@8V]D92!B969O<F4@22!S;&5E
M<"XF<75O=#L\+T9/3E0^#0H\+U ^#0H\0E(^#0H-"CQ0/CQ&3TY4(%-)6D4]
M,CXJ*B!396YT('9I82!T:&4@;&EN=7AP<&,M96UB961D960@;6%I;"!L:7-T
M+B!3964@/$$@2%)%1CTB:'1T<#HO+VQI<W1S+FQI;G5X<'!C+F]R9R\B/FAT
M=' Z+R]L:7-T<RYL:6YU>'!P8RYO<F<O/"]!/CPO1D].5#X-"CPO4#X-"@T*
0/"]"3T19/@T*/"](5$U,/@``
`
end


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
