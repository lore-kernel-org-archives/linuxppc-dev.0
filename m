Return-Path: <Phil.Mathews@innocon.com>
Received: from mail.innocon.com (mail.innocon.com [12.109.49.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2860167E23
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Sep 2006 05:04:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DE79.F2E3A987"
Subject: RE: Unable to mount jffs2
Date: Fri, 22 Sep 2006 15:04:37 -0400
Message-ID: <3E8081396F6B524BA2854E7FA3F16438042EB67A@mail.innocon.com>
From: "Mathews, Phil" <Phil.Mathews@innocon.com>
To: "Mathews, Phil" <Phil.Mathews@innocon.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C6DE79.F2E3A987
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Problem solved:  I had enabled "Support for ROM chips in bus mapping
(MTD_ROM)" in xconfig and CFI was giving up early while scanning for my
flash.  Unchecking this option solved the problem.  Perhaps there needs
to be a warning about this somewhere in the documentation, or is this a
bug? (2.6.15 kernel on a MPC8272ADS board)


________________________________

	From:
linuxppc-embedded-bounces+phil.mathews=3Dinnocon.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+phil.mathews=3Dinnocon.com@ozlabs.org]
On Behalf Of Mathews, Phil
	Sent: Wednesday, September 20, 2006 11:55 AM
	To: Wolfgang Denk=20
	Cc: linuxppc-embedded@ozlabs.org
	Subject: Unable to mount jffs2
=09
=09

	See attachment
=09
	--  Phil Mathews=20
	    Innovative Concepts, Inc.
	    8200 Greensboro Dr., Suite 700
	    McLean, VA 22102
	    703-893-2007 x478
	    phil.mathews@innocon.com  =20
=09
=09


------_=_NextPart_001_01C6DE79.F2E3A987
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Unable to mount jffs2</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D702395918-22092006>Problem solved:&nbsp; I had enabled <FONT=20
size=3D2>"Support for ROM chips in bus mapping (MTD_ROM)" in xconfig and =
CFI was=20
giving up early while scanning for my flash.&nbsp; Unchecking this =
option solved=20
the problem.&nbsp; Perhaps there needs to be a warning about this =
somewhere in=20
the documentation, or is&nbsp;this a bug? (2.6.15 kernel on a MPC8272ADS =

board)</FONT></SPAN></FONT></DIV><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  </DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><FONT=20
  face=3DTahoma><FONT size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+phil.mathews=3Dinnocon.com@ozlabs.org=20
  =
[mailto:linuxppc-embedded-bounces+phil.mathews=3Dinnocon.com@ozlabs.org] =
<B>On=20
  Behalf Of </B>Mathews, Phil<BR><B>Sent:</B> Wednesday, September 20, =
2006=20
  11:55 AM<BR><B>To:</B> Wolfgang Denk<SPAN =
class=3D702395918-22092006><FONT=20
  face=3DArial color=3D#0000ff>&nbsp;</FONT></SPAN></FONT></FONT></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><FONT=20
  face=3DTahoma><FONT size=3D2><B>Cc:</B>=20
  linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Unable to mount=20
  jffs2<BR></FONT></FONT><BR></DIV>
  <DIV></DIV><!-- Converted from text/plain format -->
  <P><FONT size=3D2>See attachment<BR><BR>--&nbsp; Phil=20
  Mathews&nbsp;<BR>&nbsp;&nbsp;&nbsp; Innovative Concepts,=20
  Inc.<BR>&nbsp;&nbsp;&nbsp; 8200 Greensboro Dr., Suite=20
  700<BR>&nbsp;&nbsp;&nbsp; McLean, VA 22102<BR>&nbsp;&nbsp;&nbsp; =
703-893-2007=20
  x478<BR>&nbsp;&nbsp;&nbsp;=20
  =
phil.mathews@innocon.com&nbsp;&nbsp;&nbsp;<BR><BR></FONT></P></BLOCKQUOTE=
></BODY></HTML>

------_=_NextPart_001_01C6DE79.F2E3A987--
