Return-Path: <shubhada@chelsio.com>
Received: from stargate.chelsio.com (stargate.chelsio.com [12.22.49.110])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53ADEDDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 07:14:55 +1100 (EST)
Received: from maui.asicdesigners.com (maui.asicdesigners.com [10.192.180.15])
	by stargate.chelsio.com (8.13.1/8.13.1) with SMTP id n1BK6qmU009277
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 12:06:53 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C98C84.5F8D4DBC"
Subject: AMCC ppc440spe 2.6.23.10  kernel boot help
Date: Wed, 11 Feb 2009 12:07:32 -0800
Message-ID: <8A71B368A89016469F72CD08050AD33402D57544@maui.asicdesigners.com>
From: "Shubhada Pugaonkar" <shubhada@chelsio.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C98C84.5F8D4DBC
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C98C84.5F8D4DBC"


------_=_NextPart_002_01C98C84.5F8D4DBC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi=20

=20

I am trying to bringup AMCC ppc440sPE  board with 2.6.23.10 kernel from
kernel.org. My .config file is attached. I used ARCH=3Dppc and
CROSS_COMPILE=3Dppc-linux- (also tried ppc_4xx-) and did 'make uImage',
but unable to boot into the kernel. My nfs and uboot settings seem to be
correct. The kernel gets stuck as shown below. Any help appreciated.
Please let me know if any more information is required.

=20

-------------------------------------------------------------

=3D> tftp 0x1000000 uImage-ppc

Waiting for PHY auto negotiation to complete.. done

ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)

Using ppc_4xx_eth0 device

TFTP from server 10.192.165.106; our IP address is 10.192.164.166

Filename 'uImage-ppc'.

Load address: 0x1000000

Loading:
#################################################################

         #############

done

Bytes transferred =3D 1132695 (114897 hex)

=3D> run flash_nfs

Using IP address ${ipaddr}

## Booting image at 01000000 ...

   Image Name:   Linux-2.6.23.10

   Created:      2009-02-10  23:58:25 UTC

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    1132631 Bytes =3D  1.1 MB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK

-------------------------------------------------------------

=20

Thanks in advance

Shubhada

=20

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>=20

Hi Steve

=20

Thanks for your reply. I compiled the kernel.

But I can only load a kernel which was configured for the ppc
architecture

make -j2 ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx-=20

O=3D../build-linux-sequoia-DENX-v2.6.23=20

sequoia_defconfig

=20

If I pass

make -j2 ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_4xx-=20

O=3D../build-linux-sequoia-DENX-v2.6.23 sequoia_defconfig

the board hangs after=20

=20

    ## Booting image at 00200000 ...

       Image Name:   Linux-2.6.23

       Image Type:   PowerPC Linux Kernel Image (gzip compressed)

       Data Size:    1461799 Bytes =3D  1.4 MB

       Load Address: 00000000

       Entry Point:  00000000

       Verifying Checksum ... OK

       Uncompressing Kernel Image ... OK

=20

I passed the same arguments to the kernel as before. Do I have to
specify=20

something different? For the kernel? or a u-boot parameter?

=20

Thanks in advance for your help

=20

Best regards

                       =20


------_=_NextPart_002_01C98C84.5F8D4DBC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

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

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Hi <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>I am trying to bringup AMCC ppc440sPE =
&nbsp;board with
2.6.23.10 kernel from kernel.org. My .config file is attached. I used =
ARCH=3Dppc
and CROSS_COMPILE=3Dppc-linux- (also tried ppc_4xx-) and did &#8216;make =
uImage&#8217;,
but unable to boot into the kernel. My nfs and uboot settings seem to be
correct. The kernel gets stuck as shown below. Any help appreciated. =
Please let
me know if any more information is =
required.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>-------------------------------------------------------------<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>=3D&gt; tftp 0x1000000 =
uImage-ppc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Waiting for PHY auto negotiation to =
complete.. done<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>ENET Speed is 100 Mbps - FULL duplex =
connection
(EMAC0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Using ppc_4xx_eth0 =
device<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>TFTP from server 10.192.165.106; our IP =
address is
10.192.164.166<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Filename =
'uImage-ppc'.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Load address: =
0x1000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Loading:
#################################################################<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#############<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>done<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Bytes transferred =3D 1132695 (114897 =
hex)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>=3D&gt; run =
flash_nfs<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Using IP address =
${ipaddr}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>## Booting image at 01000000 =
...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.23.10<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp; =
Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2009-02-10&nbsp; 23:58:25 UTC<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC =
Linux
Kernel Image (gzip compressed)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; =
1132631
Bytes =3D&nbsp; 1.1 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp; Load Address: =
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp; Entry Point:&nbsp; =
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp; Verifying Checksum ... =
OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp; Uncompressing Kernel Image ... =
OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>-------------------------------------------------------------<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Thanks in =
advance<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Shubhada<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt=
;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=
&gt;&gt;&gt;&gt;&gt;<o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Hi Steve<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Thanks for your reply. I compiled the =
kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>But I can only load a kernel which was =
configured
for the ppc architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make -j2 ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DPT-BR
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>O=3D../build-linux-sequoia-DENX-v2.6.23
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New"'>sequoia_defconfig<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>If I pass<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>make -j2 ARCH=3Dpowerpc =
CROSS_COMPILE=3Dppc_4xx- <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DPT-BR
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>O=3D../build-linux-sequoia-DENX-v2.6.23
sequoia_defconfig<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>the board hangs after =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; ## Booting image at =
00200000 ...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Image
Name:&nbsp;&nbsp; Linux-2.6.23<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Image
Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data
Size:&nbsp;&nbsp;&nbsp; 1461799 Bytes =3D&nbsp; 1.4 =
MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Load =
Address:
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Entry
Point:&nbsp; 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Verifying
Checksum ... OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Uncompressing
Kernel Image ... OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>I passed the same arguments to the kernel as =
before.
Do I have to specify <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>something different? For the kernel? or a =
u-boot
parameter?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Thanks in advance for your =
help<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Best regards</span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C98C84.5F8D4DBC--

------_=_NextPart_001_01C98C84.5F8D4DBC
Content-Type: application/octet-stream;
	name="config-ppc440"
Content-Transfer-Encoding: base64
Content-Description: config-ppc440
Content-Disposition: attachment;
	filename="config-ppc440"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yMy4xMAojIFR1ZSBGZWIgMTAgMTU6NTU6MjQgMjAwOQoj
CkNPTkZJR19NTVU9eQpDT05GSUdfR0VORVJJQ19IQVJESVJRUz15CkNPTkZJR19SV1NFTV9YQ0hH
QUREX0FMR09SSVRITT15CkNPTkZJR19BUkNIX0hBU19JTE9HMl9VMzI9eQojIENPTkZJR19BUkNI
X0hBU19JTE9HMl9VNjQgaXMgbm90IHNldApDT05GSUdfR0VORVJJQ19IV0VJR0hUPXkKQ09ORklH
X0dFTkVSSUNfQ0FMSUJSQVRFX0RFTEFZPXkKQ09ORklHX1BQQz15CkNPTkZJR19QUEMzMj15CkNP
TkZJR19HRU5FUklDX05WUkFNPXkKQ09ORklHX0dFTkVSSUNfRklORF9ORVhUX0JJVD15CkNPTkZJ
R19TQ0hFRF9OT19OT19PTUlUX0ZSQU1FX1BPSU5URVI9eQpDT05GSUdfQVJDSF9NQVlfSEFWRV9Q
Q19GREM9eQpDT05GSUdfR0VORVJJQ19CVUc9eQpDT05GSUdfREVGQ09ORklHX0xJU1Q9Ii9saWIv
bW9kdWxlcy8kVU5BTUVfUkVMRUFTRS8uY29uZmlnIgoKIwojIEdlbmVyYWwgc2V0dXAKIwpDT05G
SUdfRVhQRVJJTUVOVEFMPXkKQ09ORklHX0JST0tFTl9PTl9TTVA9eQpDT05GSUdfSU5JVF9FTlZf
QVJHX0xJTUlUPTMyCkNPTkZJR19MT0NBTFZFUlNJT049IiIKQ09ORklHX0xPQ0FMVkVSU0lPTl9B
VVRPPXkKQ09ORklHX1NXQVA9eQpDT05GSUdfU1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NU
TD15CiMgQ09ORklHX1BPU0lYX01RVUVVRSBpcyBub3Qgc2V0CiMgQ09ORklHX0JTRF9QUk9DRVNT
X0FDQ1QgaXMgbm90IHNldAojIENPTkZJR19UQVNLU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19V
U0VSX05TIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVESVQgaXMgbm90IHNldAojIENPTkZJR19JS0NP
TkZJRyBpcyBub3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZUPTE0CkNPTkZJR19TWVNGU19ERVBS
RUNBVEVEPXkKIyBDT05GSUdfUkVMQVkgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lOSVRS
RCBpcyBub3Qgc2V0CiMgQ09ORklHX0NDX09QVElNSVpFX0ZPUl9TSVpFIGlzIG5vdCBzZXQKQ09O
RklHX1NZU0NUTD15CkNPTkZJR19FTUJFRERFRD15CkNPTkZJR19TWVNDVExfU1lTQ0FMTD15CkNP
TkZJR19LQUxMU1lNUz15CiMgQ09ORklHX0tBTExTWU1TX0VYVFJBX1BBU1MgaXMgbm90IHNldAoj
IENPTkZJR19IT1RQTFVHIGlzIG5vdCBzZXQKQ09ORklHX1BSSU5USz15CkNPTkZJR19CVUc9eQpD
T05GSUdfRUxGX0NPUkU9eQpDT05GSUdfQkFTRV9GVUxMPXkKQ09ORklHX0ZVVEVYPXkKQ09ORklH
X0FOT05fSU5PREVTPXkKQ09ORklHX0VQT0xMPXkKQ09ORklHX1NJR05BTEZEPXkKQ09ORklHX0VW
RU5URkQ9eQpDT05GSUdfU0hNRU09eQpDT05GSUdfVk1fRVZFTlRfQ09VTlRFUlM9eQpDT05GSUdf
U0xBQj15CiMgQ09ORklHX1NMVUIgaXMgbm90IHNldAojIENPTkZJR19TTE9CIGlzIG5vdCBzZXQK
Q09ORklHX1JUX01VVEVYRVM9eQojIENPTkZJR19USU5ZX1NITUVNIGlzIG5vdCBzZXQKQ09ORklH
X0JBU0VfU01BTEw9MApDT05GSUdfTU9EVUxFUz15CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkKIyBD
T05GSUdfTU9EVUxFX0ZPUkNFX1VOTE9BRCBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFZFUlNJT05T
IGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX1NSQ1ZFUlNJT05fQUxMIGlzIG5vdCBzZXQKQ09O
RklHX0tNT0Q9eQpDT05GSUdfQkxPQ0s9eQojIENPTkZJR19MQkQgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX0lPX1RSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTFNGIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9CU0cgaXMgbm90IHNldAoKIwojIElPIFNjaGVkdWxlcnMKIwpDT05GSUdf
SU9TQ0hFRF9OT09QPXkKQ09ORklHX0lPU0NIRURfQVM9eQpDT05GSUdfSU9TQ0hFRF9ERUFETElO
RT15CkNPTkZJR19JT1NDSEVEX0NGUT15CkNPTkZJR19ERUZBVUxUX0FTPXkKIyBDT05GSUdfREVG
QVVMVF9ERUFETElORSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFRkFVTFRfQ0ZRIGlzIG5vdCBzZXQK
IyBDT05GSUdfREVGQVVMVF9OT09QIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfSU9TQ0hFRD0i
YW50aWNpcGF0b3J5IgoKIwojIFByb2Nlc3NvcgojCiMgQ09ORklHXzZ4eCBpcyBub3Qgc2V0CiMg
Q09ORklHXzQweCBpcyBub3Qgc2V0CkNPTkZJR180NHg9eQojIENPTkZJR184eHggaXMgbm90IHNl
dAojIENPTkZJR19FMjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRTUwMCBpcyBub3Qgc2V0CkNPTkZJ
R19QUENfRENSX05BVElWRT15CkNPTkZJR19QUENfRENSPXkKQ09ORklHX0JPT0tFPXkKQ09ORklH
X1BURV82NEJJVD15CkNPTkZJR19QSFlTXzY0QklUPXkKQ09ORklHX01BVEhfRU1VTEFUSU9OPXkK
IyBDT05GSUdfS0VYRUMgaXMgbm90IHNldAojIENPTkZJR19DUFVfRlJFUSBpcyBub3Qgc2V0CkNP
TkZJR180eHg9eQpDT05GSUdfV0FOVF9FQVJMWV9TRVJJQUw9eQoKIwojIElCTSA0eHggb3B0aW9u
cwojCiMgQ09ORklHX0JBTUJPTyBpcyBub3Qgc2V0CiMgQ09ORklHX0VCT05ZIGlzIG5vdCBzZXQK
Q09ORklHX0xVQU49eQojIENPTkZJR19ZVUNDQSBpcyBub3Qgc2V0CiMgQ09ORklHX09DT1RFQSBp
cyBub3Qgc2V0CiMgQ09ORklHX1RBSVNIQU4gaXMgbm90IHNldApDT05GSUdfNDQwU1A9eQpDT05G
SUdfNDQwPXkKQ09ORklHX0lCTV9PQ1A9eQpDT05GSUdfSUJNX0VNQUM0PXkKIyBDT05GSUdfUFBD
NHh4X0RNQSBpcyBub3Qgc2V0CkNPTkZJR19QUENfR0VONTUwPXkKQ09ORklHX05PVF9DT0hFUkVO
VF9DQUNIRT15CgojCiMgUGxhdGZvcm0gb3B0aW9ucwojCiMgQ09ORklHX1BDX0tFWUJPQVJEIGlz
IG5vdCBzZXQKQ09ORklHX0hJR0hNRU09eQpDT05GSUdfQVJDSF9QT1BVTEFURVNfTk9ERV9NQVA9
eQojIENPTkZJR19IWl8xMDAgaXMgbm90IHNldApDT05GSUdfSFpfMjUwPXkKIyBDT05GSUdfSFpf
MzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpfMTAwMCBpcyBub3Qgc2V0CkNPTkZJR19IWj0yNTAK
Q09ORklHX1BSRUVNUFRfTk9ORT15CiMgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0CkNPTkZJR19TRUxFQ1RfTUVNT1JZX01PREVM
PXkKQ09ORklHX0ZMQVRNRU1fTUFOVUFMPXkKIyBDT05GSUdfRElTQ09OVElHTUVNX01BTlVBTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NQQVJTRU1FTV9NQU5VQUwgaXMgbm90IHNldApDT05GSUdfRkxB
VE1FTT15CkNPTkZJR19GTEFUX05PREVfTUVNX01BUD15CiMgQ09ORklHX1NQQVJTRU1FTV9TVEFU
SUMgaXMgbm90IHNldApDT05GSUdfU1BMSVRfUFRMT0NLX0NQVVM9NAojIENPTkZJR19SRVNPVVJD
RVNfNjRCSVQgaXMgbm90IHNldApDT05GSUdfWk9ORV9ETUFfRkxBRz0xCkNPTkZJR19CT1VOQ0U9
eQpDT05GSUdfVklSVF9UT19CVVM9eQpDT05GSUdfQklORk1UX0VMRj15CiMgQ09ORklHX0JJTkZN
VF9NSVNDIGlzIG5vdCBzZXQKQ09ORklHX0NNRExJTkVfQk9PTD15CkNPTkZJR19DTURMSU5FPSJy
b290PS9kZXYvbmZzIHJ3IGlwPTEwLjE5Mi4xNjQuMTY2OjEwLjE5Mi4xNjUuMTA2OjEwLjE5Mi4x
NjAuMToyNTUuMjU1LjI0MC4wOnBwY2IxOmV0aDA6b2ZmIGNvbnNvbGU9dHR5UzAsMTE1MjAwIG5m
c3Jvb3Q9MTAuMTkyLjE2NS4xMDY6L29wdC9lbGRrNC4xL3BwY180eHgsdGNwLHYzLHdzaXplPTgx
OTIscnNpemU9ODE5MiIKQ09ORklHX1NFQ0NPTVA9eQpDT05GSUdfSVNBX0RNQV9BUEk9eQoKIwoj
IEJ1cyBvcHRpb25zCiMKQ09ORklHX1pPTkVfRE1BPXkKIyBDT05GSUdfUFBDX0k4MjU5IGlzIG5v
dCBzZXQKQ09ORklHX1BQQ19JTkRJUkVDVF9QQ0k9eQpDT05GSUdfUENJPXkKQ09ORklHX1BDSV9E
T01BSU5TPXkKQ09ORklHX1BDSV9TWVNDQUxMPXkKIyBDT05GSUdfQVJDSF9TVVBQT1JUU19NU0kg
aXMgbm90IHNldAoKIwojIFBDQ0FSRCAoUENNQ0lBL0NhcmRCdXMpIHN1cHBvcnQKIwoKIwojIEFk
dmFuY2VkIHNldHVwCiMKQ09ORklHX0FEVkFOQ0VEX09QVElPTlM9eQpDT05GSUdfSElHSE1FTV9T
VEFSVF9CT09MPXkKQ09ORklHX0hJR0hNRU1fU1RBUlQ9MHhmMDAwMDAwMAojIENPTkZJR19MT1dN
RU1fU0laRV9CT09MIGlzIG5vdCBzZXQKQ09ORklHX0xPV01FTV9TSVpFPTB4MzAwMDAwMDAKIyBD
T05GSUdfS0VSTkVMX1NUQVJUX0JPT0wgaXMgbm90IHNldApDT05GSUdfS0VSTkVMX1NUQVJUPTB4
YzAwMDAwMDAKIyBDT05GSUdfVEFTS19TSVpFX0JPT0wgaXMgbm90IHNldApDT05GSUdfVEFTS19T
SVpFPTB4ODAwMDAwMDAKQ09ORklHX0NPTlNJU1RFTlRfU1RBUlRfQk9PTD15CkNPTkZJR19DT05T
SVNURU5UX1NUQVJUPTB4ZjIwMDAwMDAKQ09ORklHX0NPTlNJU1RFTlRfU0laRV9CT09MPXkKQ09O
RklHX0NPTlNJU1RFTlRfU0laRT0weDA0MDAwMDAwCiMgQ09ORklHX0JPT1RfTE9BRF9CT09MIGlz
IG5vdCBzZXQKQ09ORklHX0JPT1RfTE9BRD0weDAxMDAwMDAwCgojCiMgTmV0d29ya2luZwojCkNP
TkZJR19ORVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9eQojIENP
TkZJR19QQUNLRVRfTU1BUCBpcyBub3Qgc2V0CkNPTkZJR19VTklYPXkKQ09ORklHX1hGUk09eQoj
IENPTkZJR19YRlJNX1VTRVIgaXMgbm90IHNldAojIENPTkZJR19YRlJNX1NVQl9QT0xJQ1kgaXMg
bm90IHNldAojIENPTkZJR19YRlJNX01JR1JBVEUgaXMgbm90IHNldAojIENPTkZJR19ORVRfS0VZ
IGlzIG5vdCBzZXQKQ09ORklHX0lORVQ9eQojIENPTkZJR19JUF9NVUxUSUNBU1QgaXMgbm90IHNl
dAojIENPTkZJR19JUF9BRFZBTkNFRF9ST1VURVIgaXMgbm90IHNldApDT05GSUdfSVBfRklCX0hB
U0g9eQpDT05GSUdfSVBfUE5QPXkKIyBDT05GSUdfSVBfUE5QX0RIQ1AgaXMgbm90IHNldApDT05G
SUdfSVBfUE5QX0JPT1RQPXkKIyBDT05GSUdfSVBfUE5QX1JBUlAgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfSVBJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUEdSRSBpcyBub3Qgc2V0CiMgQ09O
RklHX0FSUEQgaXMgbm90IHNldAojIENPTkZJR19TWU5fQ09PS0lFUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lORVRfQUggaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lORVRfSVBDT01QIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9YRlJNX1RVTk5FTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lORVRfVFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0lORVRfWEZSTV9N
T0RFX1RSQU5TUE9SVD15CkNPTkZJR19JTkVUX1hGUk1fTU9ERV9UVU5ORUw9eQpDT05GSUdfSU5F
VF9YRlJNX01PREVfQkVFVD15CiMgQ09ORklHX0lORVRfRElBRyBpcyBub3Qgc2V0CiMgQ09ORklH
X1RDUF9DT05HX0FEVkFOQ0VEIGlzIG5vdCBzZXQKQ09ORklHX1RDUF9DT05HX0NVQklDPXkKQ09O
RklHX0RFRkFVTFRfVENQX0NPTkc9ImN1YmljIgojIENPTkZJR19UQ1BfTUQ1U0lHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBWNiBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X1hGUk1fVFVOTkVMIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUV09S
S19TRUNNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSIGlzIG5vdCBzZXQKIyBDT05G
SUdfSVBfRENDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAojIENPTkZJ
R19USVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJJREdF
IGlzIG5vdCBzZXQKIyBDT05GSUdfVkxBTl84MDIxUSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQ05F
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJR19JUFggaXMgbm90
IHNldAojIENPTkZJR19BVEFMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBub3Qgc2V0CiMg
Q09ORklHX0xBUEIgaXMgbm90IHNldAojIENPTkZJR19FQ09ORVQgaXMgbm90IHNldAojIENPTkZJ
R19XQU5fUk9VVEVSIGlzIG5vdCBzZXQKCiMKIyBRb1MgYW5kL29yIGZhaXIgcXVldWVpbmcKIwoj
IENPTkZJR19ORVRfU0NIRUQgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgdGVzdGluZwojCiMgQ09O
RklHX05FVF9QS1RHRU4gaXMgbm90IHNldAojIENPTkZJR19IQU1SQURJTyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lSREEgaXMgbm90IHNldAojIENPTkZJR19CVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FG
X1JYUlBDIGlzIG5vdCBzZXQKCiMKIyBXaXJlbGVzcwojCiMgQ09ORklHX0NGRzgwMjExIGlzIG5v
dCBzZXQKIyBDT05GSUdfV0lSRUxFU1NfRVhUIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTEg
aXMgbm90IHNldAojIENPTkZJR19JRUVFODAyMTEgaXMgbm90IHNldAojIENPTkZJR19SRktJTEwg
aXMgbm90IHNldAojIENPTkZJR19ORVRfOVAgaXMgbm90IHNldAoKIwojIERldmljZSBEcml2ZXJz
CiMKCiMKIyBHZW5lcmljIERyaXZlciBPcHRpb25zCiMKIyBDT05GSUdfU1RBTkRBTE9ORSBpcyBu
b3Qgc2V0CkNPTkZJR19QUkVWRU5UX0ZJUk1XQVJFX0JVSUxEPXkKIyBDT05GSUdfU1lTX0hZUEVS
VklTT1IgaXMgbm90IHNldAojIENPTkZJR19DT05ORUNUT1IgaXMgbm90IHNldAojIENPTkZJR19N
VEQgaXMgbm90IHNldAojIENPTkZJR19QQVJQT1JUIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVY9
eQojIENPTkZJR19CTEtfREVWX0ZEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0NQUV9EQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19DUFFfQ0lTU19EQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfREFDOTYwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9VTUVNIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9DT1dfQ09NTU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9MT09Q
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OQkQgaXMgbm90IHNldAojIENPTkZJR19CTEtf
REVWX1NYOCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUkFNIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ0RST01fUEtUQ0RWRCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQV9PVkVSX0VUSCBpcyBub3Qg
c2V0CiMgQ09ORklHX1hJTElOWF9TWVNBQ0UgaXMgbm90IHNldApDT05GSUdfTUlTQ19ERVZJQ0VT
PXkKIyBDT05GSUdfUEhBTlRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV85M0NYNiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NHSV9JT0M0IGlzIG5vdCBzZXQKIyBDT05GSUdfVElGTV9DT1JFIGlz
IG5vdCBzZXQKIyBDT05GSUdfSURFIGlzIG5vdCBzZXQKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0
CiMKIyBDT05GSUdfUkFJRF9BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0kgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0RNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTkVUTElOSyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FUQSBpcyBub3Qgc2V0CiMgQ09ORklHX01EIGlzIG5vdCBzZXQKCiMK
IyBGdXNpb24gTVBUIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQK
CiMKIyBJRUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBwb3J0CiMKIyBDT05GSUdfRklSRVdJUkUgaXMg
bm90IHNldAojIENPTkZJR19JRUVFMTM5NCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyTyBpcyBub3Qg
c2V0CiMgQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTIGlzIG5vdCBzZXQKQ09ORklHX05FVERFVklD
RVM9eQojIENPTkZJR19ORVRERVZJQ0VTX01VTFRJUVVFVUUgaXMgbm90IHNldAojIENPTkZJR19E
VU1NWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJR19NQUNW
TEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfRVFVQUxJWkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVFVO
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZTElCIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9FVEhFUk5FVD15CiMgQ09ORklHX01JSSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hBUFBZTUVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NBU1NJTkkgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SXzNDT00gaXMgbm90
IHNldAojIENPTkZJR19ORVRfVFVMSVAgaXMgbm90IHNldAojIENPTkZJR19IUDEwMCBpcyBub3Qg
c2V0CkNPTkZJR19JQk1fRU1BQz15CkNPTkZJR19JQk1fRU1BQ19SWEI9MTI4CkNPTkZJR19JQk1f
RU1BQ19UWEI9MTI4CkNPTkZJR19JQk1fRU1BQ19QT0xMX1dFSUdIVD0zMgpDT05GSUdfSUJNX0VN
QUNfUlhfQ09QWV9USFJFU0hPTEQ9MjU2CkNPTkZJR19JQk1fRU1BQ19SWF9TS0JfSEVBRFJPT009
MAojIENPTkZJR19JQk1fRU1BQ19ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19JQk1fRU1BQ19aTUlJ
PXkKIyBDT05GSUdfTkVUX1BDSSBpcyBub3Qgc2V0CkNPTkZJR19ORVRERVZfMTAwMD15CiMgQ09O
RklHX0FDRU5JQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RMMksgaXMgbm90IHNldApDT05GSUdfRTEw
MDA9eQojIENPTkZJR19FMTAwMF9OQVBJIGlzIG5vdCBzZXQKIyBDT05GSUdfRTEwMDBfRElTQUJM
RV9QQUNLRVRfU1BMSVQgaXMgbm90IHNldAojIENPTkZJR19OUzgzODIwIGlzIG5vdCBzZXQKIyBD
T05GSUdfSEFNQUNISSBpcyBub3Qgc2V0CiMgQ09ORklHX1lFTExPV0ZJTiBpcyBub3Qgc2V0CiMg
Q09ORklHX1I4MTY5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0lTMTkwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0tHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NLWTIgaXMgbm90IHNldAojIENPTkZJR19TSzk4
TElOIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1ZFTE9DSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdf
VElHT04zIGlzIG5vdCBzZXQKIyBDT05GSUdfQk5YMiBpcyBub3Qgc2V0CiMgQ09ORklHX1FMQTNY
WFggaXMgbm90IHNldAojIENPTkZJR19BVEwxIGlzIG5vdCBzZXQKQ09ORklHX05FVERFVl8xMDAw
MD15CiMgQ09ORklHX0NIRUxTSU9fVDEgaXMgbm90IHNldAojIENPTkZJR19DSEVMU0lPX1QzIGlz
IG5vdCBzZXQKIyBDT05GSUdfSVhHQiBpcyBub3Qgc2V0CiMgQ09ORklHX1MySU8gaXMgbm90IHNl
dAojIENPTkZJR19NWVJJMTBHRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFhFTl9OSUMgaXMgbm90
IHNldAojIENPTkZJR19NTFg0X0NPUkUgaXMgbm90IHNldAojIENPTkZJR19UUiBpcyBub3Qgc2V0
CgojCiMgV2lyZWxlc3MgTEFOCiMKIyBDT05GSUdfV0xBTl9QUkU4MDIxMSBpcyBub3Qgc2V0CiMg
Q09ORklHX1dMQU5fODAyMTEgaXMgbm90IHNldAojIENPTkZJR19XQU4gaXMgbm90IHNldAojIENP
TkZJR19GRERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElQUEkgaXMgbm90IHNldAojIENPTkZJR19Q
UFAgaXMgbm90IHNldAojIENPTkZJR19TTElQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0hBUEVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUQ09OU09MRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFBPTEwg
aXMgbm90IHNldAojIENPTkZJR19ORVRfUE9MTF9DT05UUk9MTEVSIGlzIG5vdCBzZXQKIyBDT05G
SUdfSVNETiBpcyBub3Qgc2V0CiMgQ09ORklHX1BIT05FIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBk
ZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19JTlBVVD15CiMgQ09ORklHX0lOUFVUX0ZGX01FTUxFU1Mg
aXMgbm90IHNldAojIENPTkZJR19JTlBVVF9QT0xMREVWIGlzIG5vdCBzZXQKCiMKIyBVc2VybGFu
ZCBpbnRlcmZhY2VzCiMKIyBDT05GSUdfSU5QVVRfTU9VU0VERVYgaXMgbm90IHNldAojIENPTkZJ
R19JTlBVVF9KT1lERVYgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9UU0RFViBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX0VWREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRVZCVUcgaXMg
bm90IHNldAoKIwojIElucHV0IERldmljZSBEcml2ZXJzCiMKIyBDT05GSUdfSU5QVVRfS0VZQk9B
UkQgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
UFVUX0pPWVNUSUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVEFCTEVUIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU4gaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NSVND
IGlzIG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwpDT05GSUdfU0VSSU89eQojIENP
TkZJR19TRVJJT19JODA0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1NFUlBPUlQgaXMgbm90
IHNldAojIENPTkZJR19TRVJJT19QQ0lQUzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19MSUJQ
UzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19SQVcgaXMgbm90IHNldAojIENPTkZJR19HQU1F
UE9SVCBpcyBub3Qgc2V0CgojCiMgQ2hhcmFjdGVyIGRldmljZXMKIwojIENPTkZJR19WVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CgojCiMgU2VyaWFs
IGRyaXZlcnMKIwpDT05GSUdfU0VSSUFMXzgyNTA9eQpDT05GSUdfU0VSSUFMXzgyNTBfQ09OU09M
RT15CkNPTkZJR19TRVJJQUxfODI1MF9QQ0k9eQpDT05GSUdfU0VSSUFMXzgyNTBfTlJfVUFSVFM9
NApDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz00CkNPTkZJR19TRVJJQUxfODI1MF9F
WFRFTkRFRD15CiMgQ09ORklHX1NFUklBTF84MjUwX01BTllfUE9SVFMgaXMgbm90IHNldApDT05G
SUdfU0VSSUFMXzgyNTBfU0hBUkVfSVJRPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfREVURUNUX0lS
USBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX1JTQSBpcyBub3Qgc2V0CgojCiMgTm9u
LTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCiMgQ09ORklHX1NFUklBTF9VQVJUTElURSBpcyBu
b3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJQUxfQ09SRV9DT05TT0xFPXkK
IyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJ
R19MRUdBQ1lfUFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZX0NPVU5UPTI1NgojIENPTkZJR19JUE1J
X0hBTkRMRVIgaXMgbm90IHNldAojIENPTkZJR19XQVRDSERPRyBpcyBub3Qgc2V0CkNPTkZJR19I
V19SQU5ET009bQojIENPTkZJR19OVlJBTSBpcyBub3Qgc2V0CiMgQ09ORklHX0dFTl9SVEMgaXMg
bm90IHNldAojIENPTkZJR19SMzk2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExJQ09NIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUdQIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNIGlzIG5vdCBzZXQKIyBD
T05GSUdfUkFXX0RSSVZFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RDR19UUE0gaXMgbm90IHNldApD
T05GSUdfREVWUE9SVD15CkNPTkZJR19JMkM9eQpDT05GSUdfSTJDX0JPQVJESU5GTz15CkNPTkZJ
R19JMkNfQ0hBUkRFVj15CgojCiMgSTJDIEFsZ29yaXRobXMKIwojIENPTkZJR19JMkNfQUxHT0JJ
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEdPUENGIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X0FMR09QQ0EgaXMgbm90IHNldAoKIwojIEkyQyBIYXJkd2FyZSBCdXMgc3VwcG9ydAojCiMgQ09O
RklHX0kyQ19BTEkxNTM1IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMSTE1NjMgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfQUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ3NTYgaXMg
bm90IHNldAojIENPTkZJR19JMkNfQU1EODExMSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19JODAx
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0k4MTAgaXMgbm90IHNldAojIENPTkZJR19JMkNfUElJ
WDQgaXMgbm90IHNldApDT05GSUdfSTJDX0lCTV9JSUM9eQojIENPTkZJR19JMkNfTVBDIGlzIG5v
dCBzZXQKIyBDT05GSUdfSTJDX05GT1JDRTIgaXMgbm90IHNldAojIENPTkZJR19JMkNfT0NPUkVT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BBUlBPUlRfTElHSFQgaXMgbm90IHNldAojIENPTkZJ
R19JMkNfUFJPU0FWQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NBVkFHRTQgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzU1OTUgaXMg
bm90IHNldAojIENPTkZJR19JMkNfU0lTNjMwIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzk2
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19UQU9TX0VWTSBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19TVFVCIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19WSUFQUk8gaXMgbm90IHNldAojIENPTkZJR19JMkNfVk9PRE9PMyBpcyBub3Qgc2V0CgojCiMg
TWlzY2VsbGFuZW91cyBJMkMgQ2hpcCBzdXBwb3J0CiMKIyBDT05GSUdfU0VOU09SU19EUzEzMzcg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0RTMTM3NCBpcyBub3Qgc2V0CiMgQ09ORklHX0RT
MTY4MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRUVQUk9NIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19QQ0Y4NTc0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQ0E5NTM5IGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQ0Y4NTkxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19NNDFUMDAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY4NzUgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX1RTTDI1NTAgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdf
Q09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19BTEdPIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0RFQlVHX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DSElQIGlzIG5v
dCBzZXQKCiMKIyBTUEkgc3VwcG9ydAojCiMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NQSV9NQVNURVIgaXMgbm90IHNldAojIENPTkZJR19XMSBpcyBub3Qgc2V0CiMgQ09ORklHX1BP
V0VSX1NVUFBMWSBpcyBub3Qgc2V0CkNPTkZJR19IV01PTj15CiMgQ09ORklHX0hXTU9OX1ZJRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUJJVFVHVVJVIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19BQklUVUdVUlUzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRDc0MTggaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMjEgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0FETTEwMjUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMjYgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0FETTEwMjkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FE
TTEwMzEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTkyNDAgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0FTQjEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVRYUDEgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0RTMTYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfRjcxODA1RiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRlNDSEVSIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19GU0NQT1MgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTE4
U00gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTIwU00gaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0lUODcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNjMgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0xNNzUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzcg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzggaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0xNODAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODMgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0xNODUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODcgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0xNOTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xN
OTIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNOTMgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX01BWDE2MTkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2NTAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1BDODczNjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1BDODc0MjcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NJUzU1OTUgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0RNRTE3MzcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0
N00xIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TTVNDNDdNMTkyIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19TTVNDNDdCMzk3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19USE1D
NTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZJQTY4NkEgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1ZUMTIxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVlQ4MjMxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3ODFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19XODM3OTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTJEIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19XODM3OTMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4M0w3
ODVUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNjI3SEYgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1c4MzYyN0VIRiBpcyBub3Qgc2V0CiMgQ09ORklHX0hXTU9OX0RFQlVHX0NI
SVAgaXMgbm90IHNldAoKIwojIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJ
R19NRkRfU001MDEgaXMgbm90IHNldAoKIwojIE11bHRpbWVkaWEgZGV2aWNlcwojCiMgQ09ORklH
X1ZJREVPX0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX0RWQl9DT1JFIGlzIG5vdCBzZXQKQ09ORklH
X0RBQj15CgojCiMgR3JhcGhpY3Mgc3VwcG9ydAojCiMgQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQ
UE9SVCBpcyBub3Qgc2V0CgojCiMgRGlzcGxheSBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX0RJ
U1BMQVlfU1VQUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZHQVNUQVRFIGlzIG5vdCBzZXQKQ09O
RklHX1ZJREVPX09VVFBVVF9DT05UUk9MPW0KIyBDT05GSUdfRkIgaXMgbm90IHNldAojIENPTkZJ
R19GQl9JQk1fR1hUNDUwMCBpcyBub3Qgc2V0CgojCiMgU291bmQKIwojIENPTkZJR19TT1VORCBp
cyBub3Qgc2V0CkNPTkZJR19ISURfU1VQUE9SVD15CkNPTkZJR19ISUQ9eQojIENPTkZJR19ISURf
REVCVUcgaXMgbm90IHNldApDT05GSUdfVVNCX1NVUFBPUlQ9eQpDT05GSUdfVVNCX0FSQ0hfSEFT
X0hDRD15CkNPTkZJR19VU0JfQVJDSF9IQVNfT0hDST15CkNPTkZJR19VU0JfQVJDSF9IQVNfRUhD
ST15CiMgQ09ORklHX1VTQiBpcyBub3Qgc2V0CgojCiMgTk9URTogVVNCX1NUT1JBR0UgZW5hYmxl
cyBTQ1NJLCBhbmQgJ1NDU0kgZGlzayBzdXBwb3J0JwojCgojCiMgVVNCIEdhZGdldCBTdXBwb3J0
CiMKIyBDT05GSUdfVVNCX0dBREdFVCBpcyBub3Qgc2V0CiMgQ09ORklHX01NQyBpcyBub3Qgc2V0
CiMgQ09ORklHX05FV19MRURTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5GSU5JQkFORCBpcyBub3Qg
c2V0CiMgQ09ORklHX0VEQUMgaXMgbm90IHNldAojIENPTkZJR19SVENfQ0xBU1MgaXMgbm90IHNl
dAoKIwojIERNQSBFbmdpbmUgc3VwcG9ydAojCiMgQ09ORklHX0RNQV9FTkdJTkUgaXMgbm90IHNl
dAoKIwojIERNQSBDbGllbnRzCiMKCiMKIyBETUEgRGV2aWNlcwojCgojCiMgVXNlcnNwYWNlIEkv
TwojCiMgQ09ORklHX1VJTyBpcyBub3Qgc2V0CgojCiMgRmlsZSBzeXN0ZW1zCiMKIyBDT05GSUdf
RVhUMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDNfRlMgaXMgbm90IHNldAojIENPTkZJR19F
WFQ0REVWX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVJU0VSRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19KRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19GU19QT1NJWF9BQ0wgaXMgbm90IHNldAoj
IENPTkZJR19YRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19HRlMyX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfT0NGUzJfRlMgaXMgbm90IHNldAojIENPTkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1JPTUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5PVElGWSBpcyBub3Qgc2V0CiMg
Q09ORklHX1FVT1RBIGlzIG5vdCBzZXQKIyBDT05GSUdfRE5PVElGWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0FVVE9GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FVVE9GUzRfRlMgaXMgbm90IHNldAoj
IENPTkZJR19GVVNFX0ZTIGlzIG5vdCBzZXQKCiMKIyBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCiMK
IyBDT05GSUdfSVNPOTY2MF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VERl9GUyBpcyBub3Qgc2V0
CgojCiMgRE9TL0ZBVC9OVCBGaWxlc3lzdGVtcwojCiMgQ09ORklHX01TRE9TX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVkZBVF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX05URlNfRlMgaXMgbm90IHNl
dAoKIwojIFBzZXVkbyBmaWxlc3lzdGVtcwojCkNPTkZJR19QUk9DX0ZTPXkKQ09ORklHX1BST0Nf
S0NPUkU9eQpDT05GSUdfUFJPQ19TWVNDVEw9eQpDT05GSUdfU1lTRlM9eQojIENPTkZJR19UTVBG
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0hVR0VUTEJfUEFHRSBpcyBub3Qgc2V0CkNPTkZJR19SQU1G
Uz15CiMgQ09ORklHX0NPTkZJR0ZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBNaXNjZWxsYW5lb3VzIGZp
bGVzeXN0ZW1zCiMKIyBDT05GSUdfQURGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGRlNfRlMg
aXMgbm90IHNldAojIENPTkZJR19IRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IRlNQTFVTX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkVGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JGU19GUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0VGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQU1GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IUEZTX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVl9GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VGU19GUyBpcyBub3Qgc2V0CgojCiMgTmV0d29yayBGaWxlIFN5c3Rl
bXMKIwpDT05GSUdfTkZTX0ZTPXkKIyBDT05GSUdfTkZTX1YzIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkZTX1Y0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX0RJUkVDVElPIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkZTRCBpcyBub3Qgc2V0CkNPTkZJR19ST09UX05GUz15CkNPTkZJR19MT0NLRD15CkNPTkZJ
R19ORlNfQ09NTU9OPXkKQ09ORklHX1NVTlJQQz15CiMgQ09ORklHX1NVTlJQQ19CSU5EMzQgaXMg
bm90IHNldAojIENPTkZJR19SUENTRUNfR1NTX0tSQjUgaXMgbm90IHNldAojIENPTkZJR19SUENT
RUNfR1NTX1NQS00zIGlzIG5vdCBzZXQKIyBDT05GSUdfU01CX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ0lGUyBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NP
REFfRlMgaXMgbm90IHNldAojIENPTkZJR19BRlNfRlMgaXMgbm90IHNldAoKIwojIFBhcnRpdGlv
biBUeXBlcwojCiMgQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJR19N
U0RPU19QQVJUSVRJT049eQoKIwojIE5hdGl2ZSBMYW5ndWFnZSBTdXBwb3J0CiMKIyBDT05GSUdf
TkxTIGlzIG5vdCBzZXQKCiMKIyBEaXN0cmlidXRlZCBMb2NrIE1hbmFnZXIKIwojIENPTkZJR19E
TE0gaXMgbm90IHNldAoKIwojIExpYnJhcnkgcm91dGluZXMKIwpDT05GSUdfQklUUkVWRVJTRT15
CiMgQ09ORklHX0NSQ19DQ0lUVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzE2IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JDX0lUVV9UIGlzIG5vdCBzZXQKQ09ORklHX0NSQzMyPXkKIyBDT05GSUdfQ1JD
NyBpcyBub3Qgc2V0CkNPTkZJR19MSUJDUkMzMkM9eQpDT05GSUdfUExJU1Q9eQpDT05GSUdfSEFT
X0lPTUVNPXkKQ09ORklHX0hBU19JT1BPUlQ9eQpDT05GSUdfSEFTX0RNQT15CiMgQ09ORklHX1BS
T0ZJTElORyBpcyBub3Qgc2V0CgojCiMgS2VybmVsIGhhY2tpbmcKIwpDT05GSUdfUFJJTlRLX1RJ
TUU9eQpDT05GSUdfRU5BQkxFX01VU1RfQ0hFQ0s9eQojIENPTkZJR19NQUdJQ19TWVNSUSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VOVVNFRF9TWU1CT0xTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
RlMgaXMgbm90IHNldAojIENPTkZJR19IRUFERVJTX0NIRUNLIGlzIG5vdCBzZXQKIyBDT05GSUdf
REVCVUdfS0VSTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfQlVHVkVSQk9TRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFUklBTF9URVhUX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1BQQ19PQ1A9
eQoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwojIENPTkZJR19LRVlTIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VDVVJJVFkgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPPXkKQ09ORklHX0NSWVBUT19BTEdB
UEk9eQpDT05GSUdfQ1JZUFRPX0JMS0NJUEhFUj1tCkNPTkZJR19DUllQVE9fTUFOQUdFUj1tCiMg
Q09ORklHX0NSWVBUT19ITUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1hDQkMgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fTlVMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19NRDQg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTUQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X1NIQTEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0hBMjU2IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1NIQTUxMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19XUDUxMiBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19UR1IxOTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fR0Yx
MjhNVUwgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0VDQj1tCkNPTkZJR19DUllQVE9fQ0JDPW0K
Q09ORklHX0NSWVBUT19QQ0JDPW0KIyBDT05GSUdfQ1JZUFRPX0xSVyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19DUllQVEQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0ZDUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19CTE9X
RklTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNIIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1NFUlBFTlQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQUVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q2
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RFQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19BUkM0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0tIQVpBRCBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19BTlVCSVMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVGTEFURSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19NSUNIQUVMX01JQyBpcyBub3Qgc2V0CkNPTkZJR19DUllQ
VE9fQ1JDMzJDPXkKIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1RFU1QgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0hXPXkK

------_=_NextPart_001_01C98C84.5F8D4DBC--
