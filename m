Return-Path: <zhangsb@rcs-9000.com>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id 6A55567B52
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 17:46:00 +1000 (EST)
From: "zhangshaobo" <zhangsb@rcs-9000.com>
To: <linuxppc-dev@ozlabs.org>
Subject: pls help me!
Date: Mon, 10 Jul 2006 15:32:38 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002F_01C6A436.132F3D10"
Message-Id: <200607101538593.SM01784@stridenote>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_002F_01C6A436.132F3D10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, all

         I meet a very difficult problem about ppc linux run on MPC5200. my
linux version is 2.4.18.

         When i run my application for some time, the linux operation system
will reset to jump to the uboot and restart linux,. When it happen, I can
capture  hreset and sreset signal using oscillograph. Additional, when linux
reset , it have two results: one is enter machine check exception and some
debug information is outputted, the other is nothing is to be outputted. The
debug information is following:

 

Machine check in kernel mode.

Caused by (from SRR1=41030): Transfer error ack signal

Oops: machine check, sig: 7

NIP: C009E934 XER: 00000000 LR: C009E924 SP: C014F1E0 REGS: c014f130 TRAP:
0200    Not tainted

MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11

TASK = c014d480[0] 'swapper' Last syscall: 120 

last math c3c30000 last altivec 00000000

GPR00: 00000001 C014F1E0 C014D480 00000083 00009032 00000000 00000000
00000010 

GPR08: 00000000 40000000 00000000 00000000 C3E5E9E4 1010D5DC 03FCA000
007FFF6C 

GPR16: 00000000 00000001 007FFF00 03FC4660 00001032 0014F350 00000000
C0176314 

GPR24: C0176314 00000000 00000000 0000076C C0160000 F0000D8C 00000070
C3E5E960 

Call backtrace: 

C3E5EA68 C009F030 C001D9A4 C0019430 C00192BC C0018F80 C00057C0 

C0003E40 C0005544 C0005558 C0003918 C0164590 000035F0 

MPC5xxx_FEC_IEVENT_RFIFO_ERROR

Kernel panic: Aiee, killing interrupt handler!

In interrupt handler - not syncing

 

Can you help me ? I will waiting for your answer , thanks anyway.

 


------=_NextPart_000_002F_01C6A436.132F3D10
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chsdate" downloadurl=3D""/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv" downloadurl=3D""/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:&#23435;&#20307;;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@&#23435;&#20307;";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Hi, =
all<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
I meet a very difficult problem about ppc linux run on MPC5200. my linux
version is <st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" =
Day=3D"30"
Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.4.18</st1:chsdate>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
When i run my application for some time, the linux operation system will =
reset
to jump to the uboot and restart linux,. When it happen, I can =
capture&nbsp;
hreset and sreset signal using oscillograph. Additional, when linux =
reset , it
have two results: one is enter machine check exception and some debug
information is outputted, the other is nothing is to be outputted. The =
debug
information is following:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Machine check =
in kernel
mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Caused by (from
SRR1=3D41030): Transfer error ack signal<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Oops: machine =
check, sig:
7<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>NIP: C009E934 =
XER: 00000000
LR: C009E924 SP: C<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"14" UnitName=3D"F" =
w:st=3D"on">014F</st1:chmetcnv>1E0
REGS: c<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"14" UnitName=3D"F" w:st=3D"on">014f</st1:chmetcnv>130 =
TRAP:
0200&nbsp;&nbsp;&nbsp; Not tainted<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>MSR: 00041030 =
EE: 0 PR: 0
FP: 0 ME: 1 IR/DR: 11<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>TASK =3D =
c014d480[0]
'swapper' Last syscall: 120 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>last math =
c<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"3"
UnitName=3D"C" w:st=3D"on">3c</st1:chmetcnv>30000 last altivec =
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>GPR00: =
<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"1"
UnitName=3D"C" w:st=3D"on">00000001 C</st1:chmetcnv><st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"14" UnitName=3D"F"
w:st=3D"on">014F</st1:chmetcnv>1E<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" UnitName=3D"C" =
w:st=3D"on">0 C</st1:chmetcnv>014D480
00000083 00009032 00000000 00000000 00000010 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>GPR08: 00000000 =
40000000
00000000 <st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"True"
SourceValue=3D"0" UnitName=3D"C" w:st=3D"on">00000000 =
C</st1:chmetcnv>3E5E9E4
1010D5DC 03FCA000 007FFF<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"6" UnitName=3D"C" =
w:st=3D"on">6C</st1:chmetcnv> <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>GPR16: 00000000 =
00000001
007FFF00 03FC4660 00001032 <st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"14" UnitName=3D"F" =
w:st=3D"on">0014F</st1:chmetcnv>350
<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"True"
SourceValue=3D"0" UnitName=3D"C" w:st=3D"on">00000000 =
C</st1:chmetcnv>0176314 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>GPR24: C0176314 =
00000000
00000000 <st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"76" UnitName=3D"C" w:st=3D"on">0000076C</st1:chmetcnv> =
C<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"160000"
UnitName=3D"F" w:st=3D"on">0160000 F</st1:chmetcnv>0000D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"8" =
UnitName=3D"C"
w:st=3D"on">8C</st1:chmetcnv> <st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"70" UnitName=3D"C" =
w:st=3D"on">00000070
 C</st1:chmetcnv>3E5E960 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Call backtrace: =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>C3E5EA<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"68"
UnitName=3D"C" w:st=3D"on">68 C</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"9" UnitName=3D"F" =
w:st=3D"on">009F</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"30"
UnitName=3D"C" w:st=3D"on">030 C</st1:chmetcnv>001D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"9" =
UnitName=3D"a"
w:st=3D"on">9A</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"4" UnitName=3D"C" =
w:st=3D"on">4 C</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"19430"
UnitName=3D"C" w:st=3D"on">0019430 C</st1:chmetcnv>00192BC =
C<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"18" UnitName=3D"F"
w:st=3D"on">0018F</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"80" UnitName=3D"C" =
w:st=3D"on">80 C</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"57"
UnitName=3D"C" w:st=3D"on">00057C</st1:chmetcnv>0 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>C0003E<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"40"
UnitName=3D"C" w:st=3D"on">40 C</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"5544" UnitName=3D"C" =
w:st=3D"on">0005544
 C</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"True" SourceValue=3D"5558" UnitName=3D"C" =
w:st=3D"on">0005558 C</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"3918"
UnitName=3D"C" w:st=3D"on">0003918 C</st1:chmetcnv>0164590 <st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"35" UnitName=3D"F"
w:st=3D"on">000035F</st1:chmetcnv>0 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>MPC5xxx_FEC_IEVENT_RFIFO_ERRO=
R<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Kernel panic: =
Aiee,
killing interrupt handler!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>In interrupt =
handler - not
syncing<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Can you help me =
? I will
waiting for your answer , thanks anyway.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_002F_01C6A436.132F3D10--
