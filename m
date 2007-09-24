Return-Path: <dcogley@uslinc.com>
Received: from que02.charter.net (que02.charter.net [209.225.8.190])
	by ozlabs.org (Postfix) with ESMTP id B30BCDDE41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 07:41:00 +1000 (EST)
Received: from aarprv02.charter.net ([10.20.200.72]) by mtai02.charter.net
	(InterMail vM.7.08.03.00 201-2186-126-20070710) with ESMTP
	id <20070924191916.YUMJ28.mtai02.charter.net@aarprv02.charter.net>
	for <linuxppc-embedded@ozlabs.org>; Mon, 24 Sep 2007 15:19:16 -0400
Received: from DCOGLEYNEW ([71.93.35.174]) by aarprv02.charter.net with ESMTP
	id <20070924191914.YYCX495.aarprv02.charter.net@DCOGLEYNEW>
	for <linuxppc-embedded@ozlabs.org>; Mon, 24 Sep 2007 15:19:14 -0400
From: "Dave Cogley" <dcogley@uslinc.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: EBC peripheral, access causing Machine Check
Date: Mon, 24 Sep 2007 12:19:01 -0700
Message-ID: <005301c7fedf$c46f7770$9601a8c0@DCOGLEYNEW>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0054_01C7FEA5.18109F70"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0054_01C7FEA5.18109F70
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0055_01C7FEA5.181A3C60"


------=_NextPart_001_0055_01C7FEA5.181A3C60
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Good Afternoon,

 

I am using an AMCC 440EPx processor with an FPGA peripheral attached to the
EBC.  I am doing the entire bank configuration in the u-boot boot loader
before Linux is loaded.  I can directly read and write registers using
memory read and write (md, nm) within area 0xC0000000 to 0xC000FFFF direct
memory I/O within the context of u-boot without any faults.  When I attempt
to access any register in area 0xC000000 within the context of my Linux
device driver I get a Machine Check fault (attached text) which appears to
be an access permission violation.  I am currently running the DENX ELDK
2.6.19.2 platform that was specific to the "Sequoia" platform.

 

I have configured the EBC access permissions and control resisters as
follows for bank 1:

 

PB1CR: 0xC003C000

PB1AP: 0x80040380

 

Dave Cogley

Software Engineer

Ultra Stereo Labs, Inc.

(805) 549-0161

mailto:dcogley@uslinc.com

 


------=_NextPart_001_0055_01C7FEA5.181A3C60
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
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
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Good Afternoon,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am using an AMCC 440EPx processor with an FPGA =
peripheral attached
to the EBC.&nbsp; I am doing the entire bank configuration in the u-boot =
boot
loader before Linux is loaded.&nbsp; I can directly read and write =
registers using
memory read and write (md, nm) within area 0xC0000000 to 0xC000FFFF =
direct
memory I/O within the context of u-boot without any faults.&nbsp; When I
attempt to access any register in area 0xC000000 within the context of =
my Linux
device driver I get a Machine Check fault (attached text) which appears =
to be
an access permission violation.&nbsp; I am currently running the DENX =
ELDK 2.6.19.2
platform that was specific to the &#8220;Sequoia&#8221; =
platform.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have configured the EBC access permissions and =
control resisters
as follows for bank 1:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PB1CR: 0xC003C000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PB1AP: 0x80040380<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dave Cogley<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Software Engineer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ultra Stereo Labs, Inc.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>(805) 549-0161<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a =
href=3D"mailto:dcogley@uslinc.com">mailto:dcogley@uslinc.com</a></span></=
font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_001_0055_01C7FEA5.181A3C60--

------=_NextPart_000_0054_01C7FEA5.18109F70
Content-Type: text/plain;
	name="mcdump.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mcdump.txt"

bash-3.00#=20

Machine check in kernel mode.
Data Read PLB Error
OPB to PLB3: BSTAT=3D 0x00000000
PLB3 to PLB4: BEAR=3D0xffffffffffffffff BESR0=3D0x00000000 =
BESR1=3D0x00000000
PLB4 to PLB3: BEAR=3D0xfffffffffffffffd BESR0=3D0x00000000 =
BESR1=3D0x00000000
PLB3 to OPB: BEAR=3D0xffffffff BESR0=3D0x00000000 BESR1=3D0x00000000
PLB3 arbiter: BEAR=3D0xfffffffe ACR=3D0x00000000 BESR=3D0x00000000
PLB4 to OPB1: BEAR=3D0x0000000dbfffffbf BESR0=3D0x00000000 =
BESR1=3D0x00000000
PLB40 Arbiter: BEAR=3D0x00000000c0000000 ACR=3D0xda000000 =
BESR0=3D0x0f000000
PLB41 Arbiter: BEAR=3D0xfffffffffffffffc ACR=3D0xdb000000 =
BESR0=3D0x00000000
POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000
OPB0: BEAR=3D0x0000000000000000 BSTAT=3D0x00000000
Oops: machine check, sig: 7 [#2]
NIP: D107E2D4 LR: C0069F24 CTR: 0FF40B20
REGS: c02a9f50 TRAP: 0202   Not tainted  (2.6.19.2)
MSR: 00029000 <EE,ME>  CR: 40000022  XER: 00000000
TASK =3D cf6c1030[268] 'banjocore' THREAD: cf1b8000
GPR00: 40044B01 CF1B9EB0 CF6C1030 00000000 CF0EF5C0 40044B01 7F95B928 =
0FF39D08=20
GPR08: 00000000 00000000 FFFFFFE7 D1080000 80000028 10018B10 00000000 =
100D8ED8=20
GPR16: 100C0000 00000000 100C0000 10090000 00000000 100DF660 100C7C48 =
00000000=20
GPR24: 100D9038 00000000 100D8F58 40044B01 FFFFFFF7 CF0EF5C0 0FFBB73C =
7F95B928=20
NIP [D107E2D4] banjo_ioctl+0xc0/0x14c [banjodecoder]
LR [C0069F24] do_ioctl+0x80/0x84
Call Trace:
[CF1B9EB0] [00000001] 0x1 (unreliable)
[CF1B9ED0] [C0069F24] do_ioctl+0x80/0x84
[CF1B9EE0] [C0069FB4] vfs_ioctl+0x8c/0x418
[CF1B9F10] [C006A380] sys_ioctl+0x40/0x74
[CF1B9F40] [C0001C84] ret_from_syscall+0x0/0x3c
Instruction dump:
60004b00 7f850000 419e0044 3c004004 60004b01 7f850000 38600000 409eff74=20
3d60d108 812bf2a4 7c0004ac 7d204c2c <0c090000> 4c00012c 38600000 =
91260000=20
Bus error
bash-3.00# 
------=_NextPart_000_0054_01C7FEA5.18109F70--
