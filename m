Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth01.prod.mesa1.secureserver.net
	(smtpauth01.prod.mesa1.secureserver.net [64.202.165.181])
	by ozlabs.org (Postfix) with SMTP id BC974DDF59
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 02:04:18 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8360 : PCI resource allocate error
Date: Fri, 2 Feb 2007 07:04:09 -0800
Message-ID: <000c01c746db$6451e7e0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000D_01C74698.562EA7E0"
Reply-To: rmcguire@videopresence.com
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

------=_NextPart_000_000D_01C74698.562EA7E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

While trying out various of my PCI slots, I ran into this interesting error.

 

If I try to put a sounc card, Audigy SE, into SLOT 1 and 2 this error
doesn't occur.

But when I place it in the 3rd. I get this:  <Note the 02:0b is SLOT 3>

 

<Linux 2.6.20-rc6 compiled for PowerPC / MPC83xx>

 

--------------------------------------

PCI: Probing PCI hardware

Try to map irq for 0000:00:19.0...

pci_busdev_to_OF_node(0,0xc8)

 parent is /soc8360@f0000000/pci@8500

 result is <NULL>

Try to map irq for 0000:00:19.1...

pci_busdev_to_OF_node(0,0xc9)

 parent is /soc8360@f0000000/pci@8500

 result is <NULL>

Try to map irq for 0000:02:0b.0...

pci_busdev_to_OF_node(2,0x58)

pci_busdev_to_OF_node(0,0xc9)

 parent is /soc8360@f0000000/pci@8500

 result is <NULL>

 -> got one, spec 2 cells (0x00000017...) on /soc8360@f0000000/pic@700

PCI: bridge rsrc 0..ffffffff (100), parent c038d184

PCI: bridge rsrc 80000000..8fffffff (1200), parent c038d168

PCI: bridge rsrc 90000000..9fffffff (200), parent c038d168

PCI: bridge rsrc f0302000..f0302fff (101), parent c03da03c

PCI:0000:02:0b.0: Resource 0: 0000000000302000-000000000030201f (f=101)

PCI: Cannot allocate resource region 0 of device 0000:02:0b.0

PCI: Error while updating region 0000:02:0b.0/0 (f0302001 != 00302001)

------------------------------

 

What can cause this to not work?

 

-Russ


------=_NextPart_000_000D_01C74698.562EA7E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
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
font-family:Arial'>While trying out various of my PCI slots, I ran into =
this
interesting error.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If I try to put a sounc card, Audigy SE, into SLOT 1 =
and 2 this
error doesn&#8217;t occur.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>But when I place it in the 3<sup>rd</sup>. I get =
this:&nbsp;
&lt;Note the 02:0b is SLOT 3&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&lt;Linux 2.6.20-rc6 compiled for PowerPC / =
MPC83xx&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>--------------------------------------<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Probing PCI =
hardware<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Try to map irq for
0000:00:19.0...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(0,0xc8)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;parent is
/soc8360@f0000000/pci@8500<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;result is =
&lt;NULL&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Try to map irq for
0000:00:19.1...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(0,0xc9)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;parent is
/soc8360@f0000000/pci@8500<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;result is =
&lt;NULL&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Try to map irq for
0000:02:0b.0...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(2,0x58)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(0,0xc9)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;parent is
/soc8360@f0000000/pci@8500<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;result is =
&lt;NULL&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;-&gt; got =
one, spec 2 cells
(0x00000017...) on =
/soc8360@f0000000/pic@700<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc =
0..ffffffff
(100), parent c038d184<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc
80000000..8fffffff (1200), parent c038d168<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc
90000000..9fffffff (200), parent c038d168<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc
f0302000..f0302fff (101), parent c03da03c<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI:0000:02:0b.0: =
Resource
0: 0000000000302000-000000000030201f =
(f=3D101)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Cannot =
allocate
resource region 0 of device 0000:02:0b.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>PCI: Error while updating region =
0000:02:0b.0/0
(f0302001 !=3D 00302001)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>------------------------------<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What can cause this to not =
work?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Russ<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000D_01C74698.562EA7E0--
