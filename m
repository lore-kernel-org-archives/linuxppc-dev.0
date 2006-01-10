Return-Path: <jonathan@haliplex.com.au>
Received: from hellskitchen.haliplex.com.au
	(dsl-202-45-109-210.VIC.netspace.net.au [202.45.109.210])
	by ozlabs.org (Postfix) with ESMTP id 1DE18689AC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 14:15:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C61592.D3BD1288"
Date: Tue, 10 Jan 2006 14:06:18 +1100
Message-ID: <32A7B31E4005134E8BA805EBAAFB9DCD9C7A1C@hellskitchen.haliplex.com.au>
From: "Jonathan Qiang" <jonathan@haliplex.com.au>
To: <linuxppc-embedded@ozlabs.org>
Subject: [Problem] linux 2.6.14 kernel hang up after the uImage uncompressed
	successfully
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

------_=_NextPart_001_01C61592.D3BD1288
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am doing booting linux kernel 2.6.14.5 from kernel.org on a kind of
embedded ppc board, where the chip mpc8272 has been settled.
But  after u-boot(1.1.4) finished booting itself and uncompressed the
uImage(2.6.14.5 based). the kernel can not boot
Successfully. It stop somewhere. the script is below:=20
=20
=20
U-Boot 1.1.4 (Jan  3 2006 - 15:00:41)
=20
MPC8272 Reset Status: Check Stop, External Soft, External Hard
=20
MPC8272 Clock Configuration
 - Bus-to-Core Mult 5x, VCO Div 2, 60x Bus Freq  20-60 , Core Freq
100-300
 - dfbrg 1, corecnf 0x1b, busdf 7, cpmdf 1, plldf 0, pllmf 7
 - vco_out  528000000, scc_clk  132000000, brg_clk   33000000
 - cpu_clk  330000000, cpm_clk  264000000, bus_clk   66000000
 - pci_clk   22000000
=20
CPU:   MPC8272 (HiP7 Rev 14, Mask 1.0 1K50M) at 330 MHz
I2C:   ready
DRAM:  SDRAM configuration:
        Refresh rate =3D 47, CAS latency =3D 3, Using Page Based =
Interleave
        Total size: 32 MB
FLASH Dectected: FLASH MFP, new id is 0x0089, Device ID is 0x8922
32 MB
In:    serial
Out:   serial
Err:   serial
Ethos version: ac21 (DEVID:ac2, DEVVER:1, MFGVER: 1)
CFG_CMXFCR_VALUE=3D0x00370000, CFG_CMXFCR_MASK=3D0x007F0000
Net:   FCC2 ETHERNET
Hit any key to stop autoboot:  0
Using FCC2 ETHERNET device
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.14.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    750080 Bytes =3D 732.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK=20
=20
Then I have tried to use BDI2000 to debug the kernel, It seems that the
kernel can passed on console_init function. But still no message came
out even printk(KERN_NOTICE);  and printk(linux_banner);=20
=20

------_=_NextPart_001_01C61592.D3BD1288
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C615EF.067C8A30">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"date"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:\5B8B\4F53;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:SimSun;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	mso-header-margin:35.4pt;
	mso-footer-margin:35.4pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:36.0pt'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am doing booting <span class=3DSpellE>linux</span> =
kernel 2.6.14.5
from kernel.org on a kind of </span></font><b><font color=3Dblack><span
style=3D'color:black;font-weight:bold'>embedded <span =
class=3DSpellE>ppc</span>
board, where the chip mpc8272 has been =
settled.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black;font-weight:bold'>But <span
style=3D'mso-spacerun:yes'>&nbsp;</span>after u-boot(1.1.4) finished =
booting itself
and uncompressed the <span class=3DSpellE>uImage</span>(2.6.14.5 based). =
the
kernel can not boot<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black;font-weight:bold'>Successfully. It =
stop
somewhere. the script is below: <o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black;font-weight:bold'><o:p>&nbsp;</o:p>=
</span></font></b></p>

<p class=3DMsoNormal><b><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black;font-weight:bold'><o:p>&nbsp;</o:p>=
</span></font></b></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>U-Boot 1.1.4 (</span></font><st1:date Month=3D"1" =
Day=3D"3"
Year=3D"2006"><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:
 Arial'>Jan<span style=3D'mso-spacerun:yes'>&nbsp; </span>3 =
2006</span></font></st1:date><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> - </span></font><st1:time
Hour=3D"15" Minute=3D"0"><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
 font-family:Arial'>15:00:41</span></font></st1:time><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>)<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>MPC8272 Reset Status: Check Stop, External Soft, =
External
Hard<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>MPC8272 Clock =
Configuration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;</span>- =
Bus-to-Core <span
class=3DSpellE>Mult</span> 5x, VCO Div 2, 60x Bus Freq<span
style=3D'mso-spacerun:yes'>&nbsp; </span>20-60 , Core Freq =
100-300<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;</span>- <span
class=3DSpellE>dfbrg</span> 1, <span class=3DSpellE>corecnf</span> 0x1b, =
<span
class=3DSpellE>busdf</span> 7, <span class=3DSpellE>cpmdf</span> 1, =
<span
class=3DSpellE>plldf</span> 0, <span class=3DSpellE>pllmf</span> =
7<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;</span>- <span
class=3DSpellE>vco_out</span><span style=3D'mso-spacerun:yes'>&nbsp;
</span>528000000, <span class=3DSpellE>scc_clk</span><span
style=3D'mso-spacerun:yes'>&nbsp; </span>132000000, <span =
class=3DSpellE>brg_clk</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>33000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;</span>- <span
class=3DSpellE>cpu_clk</span><span style=3D'mso-spacerun:yes'>&nbsp;
</span>330000000, <span class=3DSpellE>cpm_clk</span><span
style=3D'mso-spacerun:yes'>&nbsp; </span>264000000, <span =
class=3DSpellE>bus_clk</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>66000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;</span>- <span
class=3DSpellE>pci_clk</span><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;
</span>22000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU:<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp;
</span>MPC8272 (HiP7 Rev 14, Mask 1.0 1K50M) at 330 =
MHz<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I2C:<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>ready<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>DRAM:<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>SDRAM
configuration:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Refresh rate =3D 47, CAS latency =3D 3, Using Page Based =
Interleave<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Total size: 32 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>FLASH <span class=3DSpellE>Dectected</span>: FLASH =
MFP, new id
is 0x0089, Device ID is 0x8922<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>32 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In:<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span>serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Out:<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp;
</span>serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Err:<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp;
</span>serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ethos version: ac21 (DEVID:ac2, DEVVER:1, MFGVER: =
1)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CFG_CMXFCR_VALUE=3D0x00370000, =
CFG_CMXFCR_MASK=3D0x007F0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Net:<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>FCC2
ETHERNET<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hit any key to stop <span =
class=3DSpellE>autoboot</span>:<span
style=3D'mso-spacerun:yes'>&nbsp; </span>0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Using FCC2 ETHERNET =
device<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>## Booting image at 00200000 =
...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>Image
Name:<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>Linux-2.6.14.5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>Image
Type:<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>PowerPC Linux =
Kernel
Image (<span class=3DSpellE>gzip</span> =
compressed)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>Data
Size:<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>750080 =
Bytes =3D
732.5 <span class=3DSpellE>kB</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>Load
Address: 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>Entry
Point:<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>Verifying
Checksum ... OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp;
</span>Uncompressing Kernel Image ... OK <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Then I have tried to use BDI2000 to debug the kernel, =
It
seems that the kernel can passed on <span =
class=3DSpellE>console_init</span>
function. But still no message came out even <span =
class=3DSpellE>printk</span>(KERN_NOTICE);<span
style=3D'mso-tab-count:1'>&nbsp; </span>and <span =
class=3DSpellE>printk</span>(<span
class=3DSpellE>linux_banner</span>); <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C61592.D3BD1288--
