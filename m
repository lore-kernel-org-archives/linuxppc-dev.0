Return-Path: <srivatsan@deccanetworld.com>
Received: from gatekeeper.deccanetworld.com (unknown [202.56.251.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BB7E67B17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 19:25:08 +1000 (EST)
Received: from gatekeeper.deccanetworld.com (localhost [127.0.0.1])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id j3SA5m8V023160
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Apr 2005 15:35:49 +0530
Received: from mail.deccanetworld.com (server.deccanetworld.com [192.168.1.32])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id j3SA5fPq022697
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Apr 2005 15:35:46 +0530
Received: (from root@localhost)
	by mail.deccanetworld.com (8.11.0/8.11.0) id j3S9hAF15444
	for linuxppc-embedded@ozlabs.org; Thu, 28 Apr 2005 15:13:10 +0530
Received: from bgcw0089 ([10.203.105.18])by mail.deccanetworld.com
	(8.11.0/8.11.0) with ESMTP id j3S9h9f15356for
	<linuxppc-embedded@ozlabs.org>; Thu, 28 Apr 2005 15:13:09 +0530
From: "Srivatsan" <srivatsan@deccanetworld.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 28 Apr 2005 14:45:55 +0530
Message-ID: <000a01c54bd2$e25c91e0$1269cb0a@asia.ad.flextronics.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C54C00.FC19AFE0"
In-Reply-To: <20050428020004.1A7EF67B28@ozlabs.org>
Subject: DHCP problem 
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

------=_NextPart_000_000B_01C54C00.FC19AFE0
Content-Type: text/plain;charset="us-ascii"
Content-Transfer-Encoding: 7bit

 
Hi all,
 
    I am having a MPC8280 based Freescale evaluation board (A & M
rattler) running U-boot. It is successfully getting the ip address using
DHCP. (in Uboot).
 
When I am trying to boot the board with Linux, it continuously sends
DHCP request. The boot args which I am giving are:
 
bootargs=root=/dev/nfs nfsroot=10.203.105.123:/tftpboot/ppc_root ip=on
 
Linux Boot sequence problem at:
ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
Sending DHCP requests ...... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests ...... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests ...... timed out!
 
If bootargs is set as follows:
bootargs=root=/dev/nfs nfsroot=10.203.105.123:/tftpboot/ppc_root
ip=10.203.105.1
18:10.203.106.3:10.203.105.1:255.255.255.128:rattler:eth0:off
 
Linux boot sequence problem at:
IP-Config: Complete:
      device=eth0, addr=10.203.105.118, mask=255.255.255.128,
gw=10.203.105.1,
     host=rattler, domain=, nis-domain=(none),
     bootserver=10.203.106.3, rootserver=10.203.105.123, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.203.105.123
portmap: server 10.203.105.123 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 10.203.105.123
portmap: server 10.203.105.123 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
 
 
The system is not able to get the DNS domain name properly. Can anybody
tell me why is this happening? When I switched on ETHEREAL I am able to
see a DHCP discover packet corresponding to my targets MAC address. Any
pointers would be highly appreciated.
 
With Regards,
C.R.Srivatsan
 
 
 
 
 

***************************NOTE***********************************************
Deccanet Designs Ltd is now Flextronics Design Ltd, India
******************************************************************************



*************************DISCLAIMER*******************************************
This e-mail and any attachment is for authorised use by the intended
recipient(s) only. It may contain proprietary material, confidential
information and/or be subject to legal privilege of Flextronics Design Ltd.
If you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that
you are strictly prohibited from retaining, using, copying, altering or
disclosing the contents of this message.
******************************************************************************

------=_NextPart_000_000B_01C54C00.FC19AFE0
Content-Type: text/html;charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C54C00.D3918ED0">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
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
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";
	font-weight:bold;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";
	font-weight:bold;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Hi all,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>I am having a =
MPC8280 based
Freescale evaluation board (A &amp; M rattler) running U-boot. It is
successfully getting the ip address using DHCP. (in =
Uboot).<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>When I am trying to boot =
the
board with Linux, it continuously sends DHCP request. The boot args =
which I am
giving are:<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>bootargs=3Droot=3D/dev/nfs
nfsroot=3D10.203.105.123:/tftpboot/ppc_root =
ip=3Don<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Linux Boot sequence =
problem at:<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>ide: Assuming 50MHz system =
bus
speed for PIO modes; override with =
idebus=3Dxx<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>NET4: Linux TCP/IP 1.0 for =
NET4.0<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>IP Protocols: ICMP, UDP, =
TCP,
IGMP<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>IP: routing cache hash =
table of
512 buckets, 4Kbytes<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>TCP: Hash tables =
configured
(established 1024 bind 2048)<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Sending DHCP requests =
......
timed out!<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>IP-Config: Retrying =
forever (NFS
root)...<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Sending DHCP requests =
......
timed out!<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>IP-Config: Retrying =
forever (NFS
root)...<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Sending DHCP requests =
......
timed out!<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>If bootargs is set as =
follows:<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>bootargs=3Droot=3D/dev/nfs
nfsroot=3D10.203.105.123:/tftpboot/ppc_root =
ip=3D10.203.105.1<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>18:10.203.106.3:10.203.105.=
1:255.255.255.128:rattler:eth0:off<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Linux boot sequence =
problem at:<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>IP-Config: =
Complete:<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>device=3Deth0,
addr=3D10.203.105.118, mask=3D255.255.255.128, <span =
class=3DGramE>gw=3D</span>10.203.105.1,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span>host=3Drattler, domain=3D,
nis-domain<span =
class=3DGramE>=3D(</span>none),<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span =
class=3DSpellE><span
class=3DGramE>bootserver</span></span><span =
class=3DGramE>=3D</span>10.203.106.3, <span
class=3DSpellE>rootserver</span>=3D10.203.105.123, <span =
class=3DSpellE>rootpath</span>=3D<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>NET4: <span =
class=3DGramE>Unix</span>
domain sockets 1.0/SMP for Linux =
NET4.0.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Looking up =
</span></font></b><st1:place><st1:PlaceType><font
  color=3Dblack><span =
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:
  bold'>port</span></font></st1:PlaceType><font color=3Dblack><span
 style=3D'color:black;font-weight:normal;mso-bidi-font-weight:bold'> of =
</span></font><st1:PlaceName><font
  color=3Dblack><span =
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:
  bold'>RPC</span></font></st1:PlaceName></st1:place><font =
color=3Dblack><span
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:bold'> =
100003/2 on
10.203.105.123<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><span class=3DSpellE><span class=3DGramE><b =
style=3D'mso-ansi-font-weight:
normal'><font size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:
10.0pt;color:black;font-weight:normal;mso-bidi-font-weight:bold'>portmap<=
/span></font></b></span></span><font
color=3Dblack><span =
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:
bold'>: server 10.203.105.123 not responding, timed =
out<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Root-NFS: Unable to get =
<span
class=3DSpellE>nfsd</span> port number from server, using =
default<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Looking up =
</span></font></b><st1:place><st1:PlaceType><font
  color=3Dblack><span =
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:
  bold'>port</span></font></st1:PlaceType><font color=3Dblack><span
 style=3D'color:black;font-weight:normal;mso-bidi-font-weight:bold'> of =
</span></font><st1:PlaceName><font
  color=3Dblack><span =
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:
  bold'>RPC</span></font></st1:PlaceName></st1:place><font =
color=3Dblack><span
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:bold'> =
100005/1 on
10.203.105.123<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><span class=3DSpellE><span class=3DGramE><b =
style=3D'mso-ansi-font-weight:
normal'><font size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:
10.0pt;color:black;font-weight:normal;mso-bidi-font-weight:bold'>portmap<=
/span></font></b></span></span><font
color=3Dblack><span =
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:
bold'>: server 10.203.105.123 not responding, timed =
out<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Root-NFS: Unable to get =
<span
class=3DSpellE>mountd</span> port number from server, using =
default<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>The system is not able to =
get the
DNS domain name properly. Can anybody tell me why is this happening? =
When I
switched on ETHEREAL I am able to see a DHCP discover packet =
corresponding to
my targets MAC address. Any pointers would be highly =
appreciated.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>With =
Regards,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>C.R.</span></font></b><st1:=
PersonName><font
 color=3Dblack><span =
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:
 bold'>Srivatsan</span></font></st1:PersonName><font color=3Dblack><span
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:bold'><o:p><=
/o:p></span></font></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

</div>

<BR><PRE>
***************************NOTE***********************************************
Deccanet Designs Ltd is now Flextronics Design Ltd, India
******************************************************************************



*************************DISCLAIMER*******************************************
This e-mail and any attachment is for authorised use by the intended
recipient(s) only. It may contain proprietary material, confidential
information and/or be subject to legal privilege of Flextronics Design Ltd.
If you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that
you are strictly prohibited from retaining, using, copying, altering or
disclosing the contents of this message.
******************************************************************************
</pre><BR></body>

</html>

------=_NextPart_000_000B_01C54C00.FC19AFE0--
