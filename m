Return-Path: <mqy@263.net.cn>
Received: from smtp.263.net (263.net.cn [211.150.96.21])
	by ozlabs.org (Postfix) with ESMTP id 8DAFF68704
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Nov 2005 03:48:02 +1100 (EST)
From: "KylongMu" <mqy@263.net.cn>
To: <wd@denx.de>
Date: Sun, 13 Nov 2005 00:47:49 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C5E7EB.E0413DB0"
In-Reply-To: <20051111083908.42494353C42@atlas.denx.de>
Message-Id: <20051112164751.CA6C6DBB@smtp.263.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 11-11-05 2.6.14 on AMCC Yosemite board(boot error) 
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

------=_NextPart_000_0000_01C5E7EB.E0413DB0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0001_01C5E7EB.E0413DB0"


------=_NextPart_001_0001_01C5E7EB.E0413DB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Denk:

 

>What you show is NOT the current code.

     By update with the most recent code, I did new test, and get

Different error message, that I can't solve it, pls check the attachment. 

 

> U-Boot 1.1.3 (Sep  7 2005 - 09:03:02)

 

>Please update U-Boot as well. You need this commit included:

 

>commit f190c11b1f22ff766e046588e5a7bb55f28ae305

>tree 1c41a7beffe8a293174dcb7c28b394349204a047

>parent 4d03a21f2329bb13a9661a23742ac0b77a7a76d5

>author Stefan Roese <sr@denx.de> Sat, 05 Nov 2005 15:50:16 +0100

>committer Stefan Roese <sr@denx.de> Sat, 05 Nov 2005 15:50:16 +0100

 

>    Adjust bd->bi_flashstart on Yellowstone & Yosemite to correct size

>    Patch by Stefan Roese, 05 Nov 2005

 

>I recommend to use the top-of-tree from the CVS or GIT repositories.

 

> Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #1 Fri Nov 11

> 09:51:04 CST 2005

 

>This is not the current code base. You should  use  top-of-tree  from

>GIT repository (commit ff1df84b3c3154ffdb646941e1c70d17554e3042); the

>kernel will display something like this:

 

>Linux version 2.6.14-gff1df84b ...

     I update my source code by "cg-update" directly, after many message and
file download it shows "full merged",

I think it is work. But the version only is 2.6.14. 

 

Thanks a lot!

 

Kylong Mu


------=_NextPart_001_0001_01C5E7EB.E0413DB0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:9.0pt;
	font-family:SimSun;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 126.65pt 72.0pt 126.65pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Dear Denk:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;What you show is NOT the current =
code.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span
lang=3DEN-US>By update with the most recent code, I did new test, and =
get<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>Different error =
message, that I
can</span></font><font color=3Dblack face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-family:"Courier =
New";color:black'>&#8217;</span></font><font
color=3Dblack><span lang=3DEN-US style=3D'color:black'>t solve it, pls =
check the attachment.
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt; U-Boot <st1:chsdate IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">1.1.3</st1:chsdate>
(Sep&nbsp; 7 2005 - 09:03:02)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;Please update U-Boot as well. You need =
this commit
included:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;commit f<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"190" UnitName=3D"C" =
w:st=3D"on">190c</st1:chmetcnv>11b<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"1"
UnitName=3D"F" w:st=3D"on">1f</st1:chmetcnv>22ff766e046588e<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"5" =
UnitName=3D"a"
w:st=3D"on">5a</st1:chmetcnv>7bb<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"55" UnitName=3D"F" =
w:st=3D"on">55f</st1:chmetcnv>28ae305<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;tree <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"1" UnitName=3D"C" =
w:st=3D"on">1c</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"41"
UnitName=3D"a" w:st=3D"on">41a</st1:chmetcnv>7beffe<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"8" =
UnitName=3D"a"
w:st=3D"on">8a</st1:chmetcnv>293174dcb<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"7" UnitName=3D"C" =
w:st=3D"on">7c</st1:chmetcnv>28b<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False"
SourceValue=3D"394349204" UnitName=3D"a" =
w:st=3D"on">394349204a</st1:chmetcnv>047<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;parent 4d<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"3" UnitName=3D"a" =
w:st=3D"on">03a</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"21"
UnitName=3D"F" w:st=3D"on">21f</st1:chmetcnv>2329bb<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"13" UnitName=3D"a"
w:st=3D"on">13a</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"9661" =
UnitName=3D"a" w:st=3D"on">9661a</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"23742"
UnitName=3D"ac" w:st=3D"on">23742ac</st1:chmetcnv>0b<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"77" UnitName=3D"a"
w:st=3D"on">77a</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"7" UnitName=3D"a" =
w:st=3D"on">7a</st1:chmetcnv>76d5<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;author Stefan Roese &lt;sr@denx.de&gt; =
Sat, 05 Nov
2005 15:50:16 +0100<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;committer Stefan Roese &lt;sr@denx.de&gt; =
Sat, 05
Nov 2005 15:50:16 +0100<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;&nbsp;&nbsp;&nbsp; Adjust =
bd-&gt;bi_flashstart on
Yellowstone &amp; Yosemite to correct size<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;&nbsp;&nbsp;&nbsp; Patch by Stefan Roese, =
05 Nov
2005<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;I recommend to use the top-of-tree from =
the CVS or
GIT repositories.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt; Linux version <st1:chsdate =
IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.14</st1:chsdate>
(root@dxp) (gcc version 4.0.0) #1 Fri Nov =
11<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt; 09:51:04 CST =
2005<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;This is not the current code base. You =
should&nbsp;
use&nbsp; top-of-tree&nbsp; from<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;GIT repository (commit =
ff1df84b<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"3"
UnitName=3D"C" w:st=3D"on">3c</st1:chmetcnv>3154ffdb646941e<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"1" =
UnitName=3D"C"
w:st=3D"on">1c</st1:chmetcnv>70d17554e3042); =
the<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;kernel will display something like =
this:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;Linux version <st1:chsdate =
IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.14</st1:chsdate>-gff1df84b
...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; I update my source =
code by </span></font><font
face=3D"Courier New"><span lang=3DEN-US style=3D'font-family:"Courier =
New"'>&#8220;</span></font><span
lang=3DEN-US>cg-update</span><font face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-family:"Courier New"'>&#8221;</span></font><span =
lang=3DEN-US>
directly, after many message and file download it shows </span><font
face=3D"Courier New"><span lang=3DEN-US style=3D'font-family:"Courier =
New"'>&#8220;</span></font><span
lang=3DEN-US>full merged</span><font face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-family:"Courier New"'>&#8221;</span></font><span =
lang=3DEN-US>,<o:p></o:p></span></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>I think it is work. =
But the
version only is <st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" =
Day=3D"30"
Month=3D"12" Year=3D"1899" w:st=3D"on">2.6.14</st1:chsdate>. =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Thanks a lot!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>Kylong =
Mu<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_001_0001_01C5E7EB.E0413DB0--

------=_NextPart_000_0000_01C5E7EB.E0413DB0
Content-Type: text/plain;
	name="bootmessage.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bootmessage.txt"

[root@dxp filesystem]# kermit -c=0A=
Connecting to /dev/ttyS0, speed 9600=0A=
 Escape character: Ctrl-\ (ASCII 28, FS): enabled=0A=
Type the escape character followed by C to get back,=0A=
or followed by ? to see other options.=0A=
----------------------------------------------------=0A=
=0A=
=0A=
U-Boot 1.1.4 (Nov 11 2005 - 19:35:30)=0A=
=0A=
AMCC PowerPC 440EP Rev. B=0A=
Board: Yosemite - AMCC PPC440EP Evaluation Board=0A=
        VCO: 1066 MHz=0A=
        CPU: 533 MHz=0A=
        PLB: 133 MHz=0A=
        OPB: 66 MHz=0A=
        EPB: 66 MHz=0A=
        PCI: 66 MHz=0A=
I2C:   ready=0A=
DRAM:  256 MB=0A=
FLASH: 64 MB=0A=
PCI:   Bus Dev VenId DevId Class Int=0A=
In:    serial=0A=
Out:   serial=0A=
Err:   serial=0A=
Net:   ppc_4xx_eth0, ppc_4xx_eth1=0A=
=0A=
Type "run flash_nfs" to mount root filesystem over NFS=0A=
=0A=
Hit any key to stop autoboot:  0=0A=
=3D>=0A=
=3D> tftp 400000 uImage=0A=
ENET Speed is 100 Mbps - FULL duplex connection=0A=
Using ppc_4xx_eth0 device=0A=
TFTP from server 192.168.0.93; our IP address is 192.168.0.66=0A=
Filename 'uImage'.=0A=
Load address: 0x400000=0A=
Loading: =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         ##########################################=0A=
done=0A=
Bytes transferred =3D 1212624 (1280d0 hex)=0A=
=3D> tftp 4000000 ramdisk.img=0A=
Using ppc_4xx_eth0 device=0A=
TFTP from server 192.168.0.93; our IP address is 192.168.0.66=0A=
Filename 'ramdisk.img'.=0A=
Load address: 0x4000000=0A=
Loading: =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         #############################################=0A=
done=0A=
Bytes transferred =3D 8547050 (826aea hex)=0A=
=3D> bootm 400000 4000000=0A=
## Booting image at 00400000 ...=0A=
   Image Name:   Linux-2.6.14=0A=
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A=
   Data Size:    1212560 Bytes =3D  1.2 MB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A=
   Uncompressing Kernel Image ... OK=0A=
## Loading RAMDisk Image at 04000000 ...=0A=
   Image Name:   Yosemite Ramdisk=0A=
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)=0A=
   Data Size:    8546986 Bytes =3D  8.2 MB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A=
   Loading Ramdisk to 0f713000, end 0ff39aaa ... OK=0A=
Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #1 Sat Nov 12 =
23:29:30 CST 2005=0A=
AMCC PowerPC 440EP Yosemite Platform=0A=
Built 1 zonelists=0A=
Kernel command line:=0A=
PID hash table entries: 2048 (order: 11, 32768 bytes)=0A=
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Memory: 248576k available (1852k kernel code, 604k data, 136k init, 0k =
highmem)=0A=
Mount-cache hash table entries: 512=0A=
checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd=0A=
softlockup thread 0 started up.=0A=
Freeing initrd memory: 8346k freed=0A=
NET: Registered protocol family 16=0A=
PCI: Probing PCI hardware=0A=
usbcore: registered new driver usbfs=0A=
usbcore: registered new driver hub=0A=
SCSI subsystem initialized=0A=
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered=0A=
io scheduler cfq registered=0A=
usbmon: debugfs is not available=0A=
ppc-soc-ohci ppc-soc-ohci.0: USB Host Controller=0A=
ppc-soc-ohci ppc-soc-ohci.0: new USB bus registered, assigned bus number =
1=0A=
ppc-soc-ohci ppc-soc-ohci.0: irq 40, io mem 0xef601000=0A=
usb usb1: Product: USB Host Controller=0A=
usb usb1: Manufacturer: Linux 2.6.14 ohci_hcd=0A=
usb usb1: SerialNumber: PPC-SOC USB=0A=
hub 1-0:1.0: USB hub found=0A=
hub 1-0:1.0: 2 ports detected=0A=
Initializing USB Mass Storage driver...=0A=
usbcore: registered new driver usb-storage=0A=
USB Mass Storage support registered.=0A=
pegasus: v0.6.12 (2005/01/13), Pegasus/Pegasus II USB Ethernet driver=0A=
usbcore: registered new driver pegasus=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled=0A=
serial8250: ttyS0 at MMIO 0x0 (irq =3D 0) is a 16550A=0A=
serial8250: ttyS1 at MMIO 0x0 (irq =3D 1) is a 16550A=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
PPC 4xx OCP EMAC driver, version 3.53=0A=
mal0: initialized, 4 TX channels, 2 RX channels=0A=
zmii0: bridge in RMII mode=0A=
eth0: emac0, MAC 00:10:ec:00:87:40=0A=
eth0: found Generic MII PHY (0x01)=0A=
eth1: emac1, MAC 00:10:ec:00:87:47=0A=
eth1: found Generic MII PHY (0x03)=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 50MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
AMCC440-flash: Found 1 x16 devices at 0x0 in 16-bit bank=0A=
 Amd/Fujitsu Extended Query Table at 0x0040=0A=
AMCC440-flash: CFI does not contain boot bank location. Assuming top.=0A=
number of CFI chips: 1=0A=
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.=0A=
Creating 5 MTD partitions on "AMCC440-flash":=0A=
0x00000000-0x00180000 : "kernel"=0A=
0x00180000-0x00400000 : "root"=0A=
0x00400000-0x03f40000 : "user"=0A=
0x03f40000-0x03f80000 : "env"=0A=
0x03f80000-0x04000000 : "u-boot"=0A=
mice: PS/2 mouse device common for all mice=0A=
NET: Registered protocol family 2=0A=
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)=0A=
TCP established hash table entries: 16384 (order: 4, 65536 bytes)=0A=
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)=0A=
TCP: Hash tables configured (established 16384 bind 16384)=0A=
TCP reno registered=0A=
TCP bic registered=0A=
NET: Registered protocol family 1=0A=
NET: Registered protocol family 17=0A=
RAMDISK: Compressed image found at block 0=0A=
RAMDISK: incomplete write (-28 !=3D 32768) 4194304=0A=
VFS: Mounted root (ext2 filesystem) readonly.=0A=
Freeing unused kernel memory: 136k init=0A=
attempt to access beyond end of device=0A=
ram0: rw=3D0, want=3D32776, limit=3D8192=0A=
EXT2-fs error (device ram0): ext2_get_inode: unable to read inode block =
- inode=3D4001, block=3D16387=0A=
Warning: unable to open an initial console.=0A=
attempt to access beyond end of device=0A=
ram0: rw=3D0, want=3D49538, limit=3D8192=0A=
EXT2-fs error (device ram0): ext2_get_inode: unable to read inode block =
- inode=3D6003, block=3D24768=0A=
attempt to access beyond end of device=0A=
ram0: rw=3D0, want=3D65544, limit=3D8192=0A=
EXT2-fs error (device ram0): ext2_get_inode: unable to read inode block =
- inode=3D8001, block=3D32771=0A=
attempt to access beyond end of device=0A=
ram0: rw=3D0, want=3D16770, limit=3D8192=0A=
EXT2-fs error (device ram0): ext2_get_inode: unable to read inode block =
- inode=3D2001, block=3D8384=0A=
Kernel panic - not syncing: No init found.  Try passing init=3D option =
to kernel.=0A=
 <0>Rebooting in 180 seconds.. =0A=

------=_NextPart_000_0000_01C5E7EB.E0413DB0--
