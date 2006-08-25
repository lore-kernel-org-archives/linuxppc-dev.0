Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4393A67C3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 18:59:17 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7P8xFaF007929 for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 01:59:15 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7P8xDYl001679
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 03:59:14 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6C824.BC468A25"
Subject: RE: pci_id_table and mid_idsel?
Date: Fri, 25 Aug 2006 16:59:11 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511B831@zch01exm21.fsl.freescale.net>
In-Reply-To: <20060825085643.47078.qmail@web36606.mail.mud.yahoo.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Parav Pandit" <paravpandit@yahoo.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6C824.BC468A25
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Parav,
=20
Please self study the existing source code. It can help you.
=20
-DAve


________________________________

	From: linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] On
Behalf Of Parav Pandit
	Sent: Friday, August 25, 2006 4:57 PM
	To: linuxppc-embedded@ozlabs.org
	Subject: pci_id_table and mid_idsel?
=09
=09
	Hi,
	=20
	Can someone please explain me pci_irq_table and how to select
the value of min_idsel , max_idsel for my 85xx boards?
	=20
	I am facing issues in registering the interrupt handler.
	=20
	On what basis we have to select the min_idsel and max_idsel
value??
	=20
	Currently common_swizzle function retuns slot number 11, if I
hard-code the value of 11 in the min_idsel and max_idsel because I have
only one slot, I am able to register the interrupt handler.
	=20
	PCI_SLOT in common_swizzle returns 11 because device function
number (devfn) has value of 88  ( I am wondering why 88 instead of from
0-7).
	(( 88>> 8) && 0x1f) =3D 11
	=20
	Since max functions we can have 8. (0-7). Why OS assign the
value of 88 inside?
	Configuration transaction uses only 3 bits of function number in
the CONFIG_ADDRESS as per PCI local bus specification 2.2.
	=20
	Regards,
	Parav Pandit
	=20

=09
________________________________

	All-new Yahoo! Mail
<http://us.rd.yahoo.com/evt=3D43256/*http://advision.webevents.yahoo.com/=
m
ailbeta> - Fire up a more powerful email and get things done faster.


------_=_NextPart_001_01C6C824.BC468A25
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D529215808-25082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Parav,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D529215808-25082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D529215808-25082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Please self study the existing source code. It =
can help=20
you.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D529215808-25082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D529215808-25082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>-DAve</FONT></SPAN></DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
  [mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] =
<B>On=20
  Behalf Of </B>Parav Pandit<BR><B>Sent:</B> Friday, August 25, 2006 =
4:57=20
  PM<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
pci_id_table=20
  and mid_idsel?<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV>Hi,</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Can someone please explain me pci_irq_table and how to select the =
value=20
  of min_idsel , max_idsel for my 85xx boards?</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>I am facing issues in registering the interrupt handler.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>On what basis we have to select the min_idsel and max_idsel =
value??</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Currently common_swizzle function retuns slot number 11, if I =
hard-code=20
  the value of 11 in the min_idsel and max_idsel because I have only one =
slot, I=20
  am able to register the interrupt handler.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>PCI_SLOT in common_swizzle returns 11 because device function =
number=20
  (devfn) has value of 88&nbsp; ( I am wondering why 88 instead of from=20
  0-7).</DIV>
  <DIV>(( 88&gt;&gt; 8) &amp;&amp; 0x1f) =3D 11</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Since max functions we can have 8. (0-7). Why OS assign the value =
of 88=20
  inside?</DIV>
  <DIV>Configuration transaction uses only 3 bits of function number in =
the=20
  CONFIG_ADDRESS as per PCI local bus specification 2.2.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Regards,</DIV>
  <DIV>Parav Pandit</DIV>
  <DIV>&nbsp;</DIV>
  <P>
  <HR SIZE=3D1>
  <A=20
  =
href=3D"http://us.rd.yahoo.com/evt=3D43256/*http://advision.webevents.yah=
oo.com/mailbeta">All-new=20
  Yahoo! Mail </A>- Fire up a more powerful email and get things done=20
faster.</BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6C824.BC468A25--
