Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (itri.bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id 3159DDDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Sep 2008 15:20:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91F97.A5CE803C"
Subject: Linux Init Hangs
Date: Fri, 26 Sep 2008 08:20:53 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F07DD412C@itri.bte.mam.gov.tr>
From: =?iso-8859-9?Q?Mustafa_Cay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C91F97.A5CE803C
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

my kernel hangs by initializing the system. My target is mpc7457-based. =
I use ELDK 3.1.1 and mount my root-fs over nfs.

=20

Following is screen-shot:   =20

....

NET: Registered protocol family 1

NET: Registered protocol family 17

egiga0: link down

IP-Config: Complete:

      device=3Degiga0, addr=3D10.18.6.129, mask=3D255.255.0.0, =
gw=3D255.255.255.255,

     host=3Dgomsis, domain=3D, nis-domain=3D(none),

     bootserver=3D10.18.6.232, rootserver=3D10.18.6.232, rootpath=3D =
Looking up port of RPC 100003/2 on 10.18.6.232

egiga0: link up<5>, full duplex<5>, speed 100 Mbps<5> Looking up port of =
RPC 100005/1 on 10.18.6.232

VFS: Mounted root (nfs filesystem).

Mounted devfs on /dev

Freeing unused kernel memory: 112k init

=20

Hangs here !

=20

=20

I use ethereal to look at  the  network  traffic. Find out what the last =
succesful lookup calls:=20

=20

Network File System, LOOKUP Call DH:0x500ec3bb/ld-2.3.1.so Network File =
System, LOOKUP Call DH:0x500ec3bb/ld.so.1 Network File System, LOOKUP =
Call DH:0x2c97820b/lib Network File System, LOOKUP Call =
DH:0x500ec3bb/init Network File System, LOOKUP Call DH:0x2c97820b/sbin =
Network File System, LOOKUP Call DH:0x2c97820b/dev

5853  14.129760   10.18.6.135 10.18.6.232 MOUNT V1 MNT Call =
/opt/eldk_7457/ppc_74xx

=20

After printing the message "Freeing unused kernel memory: 112k init", it =
hangs Any ideas?

=20

Thanks in advance

=20

Mustafa


------_=_NextPart_001_01C91F97.A5CE803C
Content-Type: text/html;
	charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-9">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Courier New TUR";
	panose-1:2 7 3 9 2 2 5 2 4 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
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

<body lang=3DTR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>my
kernel hangs by initializing the system. My target is mpc7457-based. I =
use ELDK
3.1.1 and mount my root-fs over nfs.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>Following
is screen-shot:=A0=A0=A0 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'>....<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>NET:
Registered protocol family 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>NET:
Registered protocol family 17<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>egiga0:
link down<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>IP-Config:
Complete:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>=A0=A0=A0=A0=A0
device=3Degiga0, addr=3D10.18.6.129, mask=3D255.255.0.0, =
gw=3D255.255.255.255,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>=A0=A0=A0=A0
host=3Dgomsis, domain=3D, =
nis-domain=3D(none),<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>=A0=A0=A0=A0
bootserver=3D10.18.6.232, rootserver=3D10.18.6.232, rootpath=3D Looking =
up port of
RPC 100003/2 on 10.18.6.232<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>egiga0:
link up&lt;5&gt;, full duplex&lt;5&gt;, speed 100 Mbps&lt;5&gt; Looking =
up port
of RPC 100005/1 on 10.18.6.232<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>VFS:
Mounted root (nfs filesystem).<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>Mounted
devfs on /dev<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>Freeing
unused kernel memory: 112k init<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>Hangs
here !<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>I
use ethereal to look at=A0 the=A0 network=A0 traffic. Find out what the =
last
succesful lookup calls: <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>Network
File System, LOOKUP Call DH:0x500ec3bb/ld-2.3.1.so Network File System, =
LOOKUP
Call DH:0x500ec3bb/ld.so.1 Network File System, LOOKUP Call =
DH:0x2c97820b/lib
Network File System, LOOKUP Call DH:0x500ec3bb/init Network File System, =
LOOKUP
Call DH:0x2c97820b/sbin Network File System, LOOKUP Call =
DH:0x2c97820b/dev<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>5853=A0 =
14.129760=A0=A0 10.18.6.135 10.18.6.232 MOUNT V1
MNT Call /opt/eldk_7457/ppc_74xx<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>After
printing the message &quot;Freeing unused kernel memory: 112k =
init&quot;, it
hangs Any ideas?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New TUR"'>Thanks
in advance<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Courier New TUR"><span =
style=3D'font-size:10.0pt;font-family:"Courier New =
TUR"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New TUR"><span =
style=3D'font-size:
10.0pt;font-family:"Courier New TUR"'>Mustafa</span></font><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_001_01C91F97.A5CE803C--
