Return-Path: <Alan.Rossetti@tellabs.com>
Received: from mx4.tellabs.com (mx4.tellabs.com [204.154.129.57])
	by ozlabs.org (Postfix) with ESMTP id BFEE1B7CEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Oct 2009 02:53:23 +1100 (EST)
From: "Rossetti, Alan" <Alan.Rossetti@tellabs.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 6 Oct 2009 10:43:16 -0500
Subject: can't access memory above 496M
Message-ID: <9B6575E5BE35C34796F7F58A2829F06366ECE42CD2@EX-NAP.tellabs-west.tellabsinc.net>
Content-Type: multipart/alternative;
	boundary="_000_9B6575E5BE35C34796F7F58A2829F06366ECE42CD2EXNAPtellabsw_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_9B6575E5BE35C34796F7F58A2829F06366ECE42CD2EXNAPtellabsw_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We have an embedded prouct using 8270 based on pq2fads with MontaVista 4.0.=
1, kernel 2.6.10. We recently had a need to increase memory. We can populat=
e 1x256M, 2x256M, 1x512M or 2X512M. In all configurations with at least 512=
M, it we set memory size to 496M or greater system crashes on boot up while=
 populating rootfs. With memory size set to <496M system boots and runs fin=
e=2E U-boot can see and access/test all memory.

Manual says alignment exception can also be due to crossing segment or BAT =
boundary. BATs look OK, configured as 256M blocks.

Any thoughts would be appreciated.


desched thread 0 started up.
Machine check in kernel mode.
Caused by (from SRR1=3D49030): Transfer error ack signal
Oops: machine check, sig: 7 [#1]

NIP: C0008680 LR: C0004FAC SP: C0971C80 REGS: c0971bd0 TRAP: 0200    Not ta=
inted
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11

TASK =3D c0944ab0[1] 'swapper' THREAD: c0970000
Last syscall: 120
GPR00: 00000000 C0971C80 C0944AB0 EEC00000 EEC00000 00017C0B EEBFFFFC 00000=
004
GPR08: 0000007C 00000000 0000005F 00000000 00944C80 FFFE7DFF C093882C FFFFF=
FFF
GPR16: C01D3D84 C094C9E0 0009E000 004197FF 00001000 00000000 0009E000 C0971=
DCC
GPR24: 00000000 FF777000 0000000B 00000000 00000000 C0220000 C0971CD0 00000=
000
NIP [c0008680] fix_alignment+0x1e4/0x4bc
LR [c0004fac] AlignmentException+0x18/0xb4
Call backtrace:
 c0004fac AlignmentException+0x18/0xb4
 c0004648 ret_from_except_full+0x0/0x4c
 c000d340 __copy_tofrom_user+0xa8/0x234
 c0034f60 __generic_file_aio_write_nolock+0x280/0x4a4
 c0035200 __generic_file_write_nolock+0x7c/0xc4
 c003541c generic_file_write+0x58/0x17c
 c004e48c vfs_write+0x9c/0x11c
 c004e5e8 sys_write+0x4c/0x90
 c0202610 populate_rootfs+0x12c/0x1a4
 c0003a7c init+0x34/0x2b4
 c0006684 kernel_thread+0x44/0x60

Kernel panic - not syncing: Attempted to kill init!



Al Rossetti
Staff Engineer
Tellabs Operations, Inc.
E-Mail: arossett@tellabs.com<mailto:arossett@tellabs.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The information contained in this message may be privileged
and confidential and protected from disclosure. If the reader
of this message is not the intended recipient, or an employee
or agent responsible for delivering this message to the
intended recipient, you are hereby notified that any reproduction,
dissemination or distribution of this communication is strictly
prohibited. If you have received this communication in error,
please notify us immediately by replying to the message and
deleting it from your computer. Thank you. Tellabs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--_000_9B6575E5BE35C34796F7F58A2829F06366ECE42CD2EXNAPtellabsw_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
p=2EMsoToc4, li.MsoToc4, div.MsoToc4
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:9.0pt;
	font-family:"Times New Roman";
	letter-spacing:-.25pt;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle18
	{font-family:Arial;
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>We have an embedded prouct using 8270 based on pq2fads w=
ith
MontaVista 4.0.1, kernel 2.6.10. We recently had a need to increase memory.=
 We
can populate 1x256M, 2x256M, 1x512M or 2X512M. In all configurations with at
least 512M, it we set memory size to 496M or greater system crashes on boot=
 up while
populating rootfs. With memory size set to &lt;496M system boots and runs f=
ine.
U-boot can see and access/test all memory. </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>Manual says alignment exception can also be due to cross=
ing
segment or BAT boundary. BATs look OK, configured as 256M blocks. </span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>Any thoughts would be appreciated. </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>desched thread 0 start=
ed up.</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Machine check in kernel
mode.</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Caused by (from SRR1=
=3D49030):
Transfer error ack signal</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Oops: machine check, s=
ig: 7
[#1]</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;</span></font></=
p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>NIP: C0008680 LR: C000=
4FAC
SP: C0971C80 REGS: c0971bd0 TRAP: 0200&nbsp;&nbsp;&nbsp; Not tainted</span>=
</font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>MSR: 00049030 EE: 1 PR=
: 0
FP: 0 ME: 1 IR/DR: 11</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;</span></font></=
p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>TASK =3D c0944ab0[1] '=
swapper'
THREAD: c0970000</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Last syscall: 120 </sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>GPR00: 00000000 C0971C=
80
C0944AB0 EEC00000 EEC00000 00017C0B EEBFFFFC 00000004 </span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>GPR08: 0000007C 000000=
00
0000005F 00000000 00944C80 FFFE7DFF C093882C FFFFFFFF </span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>GPR16: C01D3D84 C094C9=
E0
0009E000 004197FF 00001000 00000000 0009E000 C0971DCC </span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>GPR24: 00000000 FF7770=
00
0000000B 00000000 00000000 C0220000 C0971CD0 00000000 </span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>NIP [c0008680]
fix_alignment+0x1e4/0x4bc</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>LR [c0004fac]
AlignmentException+0x18/0xb4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Call backtrace:</span>=
</font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c0004fac
AlignmentException+0x18/0xb4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c0004648
ret_from_except_full+0x0/0x4c</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c000d340
__copy_tofrom_user+0xa8/0x234</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c0034f60
__generic_file_aio_write_nolock+0x280/0x4a4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c0035200
__generic_file_write_nolock+0x7c/0xc4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c003541c
generic_file_write+0x58/0x17c</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c004e48c
vfs_write+0x9c/0x11c</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c004e5e8
sys_write+0x4c/0x90</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c0202610
populate_rootfs+0x12c/0x1a4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c0003a7c
init+0x34/0x2b4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;c0006684
kernel_thread+0x44/0x60</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;</span></font></=
p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Kernel panic - not syn=
cing:
Attempted to kill init!</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;</span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>Al Rossetti</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>Staff Engineer</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 color=3Db=
lack
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial;color:black'=
>Tellabs
Operations, Inc.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>E-Mail: <a href=3D"mailto:arossett@tellabs.com">arossett=
@tellabs.com</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;</span></font></p>

</div>

<pre>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The information contained in this message may be privileged
and confidential and protected from disclosure. If the reader
of this message is not the intended recipient, or an employee
or agent responsible for delivering this message to the
intended recipient, you are hereby notified that any reproduction,
dissemination or distribution of this communication is strictly
prohibited. If you have received this communication in error,
please notify us immediately by replying to the message and
deleting it from your computer. Thank you. Tellabs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
</pre></body>

</html>

--_000_9B6575E5BE35C34796F7F58A2829F06366ECE42CD2EXNAPtellabsw_--
