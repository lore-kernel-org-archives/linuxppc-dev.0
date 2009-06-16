Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE002.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76])
	by bilbo.ozlabs.org (Postfix) with ESMTP id B8F78B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 04:28:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9EEAE.28939026"
Subject: 2.6.30 kernel panic with any network driver
Date: Tue, 16 Jun 2009 12:13:31 -0600
From: John Linn <John.Linn@xilinx.com>
To: <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20090616181334.1EBABA8056@mail2-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C9EEAE.28939026
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I just merged in 2.6.30 into our tree and I'm seeing this only when I
have a network driver built into the kernel, and it doesn't seem to
matter which network driver.

 =


Maybe I missed something I need to update in our network drivers to
match the kernel.

 =


Thanks for any help,

John

 =


console [ttyS0] enabled

brd: module loaded

loop: module loaded

Unable to handle kernel paging request for data at address 0x75686369

Faulting instruction address: 0xc01c3e34

Oops: Kernel access of bad area, sig: 11 [#1]

PREEMPT Xilinx Virtex440

Modules linked in:

NIP: c01c3e34 LR: c01c2ab4 CTR: 00000000

REGS: cf831dc0 TRAP: 0300   Not tainted  (2.6.30)

MSR: 00029000 <EE,ME,CE>  CR: 84284324  XER: 40000020

DEAR: 75686369, ESR: 00000000

TASK =3D cf82f8a0[1] 'swapper' THREAD: cf830000

GPR00: c01c2ab4 cf831e70 cf82f8a0 cf87b3a8 c034e5a4 00000000 c01c2a80
00000001

GPR08: cfbe69d8 c034dd98 00000f2b cf821778 84284342 fd9781f4 f6f6dff7
6adffffe

GPR16: d7f40173 bbd35ff7 3ef7fbff fff5d3f7 ffffffff 0059dac0 ffff006f
00000000

GPR24: 00000000 00000001 c034dd98 cf0416e0 cf87b3a0 cf87b3dc c034e5a4
75686369

NIP [c01c3e34] platform_match+0x20/0xa8

LR [c01c2ab4] __driver_attach+0x34/0xa8

Call Trace:

[cf831e70] [c027a394] klist_next+0x10c/0x120 (unreliable)

[cf831e90] [c01c2ab4] __driver_attach+0x34/0xa8

[cf831eb0] [c01c123c] bus_for_each_dev+0x5c/0x98

[cf831ee0] [c01c243c] driver_attach+0x24/0x34

[cf831ef0] [c01c2050] bus_add_driver+0x18c/0x264

[cf831f10] [c01c2fa8] driver_register+0x6c/0x170

[cf831f30] [c031f8cc] xemaclite_init+0x1c/0x4c

[cf831f50] [c00011ac] do_one_initcall+0x34/0x1a0

[cf831fd0] [c0307848] kernel_init+0xa0/0x104

[cf831ff0] [c000e188] kernel_thread+0x4c/0x68

Instruction dump:



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C9EEAE.28939026
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">=


<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I just merged in 2.6.30 into our tree and I&#8217;m seei=
ng
this only when I have a network driver built into the kernel, and it doesn&=
#8217;t
seem to matter which network driver.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Maybe I missed something I need to update in our network=

drivers to match the kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Thanks for any help,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>console [ttyS0] enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>brd: module loaded<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>loop: module loaded<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Unable to handle kernel paging request for data at addre=
ss
0x75686369<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Faulting instruction address: 0xc01c3e34<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Oops: Kernel access of bad area, sig: 11 [#1]<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>PREEMPT Xilinx Virtex440<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Modules linked in:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DDE style=3D'f=
ont-size:10.0pt;
font-family:Arial'>NIP: c01c3e34 LR: c01c2ab4 CTR: 00000000<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>REGS: cf831dc0 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp;
(2.6.30)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>MSR: 00029000 &lt;EE,ME,CE&gt;&nbsp; CR: 84284324&nbsp; =
XER:
40000020<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>DEAR: 75686369, ESR: 00000000<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>TASK =3D cf82f8a0[1] 'swapper' THREAD: cf830000<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>GPR00: c01c2ab4 cf831e70 cf82f8a0 cf87b3a8 c034e5a4 0000=
0000
c01c2a80 00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>GPR08: cfbe69d8 c034dd98 00000f2b cf821778 84284342 fd97=
81f4
f6f6dff7 6adffffe<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>GPR16: d7f40173 bbd35ff7 3ef7fbff fff5d3f7 ffffffff 0059=
dac0
ffff006f 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt;
font-family:Arial'>GPR24: 00000000 00000001 c034dd98 cf0416e0 cf87b3a0 cf87=
b3dc
c034e5a4 75686369<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>NIP [c01c3e34] platform_match+0x20/0xa8<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>LR [c01c2ab4] __driver_attach+0x34/0xa8<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831e70] [c027a394] klist_next+0x10c/0x120 (unreliable=
)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DDE style=3D'f=
ont-size:10.0pt;
font-family:Arial'>[cf831e90] [c01c2ab4] __driver_attach+0x34/0xa8<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831eb0] [c01c123c] bus_for_each_dev+0x5c/0x98<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831ee0] [c01c243c] driver_attach+0x24/0x34<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831ef0] [c01c2050] bus_add_driver+0x18c/0x264<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831f10] [c01c2fa8] driver_register+0x6c/0x170<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831f30] [c031f8cc] xemaclite_init+0x1c/0x4c<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831f50] [c00011ac] do_one_initcall+0x34/0x1a0<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831fd0] [c0307848] kernel_init+0xa0/0x104<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>[cf831ff0] [c000e188] kernel_thread+0x4c/0x68<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Instruction dump:<o:p></o:p></span></font></p>

</div>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</body>

</html>


------_=_NextPart_001_01C9EEAE.28939026--
