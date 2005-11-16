Return-Path: <mqy@263.net.cn>
Received: from smtp.263.net (263.net.cn [211.150.96.21])
	by ozlabs.org (Postfix) with ESMTP id 586F768749
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 23:18:47 +1100 (EST)
Received: from 263.net (smtp1 [127.0.0.1])
	by smtp.263.net (Postfix) with ESMTP id 1C1BD1FD0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 20:18:46 +0800 (CST) (envelope-from mqy@263.net.cn)
Received: from image (unknown [221.232.15.178]) by 263.net (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 20:18:45 +0800 (CST)
From: "KylongMu" <mqy@263.net.cn>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 16 Nov 2005 20:18:31 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C5EAEA.EC64E810"
In-Reply-To: 
Message-Id: <20051116121846.1C1BD1FD0@smtp.263.net>
Subject: 11-16-05 2.6.14 on AMCC Yosemite board(PCI-IDE card boot error) 
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

------=_NextPart_000_0005_01C5EAEA.EC64E810
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0006_01C5EAEA.EC64E810"


------=_NextPart_001_0006_01C5EAEA.EC64E810
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Denk,

     Thanks for your help; it makes my Yosemite run up! I'm try to add a
PCI-IDE

Card on it. I test my Promise-PDC20268 card and AEC6280 (ATP865-B chip type)
card,

Both of them all failed with same error, the boot message included in the
attachment.

     The kernel configure is based on the Yosemite_defconfig, add with:

Device Drivers-->

                   ATA/ATAPI/MFM/RLL support-->

                                               [*]AEC62XX Chipset support


                                               [*]PROMISE
PDC202{68|69|70|71|75|76|77} SUPPORT  

 

     Both of the PCI-IDE cards can work with X86PC+FEDORA4 configure, I
don't know 

What cause them fail on Yosemite with final 2.6.14 kernel.

     About my 2.6.14 tree, I type with "cg-log -s" command it shows:

99a21389c2b0e55f30b6cf6550cb492b87dbaa3b Heiko Schocher  2005-11-11 12:47
[PATCH]       ppc32: fix Kernel Panic for PM82x Board with gcc-4.0.

ff1df84b3c3154ffdb646941e1c70d17554e3042 Wolfgang Denk   2005-11-10 00:41
Merge with /home/wd/git/linux-2.6/stefan_roese

 

     It only shows 2.6.14 on the kernel message, I don't know why it doesn't
show the message as you told.

But it can work, and fixed the bugs on Yosemite.

 

Cordially,

Kylong Mu

 

 


------=_NextPart_001_0006_01C5EAEA.EC64E810
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chsdate" downloadurl=3D""/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv" downloadurl=3D""/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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
style=3D'font-size:9.0pt'>Dear Denk,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp; Thanks
for your help; it makes my <st1:place w:st=3D"on">Yosemite</st1:place> =
run up!
I'm try to add a PCI-IDE<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>Card on it. I test my
Promise-PDC20268 card and AEC6280 (ATP865-B chip type) =
card,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>Both of them all =
failed with same
error, the boot message included in the =
attachment.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
size=3D1 color=3Dblack><span lang=3DEN-US =
style=3D'font-size:7.5pt;color:black'>The
kernel configure is based on the Yosemite_defconfig, add =
with:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblue =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:blue'>Device =
Drivers--&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblue =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:blue'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
size=3D1 color=3Dblue><span lang=3DEN-US =
style=3D'font-size:7.5pt;color:blue'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ATA/ATAPI/MFM/RLL support--&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblue =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:blue'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></font><font size=3D1 color=3Dblue><span lang=3DEN-US =
style=3D'font-size:7.5pt;
color:blue'>[*]AEC62XX Chipset
support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblue =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:blue'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
[*]PROMISE PDC202{68|69|70|71|75|76|77} SUPPORT&nbsp; =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:7.5pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp; Both of
the PCI-IDE cards can work with X86PC+FEDORA4 configure, I =
don</span></font><font
color=3Dblack face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-family:"Courier New";
color:black'>&#8217;</span></font><font color=3Dblack><span lang=3DEN-US
style=3D'color:black'>t know <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>What cause them fail =
on <st1:place
w:st=3D"on">Yosemite</st1:place> with final <st1:chsdate =
IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.14</st1:chsdate>
kernel.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp; About
my <st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" =
Month=3D"12"
Year=3D"1899" w:st=3D"on">2.6.14</st1:chsdate> tree, I type with =
</span></font><font
color=3Dblack face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-family:"Courier New";
color:black'>&#8220;</span></font><font color=3Dblack><span lang=3DEN-US
style=3D'color:black'>cg-log </span></font><font color=3Dblack =
face=3D"Courier New"><span
lang=3DEN-US style=3D'font-family:"Courier =
New";color:black'>&#8211;</span></font><font
color=3Dblack><span lang=3DEN-US =
style=3D'color:black'>s</span></font><font
color=3Dblack face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-family:"Courier New";
color:black'>&#8221;</span></font><font color=3Dblack><span lang=3DEN-US
style=3D'color:black'> command it shows:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"99" UnitName=3D"a" w:st=3D"on"><font =
size=3D1
 color=3Dblack face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:9.0pt;
 color:black'>99a</span></font></st1:chmetcnv><st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"21389"
UnitName=3D"C" w:st=3D"on"><font color=3Dblack><span lang=3DEN-US =
style=3D'color:black'>21389c</span></font></st1:chmetcnv><font
color=3Dblack><span lang=3DEN-US style=3D'color:black'>2b0e<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"55" UnitName=3D"F"
w:st=3D"on">55f</st1:chmetcnv>30b6cf6550cb492b87dbaa3b Heiko =
Schocher&nbsp;
2005-11-11 12:47 [PATCH]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc32: fix =
Kernel
Panic for PM82x Board with gcc-4.0.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>ff1df84b<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"3" =
UnitName=3D"C"
w:st=3D"on">3c</st1:chmetcnv>3154ffdb646941e<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"1" UnitName=3D"C" =
w:st=3D"on">1c</st1:chmetcnv>70d17554e3042
<st1:PersonName ProductID=3D"Wolfgang Denk" w:st=3D"on">Wolfgang =
Denk</st1:PersonName>&nbsp;&nbsp;
2005-11-10 00:41 Merge with =
/home/wd/git/linux-2.6/stefan_roese<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:7.5pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp; It only
shows <st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" =
Month=3D"12"
Year=3D"1899" w:st=3D"on">2.6.14</st1:chsdate> on the kernel message, I =
don</span></font><font
color=3Dblack face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-family:"Courier New";
color:black'>&#8217;</span></font><font color=3Dblack><span lang=3DEN-US
style=3D'color:black'>t know why it doesn</span></font><font =
color=3Dblack
face=3D"Courier New"><span lang=3DEN-US style=3D'font-family:"Courier =
New";
color:black'>&#8217;</span></font><font color=3Dblack><span lang=3DEN-US
style=3D'color:black'>t show the message as you =
told.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>But it can work, and =
fixed the
bugs on <st1:place =
w:st=3D"on">Yosemite</st1:place>.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:7.5pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:black'>Cordially,<o:p></o:p></span></font>=
</p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>Kylong =
Mu<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:7.5pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:7.5pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=


</div>

</body>

</html>

------=_NextPart_001_0006_01C5EAEA.EC64E810--

------=_NextPart_000_0005_01C5EAEA.EC64E810
Content-Type: text/plain;
	name="bootmessage(acard6280 pci-ide card).txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bootmessage(acard6280 pci-ide card).txt"

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
        00  0c  1191  0009  0180  00=0A=
In:    serial=0A=
Out:   serial=0A=
Err:   serial=0A=
Net:   ppc_4xx_eth0, ppc_4xx_eth1=0A=
=0A=
Type "run flash_nfs" to mount root filesystem over NFS=0A=
=0A=
Hit any key to stop autoboot:  0=0A=
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
         ###########################################=0A=
done=0A=
Bytes transferred =3D 1217393 (129371 hex)=0A=
=3D> bootram=0A=
Unknown command 'bootram' - try 'help'=0A=
=3D> run bootram=0A=
## Booting image at 00400000 ...=0A=
   Image Name:   Linux-2.6.14=0A=
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A=
   Data Size:    1217329 Bytes =3D  1.2 MB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A=
   Uncompressing Kernel Image ... OK=0A=
## Loading RAMDisk Image at fed40000 ...=0A=
   Image Name:   Yosemite Ramdisk=0A=
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)=0A=
   Data Size:    17770706 Bytes =3D 16.9 MB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A=
   Loading Ramdisk to 0ee47000, end 0ff398d2 ... OK=0A=
Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #7 Sun Nov 13 =
21:59:01 CST 2005=0A=
AMCC PowerPC 440EP Yosemite Platform=0A=
Built 1 zonelists=0A=
Kernel command line: ramdisk_size=3D49152 root=3D/dev/ram rw =
ip=3D192.168.0.66:192.168.0.93::255.255.255.0:yosemite:eth0:off =
panic=3D1 console=3DttyS0,115200=0A=
PID hash table entries: 2048 (order: 11, 32768 bytes)=0A=
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Memory: 239616k available (1860k kernel code, 596k data, 140k init, 0k =
highmem)=0A=
Mount-cache hash table entries: 512=0A=
checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd=0A=
softlockup thread 0 started up.=0A=
Freeing initrd memory: 17354k freed=0A=
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
RAMDISK driver initialized: 16 RAM disks of 49152K size 1024 blocksize=0A=
PPC 4xx OCP EMAC driver, version 3.53=0A=
mal0: initialized, 4 TX channels, 2 RX channels=0A=
zmii0: bridge in RMII mode=0A=
eth0: emac0, MAC 00:10:ec:00:87:40=0A=
eth0: found Generic MII PHY (0x01)=0A=
eth1: emac1, MAC 00:10:ec:00:87:47=0A=
eth1: found Generic MII PHY (0x03)=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
Data machine check in kernel mode.=0A=
PLB0: BEAR=3D0x0000000000000000 ACR=3D  0x00000000 BESR=3D 0xfffff7ff=0A=
POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000=0A=
OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000=0A=
Oops: machine check, sig: 7 [#1]=0A=
NIP: 00000000 LR: C0263628 SP: CFF41F40 REGS: c0271f50 TRAP: 0202    Not =
tainted=0A=
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00=0A=
TASK =3D c04f8b10[1] 'swapper' THREAD: cff40000=0A=
Last syscall: 120=0A=
GPR00: FDFFEF02 CFF41F40 C04F8B10 C04FC000 C026C6B4 C04FC000 00000009 =
CFF41EF4=0A=
GPR08: C04F9F70 00000000 00004000 C0270000 24254322 61000408 0FFB6800 =
00000001=0A=
GPR16: 00800000 0FFCEAD4 FFFFFFFF 00000000 007FFF00 0FFB1210 00000003 =
00000002=0A=
GPR24: C01D0000 C01D0000 C0270000 C01D0000 C0270000 C0223E10 C026C6B4 =
C04FC000=0A=
NIP [00000000] 0x0=0A=
LR [c0263628] aec62xx_init_one+0x38/0x48=0A=
Call trace:=0A=
 [c0263628] aec62xx_init_one+0x38/0x48=0A=
 [c02649b8] ide_scan_pcidev+0x68/0xb0=0A=
 [c0264a34] ide_scan_pcibus+0x34/0xe8=0A=
 [c026492c] ide_init+0x68/0x8c=0A=
 [c00013ac] init+0xb4/0x254=0A=
 [c00046c0] kernel_thread+0x48/0x64=0A=
Data machine check in kernel mode.=0A=
PLB0: BEAR=3D0x0000000000000000 ACR=3D  0x00000000 BESR=3D 0xfffff7ff=0A=
POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000=0A=
OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000=0A=
Oops: machine check, sig: 7 [#2]=0A=
NIP: 00000000 LR: C000235C SP: C0271E70 REGS: c0271f50 TRAP: 0202    Not =
tainted=0A=
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00=0A=
TASK =3D c04f8b10[1] 'swapper' THREAD: cff40000=0A=
Last syscall: 120=0A=
GPR00: 08000000 C0271E70 C04F8B10 C0271E80 00001568 FFFFFFFF C0270000 =
00004000=0A=
GPR08: C0270000 C000235C 00021002 C00039E8 C04F8CD8 61000408 0FFB6800 =
00000001=0A=
GPR16: 00800000 0FFCEAD4 FFFFFFFF 00000000 007FFF00 0FFB1210 00000003 =
00000002=0A=
GPR24: C01D0000 C01D0000 C0270000 C01D0000 C0270000 C0223E10 00000007 =
C0271F50=0A=
NIP [00000000] 0x0=0A=
LR [c000235c] ret_from_except+0x0/0x18=0A=
Kernel panic - not syncing: Attempted to kill init!=0A=
 <0>Rebooting in 1 seconds..=0A=
=0A=

------=_NextPart_000_0005_01C5EAEA.EC64E810--
