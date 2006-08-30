Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7BB9167B75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 16:31:50 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7U6i71h024488 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 23:44:07 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7U6VkhS003456
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 01:31:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CBFD.F71C4991"
Subject: RE: How to turn off MMU in MPC8540
Date: Wed, 30 Aug 2006 14:31:46 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BBDD@zch01exm21.fsl.freescale.net>
In-Reply-To: <405ECA8A30557F439A723E52D50838F9D8295F@ZMY16EXM66.ds.mot.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Reddy Suneel-ASR125" <suneel.reddy@motorola.com>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6CBFD.F71C4991
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Turn off MMU of e500? hmmm...
Do you want to get real address space?
You can emulate this.
=20
-DAve


________________________________

	From: linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] On
Behalf Of Reddy Suneel-ASR125
	Sent: Wednesday, August 30, 2006 2:25 PM
	To: linuxppc-embedded@ozlabs.org
	Subject: How to turn off MMU in MPC8540
=09
=09
	Hi
	=20
	Can anyone know how to turn off MMU in MPC8540?
	=20
	Thanks&regards
	Suneel


------_=_NextPart_001_01C6CBFD.F71C4991
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D315152806-30082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Turn off MMU of e500? =
hmmm...</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D315152806-30082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Do you want to get real address =
space?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D315152806-30082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>You can emulate this.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D315152806-30082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D315152806-30082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>-DAve</FONT></SPAN></DIV><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
  [mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] =
<B>On=20
  Behalf Of </B>Reddy Suneel-ASR125<BR><B>Sent:</B> Wednesday, August =
30, 2006=20
  2:25 PM<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
How to=20
  turn off MMU in MPC8540<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV><SPAN class=3D899372306-30082006><FONT face=3DArial=20
  size=3D2>Hi</FONT></SPAN></DIV>
  <DIV><SPAN class=3D899372306-30082006><FONT face=3DArial=20
  size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV><SPAN class=3D899372306-30082006><FONT face=3DArial size=3D2>Can =
anyone know=20
  how to turn off MMU in MPC8540?</FONT></SPAN></DIV>
  <DIV><SPAN class=3D899372306-30082006><FONT face=3DArial=20
  size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV><SPAN class=3D899372306-30082006><FONT face=3DArial=20
  size=3D2>Thanks&amp;regards</FONT></SPAN></DIV>
  <DIV><SPAN class=3D899372306-30082006><FONT face=3DArial=20
  size=3D2>Suneel</FONT></SPAN></DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6CBFD.F71C4991--
