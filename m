Mime-Version: 1.0
Message-Id: <v04220801b4d927f346db@[10.0.0.42]>
In-Reply-To: <38B341A7.9F6E5DEC@grn.georet.net>
References: <38B341A7.9F6E5DEC@grn.georet.net>
Date: Tue, 22 Feb 2000 22:07:36 -0800
To: rboder@grn.georet.net, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: PowerMac G4 and pcmcia flash cards
Content-Type: multipart/mixed; boundary="============_-1260836438==_============"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--============_-1260836438==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"

At 9:10 PM -0500 2/22/00, Ryan Boder wrote:
>Hi,
>
>need to write a little boot prom and I would like to use my G4 to put it
>on a flash card. I have tried using pcmcia card services by David Hinds
>and it won't even install.

Do you mean a binary installation?  Or were you trying to recompile?

>  This is no surprise since he claims in the
>HOWTO that Macs are not supproted yet.

It's not supported by him, but pcmcia-cs 3.0.14 should work on 2.2.x
kernels, especially if patched with the attached patchfile before
compiling.

>  How you guys been using pcmcia
>devices and does anyone know if I can do it on my G4?

Well, you're going to face a pretty fundamental barrier in that the
G4 does not have any PCMCIA sockets.  Despite appareances, the
internal AirPort socket on the AGP models is not PCMCIA.  It will not
work at all with anything other than an AirPort card.
--============_-1260836438==_============
Content-Id: <v04220801b4d927f346db@[10.0.0.42].0.0>
Content-Type: application/mac-binhex40; name="pcmcia-cs-3.0.14.ppc.patch"
Content-Disposition: attachment; filename="pcmcia-cs-3.0.14.ppc.patch"
 ; modification-date="Thu, 9 Dec 1999 01:39:46 -0800"

(This file must be converted with BinHex 4.0)

:'R"ME@0TB5eMFbdc,M!Z-63ZF("M,R"KG'0S!&4&@&45+Q0S!3!!!"BZ!!!!!'r
FC'PQCL!YG8jb)("ME@0TB5eMFbdc,M!Z-63ZEh*TCbpME'PPER4c,c0M06FeAf0
L,Q-JF'0YBfPK,@0c,6-Z-#ia0#pME'PPER4c,c0M06FeAf0L,Q-+,5dY)("ME@0
TB5eMFbdc,M!Z-63ZEh*TCbpME'PPER4c,c0M06FeAf0L,Q-*9'Ke)%TeE#!b-L!
a-$Sa-6Sb15!a16Nj#LXV+b"`BfeMD@%YBh-Y-bi`,M%d,f0XD@9ZG(-[-f-e0c9
IBf)ZB`P0EfiJ3A9R)$-`)$%h1M%`1M3`)$%j16N+3%!J,6%e-M)X0b!V-68b-L`
h)%"!#L!*#5mU)'4PGLdqG'*eFhNJGfPXE#"LC5"ME'9KFQ9N)'&d)(4SC5"%68&
%EfjP)'PZG'9bFR9`G#iJ+Lm+)!Pp)'9XFf8JH`SJ#3N[+L!Z,LiJB@jN)(4SC5"
`B@0VCA3JFQpeEQ4PC#"dEb"K)'4[G@*XCAG[FQ3Z)#S[#Ld*#@peG(0X+'P[B@4
NFL!V)&4BAdC*4NmX)(0VBLdqC'&dB5`J+(0VBLdqE'9Z)#XJ-bNJ2MiJ-LNl#LX
*#@peG(0XAfjc+'P[B@4NFL!V)&4BAdC*4NmX)(0VBLdqC'&dB5`J+(0VBLdqE'9
Z)#XJ-bNJ2MiJ-LNl#L!*#84&9Pp'8N9&Ae0,3LKcDf)T1`SJ#3PTCL!SD@jh+'P
[B@4NFL!V)&4i4R*PC5NJ2L!a06-f+5"l#L!*#3PME'9KFPpLDA3S-#`J+(C[D@3
U+5CNCABY2R4LGA0j+6X+3%!J,6%h1$NX0b!V-6Fi15`h)%"!#L!*#3N*#AGSD@a
P)#KTERFSD@pKC'4b)#XJ9fihAdeKFh4PFP0dBA4eFbNJ*L!`H$J`-$!T#L!*#3N
*#3Nl#L!*#3N*I5"PE(0P)(X+,3N*#3N*D@jcE#KTEf&NC()J+b"5@&p'58C2,#"
cDf*IF(9d+(0VBL`JF'YdAfaPELNX#LX*#3N*#@PZFfaIER-SD@pKC'4b)#XJ8PK
I4NP'6b`JFfYLAh"eG#KcDf)X)("VG&pXC@iT,!SJ#3N*#3N*)#K`Dh4IE'9Z)#X
J-bNJ2MiJ-LNl#L!*#3N*I3SJ#3N*#@peG(FS8RK%DA0MBA*N,#"TEf&NC()J+b"
&6$0I3de%+6XJ,bSJ8'p`)(4[F#"5H#"`B@0VCA3Z)#S[#Q4TCQBJ,A91FL"`Bfe
MD@%YBh-Y-bi`,M%d,QpbD@F[BfaTC@jdFbpcE@-j-@-j-PpMFbjM)("ME@0TB5e
MFbdc,M!Z-63[BfaTC@jdFbpcE@-j-@-j-PpMFbjM#LdY,5"`BfeMD@%YBh-Y-bi
`,M%d,QpbD@F[BfaTC@jdFbpcE@-j-@-j-PpMFbjM#8e[EL"+G@`J-MBJ-6!k-$J
k-$FJ-6Nj13SV+bXJF'0YBfPK,@0c,6-Z-#ia0#pME'PPER4c,h0YBcNaBcNbAf0
c,Q-*6@pZ)%&eCb!c-#!a0cSa-$Sd-#!a16Nj#N"!)#da-c%a,$FJ+c%c-6%X0b"
!3!SJ)fPQC'9Q)&9649mc-Pp#593+)!P[GA4X+#KXC@jRG'JV0LNJ2$`J-6BX)'P
[B@4NFL!V)%4"9%&I-5Nl#L!*D@BJ+'aPEQGdD#!Q)$"i-LNJH`SY#5!J)#"[GA4
cE#KTEf&NC()J+b"%394"Ac%X)'*eCL`J)'aPEQGdD#!q2L!b)#Nl#LX*)#!J)'p
eG(0XAfjc+'P[B@4NFL!V)%4"9%&I-5`JBR9Q,#!JE'9ZCh4S)$iq)$)J+6X+)!N
J)#!JEh9dGbJJ+LJSG@PZG$%f)#ST+'*eCL!V)#KXC@jRG'JJ*L!`H%C'4NC'4NC
$+5NT,'P[B@4NFL!V4%&839ma+6X+)!Pp)'9XFf8+)!NJ)#!JEh9dFfaIER-SD@p
KC'4b)#XJ4%&839ma,#"LG@BX)#"XC@jRG'JJ2MiJ-L!T1`TND@CQ)#ee6R)JF'0
YBfPK,@0c,6-Z-#ia0#j[FQPR,f9dBbpMEfjQD@FJF'0YBfPK,@0c,6-Z-#ia0#p
PG'-[BfpZCQPR#LdY,5"`BfeMD@%YBh-Y-bi`,M%d,QpbD@F[CA4M,f0[EQCTC`P
8D(8J5R9X)$)j)$)c1M!j1M%d)$%j16N++bXV)("ME@0TB5eMFbdc,M!Z-63[CA4
M,f0[EQCTC`P0EfiJ3A9R)$-`)$%h1M%`1M3`)$%j16N+3%!J,6-h,$FJ+c-h,$F
J3%!+)#!JBfaKFh-J)QCdE#)JE@pNG@aP)#*QG'aIBh-L#L!+)'4PGQPMC5!LFf9
bD@&XAf0c)JSY)#"ME'&cFb!LFf9bD@&X)L"YEf4eE'8J)R0PFQPKE&pMFb)++b!
JBfaKFh-J)R0PFQPKE#)JE@pNG@aP)#*YDA0M,h0PFQPKE#)X)#*cCA*TB@aIBh-
L#L!+)'4PGQPMC5!LF'&bF'pbG&pMFb)+)#!JBfaKFh-J)R"KFR"[FR3L)'e[C(9
XC5!LF'&bF'pbG&pMFb)+C'PQCL!YG8jb)("ME@0TB5eMFbdc,M!Z-63ZEh*TCbp
PG'-[BfpZCQPR,Qp`G(-JF'0YBfPK,@0c,6-Z-#ia0#pPG'-[BfpZCQPR,Qp`G(-
+,5dY)("ME@0TB5eMFbdc,M!Z-63ZEh*TCbpPG'-[BfpZCQPR,Qp`G(-*4R*T)%T
eEL!J0#!a-$Sb06Sd1#!a16Nj#LXV+b"`BfeMD@%YBh-Y-bi`,M%d,f9dBbpMEfj
QD@FZEh"dF`P0EfiJ3A9R)$-`)$%h1M%`1M3`)$%j16N+3%!J,6-X-M)J+c-X-6%
J3%!+)#-+)#-J8hPcG'9Y)(*PFfpeFQ0PFb"KGQ&TE'&LE'8JCQpb)&"$680*35"
NCACTBf9c#L!M#LeTEQ0XG@4P)("[FR3J-(Ja-$!Y-(JdCQBX)("[FR3J-(Ja-$!
`,6"i-6GQCJSYD@jME(9NC5"YC@e[FRNJ-(KM-$!`-#d`H'CQCQCQ#LeTEQ0XG@4
P)'ePE@pbH5!`H'%`-$!`-$!`,6"iB6"QCQCQCQBX)'ePE@pbH5!`H$B`-$!`-$!
`,6"i0M"QCQCQCQB+,5-+,5-J4AKdFQ%JF'pbG#"bB@jRC5"QEh)J58*0)&4[Df9
Z)&*TEQF+,5-+,@PZBfaeC'8JF'pbG#!`H'%`-#d`H'&QCJSVD@jME(9NC5"`Eh*
d)$"i-#d`H'CQCJSVD@jME(9NC5"YC@e[FRNJ-(Jj-$!`-$!`-#d`H$N`CQCQCQC
Q#L!M#L!M)&*PFfpeFQ0PFb"hC5"cD'peE'3JEQpd)(9cC5`JCACPEL"TCL"dD'9
j)'&`F'9KFL"dEb"LC5"KGQ&TE'&LE'8+)#-+,5-J4QPbFh3JBR9TE(3YD@iJFf9
bD@&X)("[FR3+,@9iBfaeC'8JDA*a)$3+,5-J8f9MEfjN)'*eD@ad,@PZ)(0PFQP
KE#"`Eh*d#LdMCAKME(9NC5"TFR%J-`SY)b"'DA*cG#"LG@PXG#eTEL"`BA*KE'a
PE#"`Eh*d#LePH'0XG@4P)'PbF5!h#L!M#L!M)%9iB@e`E'9c)'pQ)'p`G'P[ER-
JCQpb)'a[B@4KBQaP)'e[C(9XCA-+)#-+C'PQCL!YG8jb)("ME@0TB5eMFbdc,M!
Z-63ZEh*TCbpYEf4eE'9c,f0c,Q-JF'0YBfPK,@0c,6-Z-#ia0#pYEf4eE'9c,f0
c,Q-+,5dY)("ME@0TB5eMFbdc,M!Z-63ZEh*TCbpYEf4eE'9c,f0c,Q-*9'Ke)%T
eE#!b15!b-$Sd0MSa-L!a16Nj#LXV+b"`BfeMD@%YBh-Y-bi`,M%d,fe[C(9XCA-
[Bh-ZB`P0EfiJ3A9R)$-`)$%h1M%`1M3`)$%j16N+3%!J,63a-L`f)#Xd-6)X-6!
J3%!+)#!J)#![+L"#E'&ZDb"[GA3JG'KP)(0[BfYPG#"cG'&dC5!U,`SJ)#!J)(-
Y2R0dBA4P)#Bp)&023dY&9&p38N9648j8I&023dY&9&p649498&p348j%58j(1`S
J)#!J)'PZDA4IFfpMDf9d+(-T1`SV)fPQC'9Q)&pIF'phCA*`BepI#LXJ)#!JFbd
qFfpMDf9d,QCXB@Gc)(`p)&06Ad9+480858p11`SV)#!J)(-Y2R0cAf9ZG(*j+(-
Y2R0[BfXX)&06Ae0PG&0[BfYPG#`J*R-Y2R0[BfYPG#Nl#LXMC@jND@B+)#!J)#"
c,6jTFR%Z3A0cD@GZC@4*8P%J25"c,6jTFR%Z3fpZCQPR)$dJ-$X+)#!J)#"c,6j
QG@jMG'P[ER-J25!`1`SJ)#!J)(-Y2Qa[BfYIBfpeER3J25!`1`TND@CQ)#ee6R)
JF'0YBfPK,@0c,6-Z-#ia0#j[FQPR,fe[C(9XCA-[D6Jb-cBe,Q-JF'0YBfPK,@0
c,6-Z-#ia0#pYEf4eE'9c,fNi-M-f05jM#LdY,5"`BfeMD@%YBh-Y-bi`,M%d,Qp
bD@F[E@pNG@aPFbpT1$)c0M8ZB`P8G@8J5R9X)$)`)$!j1M!a1M)h)$%j16N++bX
V)("ME@0TB5eMFbdc,M!Z-63[E@pNG@aPFbpT1$)c0M8ZB`P0EfiJ3A9R)$-`)$%
h1M%`1M3`)$%j16N+3%!J,63b,$BJ+c3b,$%c)%"!#L!MD@jME(9NC5!mBA0Y,f*
TG'p`FbjS2JSJ)fPZBfaeC'8J2'&cE5pcC@GYC@jd,QJq#L!MD@jME(9NC5!mBA0
Y,h0jFh4PE5jS2JSV#LXMD@CNC@BJAep`EhGPFR"MAem++b0TEQ0XG@4P)$aKFfd
[F(*[E5jS2JSV)fPZBfaeC'8J2'&cE5pKC')ZD$i++b0TEQ0XG@4P)$aKFfd[F'e
e,QJq#LXMC@jND@B++`SJ)f9ZC'PQ#L!+)#0TEQ0XG@4P)$a`BfeMD@%[GQ9bFfP
[ELjS2JT!3#!Y-MBd,$BJ+c)h-5`a-#"!3!SJ)#!J)(9IBfKKFJN*Bf&MD'8X)("
YBh-l#L!J)#!JG9pTER3*#@0LAh"SHA-l#L!J)#!JBfKKFJN*+Q0LAhCTFR3l#LX
MD@CNC@BJAep`EhGPFR"MAem++b!J)#"TER3*#3P`EA9IFfpMDf9d1`SV)#!J)(0
dFR9MG#"KC'*IFQ9aG@9cG!P`EA9IFQ9a1`SV)f9ZC'PQ#L!MC@jND@B+)#!J)#"
eEQP[EL"l#L!*BfPbFR9cAh0dBA4PAh3*#@0TFR*eFcX+3%!J,6%f-6)X0L!V-6B
b-b`c-L"!3!SJ#5!J)#"d@fPG,Q0KF#jTFR&IE@&cDb"m25!S-5!m2#"d@fPG,Q0
KF#j`BfPIDA*a+6X+)!Pd@fPG,Q0cAfPbF5!p)'PcB9pTFR%l#L!J)#!JI3SV)fP
QC'9Q)&pIF'phCA*`BepI#LXJ)#!J,bSJGfpbDb"[GA3JG'KP)'eKF("TEQFJG'm
J8%e9)(0[BfYPG#"ZG@eLCA)J+Lm++b!J)#"l#LX*Fh4bG@0d)'4PGQPMC9pZEf4
P)#TZF$X++`PQEh)J+'NJ25!`1b"T)$`JER-l)#XVD5NJH`SV#5!J)#"d@fPG,R"
YG9pcEf0VCA3J25!`1`SV#5!J)#"d@fPG,R"YG9pbCA%ZBfpYF'aPG'8J25!a1`S
V#Ad++`PQEh)J+'j`)$dJCQPZC&pdHA"PAf4PGQPMCA-S)R"MBf&bC#)T1b"ZF#!
K25"198a-1b"ZF#!p)'j`,6jZCAKd+5"l#LX*)#!J)'PZG#!UFQ9R)$dJ+'PZG#!
U+5"RCA4IF(*[F'9bG(NSER!X)#*bC@FL,#"198a-+6X++`NJ)#!JD@jd)#T`Fb!
p)#KTER3J+LNJCf9dAh"bEh"PFR4j+'j`,#!L38&36#a`EA8YFfpMDf9d,@jeE@*
PFL)X)%j96%`T1`SV#5!J)#"TER3JBR9c,#"NCACQEMX++`NJ)#!JD@BJ+(*PCb!
p25"198a-)(am)("c)$dp)%j96%`T#LX*#@0[ER4TER9P1`SV#5!J)#"LGA-J25!
SFQ9R@c"G)$iq)$%f+5!Q)$"iCQBl#LX*)#!J)'4PGQCZ)$dJ+(*PCeX`A5!q2L!
i+5!Q)$"iCQBl#LX*)#!J)'C[FL!SD5!p)$!l)'NJ2#"ZFcXJ+bYT+5"l#LX*#@P
Q)#Kd@fPG,Q*eFb!p25"LGA-J*LBJG&YTA5jNCACQEL!p25"NCACQELNJH`SV#3N
J)#!JG&YTA5j`EA9IFfpMDf9d)$dJ+R"c1`SV#3NJ)#!J4%9#98FS-L`J+#*cEf0
VCA3J*@3JDA-JF'ee)(0[BfYPG#!PC&aZ)L`JD5`J+R"c+5Nl#LX*#5!J)#"LFQ9
KDcX++`N*I3SV#5!J)#"p#LX*I3SV)#!J)(d++b0PEQ4TCJSJ#L"p)#mU)'&NC&p
`BfPM)#S[#L!+3%!J,6)b1$-X0L!V-M-b-#`a05"!3!SJ)#!J)(d+)#!J)#"T-cB
eAh0PG#KcEf0V,#"*-cBeAd063dP19#`JFQ9R+6X+)#!J)#"T-cBeAfGPG#KcEf0
V,#"*-cBeAd063bNl#LX++b0TCQ4PCL"IAh"[Gf9bF'0IA`SV)#!J)'PQ)#KcG'&
dC5dqCQaKCh-J*L"68ep&5N9$9%P26LNJH`SV#A0[BfYPG&pTEQC[Ah3J+R-J25!
QFfpMDf9d@h0[BfYG1`SV#@PQ)#Kc,6j`EA9IFfpMDf9d)#%p)$!J*LBJFbdqF'e
eAh*PF5jMEfe`E'9dC5N++`NJ)#!JF'eeAh*PFA9PFh3S*R-Y2R"YG9pbCA%X)%j
96%`X)$)X)&"099p33d9+4808,#"c,6j`EA9IFfpMDf9d+6X++`PcG'&dC5dqCQa
KCh-J*MdJIP06Ad9+480858p11`SV)#!J)(d++b0PEQ4TCJSJ)#!J)!SJ)#!J)(*
PG(9bEL!`1`SJI5![+L"T-cBeAh0PG&pcEf0VCA3J+Lm+3%!J,6)e06BX0L!V-MB
`-L`a05"!3!SJ)#!J)'PQ)#KcG'&dC5dqBh0MAfeKFfXJ*L"68ep%494&3e3T)(*
PCb"m25"*-cBeAd063ep%494&3e3l#L!J)#!JD6-f09pcCA3SFfpMDb`J56-f09p
$8d0*6P3X)(*PCbNl#L!J)#!JD6-f09pRCA3SFfpMDb`J56-f09p$8d-T1`SV#LX
MD@CNC@BJAep`EhGPFR"MAem++b!J)#"TCL!SFh4KG'8Y2QCXB@Gc)#BJ8e0I48T
&3e4*6diT)(X++`PcEf0VCA4ID@jQEepd)#Tc)$dJ*R0[BfYPG&YcEf0VA6X++`P
TCL!SFbdqF'eeAh0[BfYPG#!K25!`)#BQ)(-Y2R"YG9pbCA%ZBfpYF'aPG'8T#LX
*)#!J)("YG9pbCA&eCA0d+#Cc,6j`EA9IFQ9a,#"198a-,#!b,#"3699I8%0&5N9
$9#`JFbdqF'eeAh0[BfYPG#Nl#LX*Fh4KG'8Y2QCXB@Gc)#Bp)(j68ep&5N9$9%P
26MX++b!J)#"p#LXMC@jND@B+)#!J)#!+)#!J)#"bCA4eFQiJ-$X+)(dJ,bSJBf*
IFf9dAh0[BfYPG#!U,`S+H3!!:
--============_-1260836438==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"


   Tim Seufert
--============_-1260836438==_============--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
