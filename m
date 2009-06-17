Return-Path: <mehulc87@gmail.com>
Received: from mail-qy0-f197.google.com (mail-qy0-f197.google.com
	[209.85.221.197])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A3E1FB722B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 00:53:21 +1000 (EST)
Received: by qyk35 with SMTP id 35so476892qyk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 07:53:18 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Jun 2009 20:23:17 +0530
Message-ID: <251d650c0906170753y35058a93nf37532a24985767f@mail.gmail.com>
Subject: ethernet packet drop
From: Mehul Chadha <mehulc87@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e645fae8968472046c8c737f
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e645fae8968472046c8c737f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone,

                       I am working on a project for router development.

The basic specifications of the router are as follows:

=B7         Supports MPC8248 - 32-bit PowerQUICC II Communication Processor
running at 400 MHz (Max) core frequency, 200 MHz (Max) CPM, and 100MHz (Max=
)
external bus frequency.

=B7         64-bit wide 256-MByte synchronous DRAM (soldered on-board),
 consisting
of 4 no. devices of 8M x 16 x 4, residing on 60X bus (PBI mode), controlled
by SDRAM machine.

=B7         256 MB NAND Flash, organized as 256M x 8, buffered from 60X bus=
,
controlled by UPM machine.

=B7         Upto 8MB NOR Flash, Boot sector (bottom) type, organized as 8M =
x
8, buffered from 60X bus, controlled by GPCM machine.

=B7           Linux Kernel version: linux-2.6.16.40


While testing my router with the spirent test equipment, the 2 ethernet
ports of the router are connected to the testing equipment. I send data fro=
m
the testing equipment through the ethernet port , the router forwards the
packet to the other ethernet port again connected to the testing equipment.
When I increase the throughput to 70 mbps the testing equipment starts
showing packet losses which should not happen as its a 10/100 mbps link. I
am not able to understand where would the problem lie. Pls if someone can
list the different issues due to which this problem is occurring, it will b=
e
really helpful


Regards,

Mehul

--0016e645fae8968472046c8c737f
Content-Type: text/html; charset=Big5
Content-Transfer-Encoding: quoted-printable

Hello everyone,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; I am working on a project for router development.<br><br>The basic sp=
ecifications of the router are as follows:<br><meta http-equiv=3D"Content-T=
ype" content=3D"text/html; charset=3Dutf-8"><meta name=3D"ProgId" content=
=3D"Word.Document"><meta name=3D"Generator" content=3D"Microsoft Word 12"><=
meta name=3D"Originator" content=3D"Microsoft Word 12"><link rel=3D"File-Li=
st" href=3D"file:///C:%5CDOCUME%7E1%5CADMINI%7E1%5CLOCALS%7E1%5CTemp%5Cmsoh=
tmlclip1%5C01%5Cclip_filelist.xml"><link rel=3D"themeData" href=3D"file:///=
C:%5CDOCUME%7E1%5CADMINI%7E1%5CLOCALS%7E1%5CTemp%5Cmsohtmlclip1%5C01%5Cclip=
_themedata.thmx"><link rel=3D"colorSchemeMapping" href=3D"file:///C:%5CDOCU=
ME%7E1%5CADMINI%7E1%5CLOCALS%7E1%5CTemp%5Cmsohtmlclip1%5C01%5Cclip_colorsch=
ememapping.xml"><style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:1;
	mso-generic-font-family:roman;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	mso-fareast-font-family:"Times New Roman";}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:661127742;
	mso-list-type:hybrid;
	mso-list-template-ids:774290642 1074331649 1074331651 1074331653 107433164=
9 1074331651 1074331653 1074331649 1074331651 1074331653;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:=84h;
	mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
	text-indent:-.25in;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

<p class=3D"MsoNormal" style=3D"margin: 6pt 0in 0.0001pt 0.25in; text-align=
: justify; text-indent: -0.25in;"><span style=3D"font-family: Symbol; color=
: black;"><span style=3D"">=A1P<span style=3D"font-family: &quot;Times New =
Roman&quot;; font-style: normal; font-variant: normal; font-weight: normal;=
 font-size: 7pt; line-height: normal; font-size-adjust: none; font-stretch:=
 normal;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style=3D"color: black;">Supports MPC8248 - 32-bi=
t PowerQUICC II Communication Processor running
at 400 MHz (Max) core frequency, 200 MHz (Max) CPM, and 100MHz (Max) extern=
al
bus frequency.</span></p>

<p class=3D"MsoNormal" style=3D"margin: 6pt 0in 0.0001pt 0.25in; text-align=
: justify; text-indent: -0.25in;"><span style=3D"font-family: Symbol;"><spa=
n style=3D"">=A1P<span style=3D"font-family: &quot;Times New Roman&quot;; f=
ont-style: normal; font-variant: normal; font-weight: normal; font-size: 7p=
t; line-height: normal; font-size-adjust: none; font-stretch: normal;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span>64-bit wide 256-MByte synchronous DRAM (soldered
on-board), <span style=3D"">&nbsp;&nbsp;</span>consisting of 4 no. devices
of 8M x 16 x 4, residing on 60X bus (PBI mode), controlled by SDRAM machine=
.</p>

<p class=3D"MsoNormal" style=3D"margin: 6pt 0in 0.0001pt 0.25in; text-align=
: justify; text-indent: -0.25in;"><span style=3D"font-family: Symbol;"><spa=
n style=3D"">=A1P<span style=3D"font-family: &quot;Times New Roman&quot;; f=
ont-style: normal; font-variant: normal; font-weight: normal; font-size: 7p=
t; line-height: normal; font-size-adjust: none; font-stretch: normal;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style=3D"">256 MB
NAND Flash, organized as 256M x 8, buffered from 60X bus, controlled by UPM
machine.</span></p>

<p class=3D"MsoNormal" style=3D"margin: 6pt 0in 0.0001pt 0.25in; text-align=
: justify; text-indent: -0.25in;"><span style=3D"font-family: Symbol;"><spa=
n style=3D"">=A1P<span style=3D"font-family: &quot;Times New Roman&quot;; f=
ont-style: normal; font-variant: normal; font-weight: normal; font-size: 7p=
t; line-height: normal; font-size-adjust: none; font-stretch: normal;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style=3D"">Upto 8MB
NOR Flash, Boot sector (bottom) type, organized as 8M x 8, buffered from 60=
X
bus, controlled by GPCM machine. <br></span></p><p class=3D"MsoNormal" styl=
e=3D"margin: 6pt 0in 0.0001pt 0.25in; text-align: justify; text-indent: -0.=
25in;"><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dut=
f-8"><meta name=3D"ProgId" content=3D"Word.Document"><meta name=3D"Generato=
r" content=3D"Microsoft Word 12"><meta name=3D"Originator" content=3D"Micro=
soft Word 12"><link rel=3D"File-List" href=3D"file:///C:%5CDOCUME%7E1%5CADM=
INI%7E1%5CLOCALS%7E1%5CTemp%5Cmsohtmlclip1%5C01%5Cclip_filelist.xml"><link =
rel=3D"themeData" href=3D"file:///C:%5CDOCUME%7E1%5CADMINI%7E1%5CLOCALS%7E1=
%5CTemp%5Cmsohtmlclip1%5C01%5Cclip_themedata.thmx"><link rel=3D"colorScheme=
Mapping" href=3D"file:///C:%5CDOCUME%7E1%5CADMINI%7E1%5CLOCALS%7E1%5CTemp%5=
Cmsohtmlclip1%5C01%5Cclip_colorschememapping.xml"><style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:1;
	mso-generic-font-family:roman;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	mso-fareast-font-family:"Times New Roman";}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>

</p><p class=3D"MsoNormal"><span style=3D"font-family: Symbol;"><span style=
=3D"">=A1P<span style=3D"font-family: &quot;Times New Roman&quot;; font-sty=
le: normal; font-variant: normal; font-weight: normal; font-size: 7pt; line=
-height: normal; font-size-adjust: none; font-stretch: normal;">&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span>Linu=
x Kernel version: linux-2.6.16.40</p>
<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal"></p><p class=3D"MsoNo=
rmal">While testing my router with the spirent test equipment, the 2 ethern=
et ports of the router are connected to the testing equipment. I send data =
from the testing equipment through the ethernet port , the router forwards =
the packet to the other ethernet port again connected to the testing equipm=
ent. When I increase the throughput to 70 mbps the testing equipment starts=
 showing packet losses which should not happen as its a 10/100 mbps link. I=
 am not able to understand where would the problem lie. Pls if someone can =
list the different issues due to which this problem is occurring, it will b=
e really helpful</p>
<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Regards,</p><p class=
=3D"MsoNormal">Mehul<br></p>

<p></p><p class=3D"MsoNormal" style=3D"margin: 6pt 0in 0.0001pt 0.25in; tex=
t-align: justify; text-indent: -0.25in;"><br><span style=3D""></span></p>


--0016e645fae8968472046c8c737f--
