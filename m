Return-Path: <bantonovici@priority.mb.ca>
Message-ID: <00ca01c599f1$a2411730$cd01a8c0@DESIGNLAB>
From: "Bogdan Antonovici" <bantonovici@priority.mb.ca>
To: "Dan Malek" <dan@embeddededge.com>
References: <1121959795.800.18.camel@rd-lab>
	<1a928a85f53f5dcd972161356611a312@embeddededge.com>
Date: Fri, 5 Aug 2005 14:12:33 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00C7_01C599C7.B94E8680"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, ppckernel <ppckernel@ppckernel.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: swap_dup: Bad swap file entry 00480020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_00C7_01C599C7.B94E8680
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dan,

It hasn't crashed since i corrected that pointer initialization in =
driver. You were right.
Thank you.
Bogdan
  ----- Original Message -----=20
  From: Dan Malek=20
  To: bogdan antonovici=20
  Cc: linuxppc-dev ; linuxppc-embedded@ozlabs.org ; ppckernel=20
  Sent: Thursday, July 21, 2005 12:59 PM
  Subject: Re: swap_dup: Bad swap file entry 00480020



  On Jul 21, 2005, at 11:29 AM, bogdan antonovici wrote:

  > At the time of swap messages i was running a proprietary driver, my
  > application and few daemons.

  Looks like your driver may have written over some of the page
  tables in the kernel space.

  > I look on the net for some clues but it's quite confusing, i noticed
  > many emails on swap_dup/swap_free error messages but i couldn't =
figure
  > out what should i search for.

  Those messages are likely due to a bug with swapping to disk
  that has been in some 2.4 kernels, but I don't believe that is
  the case here, since you don't have a disk or swapping enabled.


  -- Dan


------=_NextPart_000_00C7_01C599C7.B94E8680
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2745.2800" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Dan,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>It hasn't crashed since i corrected =
that pointer=20
initialization in driver. You were right.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Thank you.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Bogdan</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Ddan@embeddededge.com =
href=3D"mailto:dan@embeddededge.com">Dan Malek</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dbantonovici@priority.mb.ca=20
  href=3D"mailto:bantonovici@priority.mb.ca">bogdan antonovici</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A =
title=3Dlinuxppc-dev@ozlabs.org=20
  href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev</A> ; <A=20
  title=3Dlinuxppc-embedded@ozlabs.org=20
  =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org=
</A> ;=20
  <A title=3Dppckernel@ppckernel.org=20
  href=3D"mailto:ppckernel@ppckernel.org">ppckernel</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Thursday, July 21, 2005 =
12:59=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: swap_dup: Bad swap =
file=20
  entry 00480020</DIV>
  <DIV><BR></DIV><BR>On Jul 21, 2005, at 11:29 AM, bogdan antonovici=20
  wrote:<BR><BR>&gt; At the time of swap messages i was running a =
proprietary=20
  driver, my<BR>&gt; application and few daemons.<BR><BR>Looks like your =
driver=20
  may have written over some of the page<BR>tables in the kernel=20
  space.<BR><BR>&gt; I look on the net for some clues but it's quite =
confusing,=20
  i noticed<BR>&gt; many emails on swap_dup/swap_free error messages but =
i=20
  couldn't figure<BR>&gt; out what should i search for.<BR><BR>Those =
messages=20
  are likely due to a bug with swapping to disk<BR>that has been in some =
2.4=20
  kernels, but I don't believe that is<BR>the case here, since you don't =
have a=20
  disk or swapping enabled.<BR><BR><BR>-- =
Dan<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_00C7_01C599C7.B94E8680--
