Return-Path: <TMJohnson@fyldemicro.com>
Received: from fyldemicro.co.uk (www.fyldemicro.co.uk [213.48.132.32])
	by ozlabs.org (Postfix) with ESMTP id B9F4ADDE25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Nov 2008 19:37:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C94FA2.335D8045"
Subject: RE: SRAM
Date: Wed, 26 Nov 2008 08:37:20 -0000
Message-ID: <02296E583CC11C4D9365985B761F1DDE73619F@www.fyldemicro.co.uk>
In-Reply-To: <b5e2fc790811251145r396d4528m23e5743e2fef9142@mail.gmail.com>
References: <AclNmotrM/DrqMJlQRiP+5XNFUf3TA==>
	<02296E583CC11C4D9365985B761F1DDE73613B@www.fyldemicro.co.uk>
	<b5e2fc790811251145r396d4528m23e5743e2fef9142@mail.gmail.com>
From: "Thomas Johnson" <TMJohnson@fyldemicro.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C94FA2.335D8045
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Matt,
=20
Yes it's memory mapped.
=20
I will give it a spin.
=20
Regards
=20
Tom

________________________________

From: Matt Sealey [mailto:matt@genesi-usa.com]=20
Sent: 25 November 2008 19:45
To: Thomas Johnson
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: SRAM


Is it memory mapped somewhere? If it is you can emulate an MTD using the
"slram" driver.

Then you can just use whatever you like on top - JFFS2 or something that
thinks it's going to be on flash or something, ext2 if you're nuts. But,
seriously, with slram you *can* go nuts.


On Sun, Nov 23, 2008 at 12:37 PM, Thomas Johnson
<TMJohnson@fyldemicro.com> wrote:


	We have a new PPC based board which includes some SRAM (actually
Everspin MRAM).
	=20
	I can't work out the best way to mount this device or what
filing system to run on it, any advice ?
	=20
	Thanks=20
	=20
=09
	TJ

	_______________________________________________
	Linuxppc-embedded mailing list
	Linuxppc-embedded@ozlabs.org
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
=09




--=20
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations


------_=_NextPart_001_01C94FA2.335D8045
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16735" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Thanks Matt,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Yes it's memory mapped.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>I will give it a spin.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Regards</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D352243608-26112008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Tom</FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Matt Sealey =
[mailto:matt@genesi-usa.com]=20
<BR><B>Sent:</B> 25 November 2008 19:45<BR><B>To:</B> Thomas=20
Johnson<BR><B>Cc:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
Re:=20
SRAM<BR></FONT><BR></DIV>
<DIV></DIV>Is it memory mapped somewhere? If it is you can emulate an =
MTD using=20
the "slram" driver.<BR><BR>Then you can just use whatever you like on =
top -=20
JFFS2 or something that thinks it's going to be on flash or something, =
ext2 if=20
you're nuts. But, seriously, with slram you *can* go nuts.<BR><BR>
<DIV class=3Dgmail_quote>On Sun, Nov 23, 2008 at 12:37 PM, Thomas =
Johnson <SPAN=20
dir=3Dltr>&lt;<A=20
href=3D"mailto:TMJohnson@fyldemicro.com">TMJohnson@fyldemicro.com</A>&gt;=
</SPAN>=20
wrote:<BR>
<BLOCKQUOTE class=3Dgmail_quote=20
style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">
  <DIV>
  <DIV><SPAN><FONT face=3DArial size=3D2>We have a new PPC based board =
which=20
  includes&nbsp;some SRAM (actually Everspin MRAM).</FONT></SPAN></DIV>
  <DIV><SPAN><FONT face=3DArial size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV><SPAN><FONT face=3DArial size=3D2>I can't work out the best way =
to mount=20
  this&nbsp;device or what filing system to run on it, any advice=20
  ?</FONT></SPAN></DIV>
  <DIV><SPAN><FONT face=3DArial size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV><SPAN><FONT face=3DArial size=3D2>Thanks </FONT></SPAN></DIV>
  <DIV><SPAN><FONT face=3DArial size=3D2></FONT></SPAN>&nbsp;</DIV><FONT =

  color=3D#888888>
  <DIV><SPAN><FONT face=3DArial=20
  =
size=3D2>TJ</FONT></SPAN></DIV></FONT></DIV><BR>_________________________=
______________________<BR>Linuxppc-embedded=20
  mailing list<BR><A=20
  =
href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org=
</A><BR><A=20
  href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded"=20
  =
target=3D_blank>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A>=
<BR></BLOCKQUOTE></DIV><BR><BR=20
clear=3Dall><BR>-- <BR>Matt Sealey &lt;<A=20
href=3D"mailto:matt@genesi-usa.com">matt@genesi-usa.com</A>&gt;<BR>Genesi=
,=20
Manager, Developer Relations<BR></BODY></HTML>

------_=_NextPart_001_01C94FA2.335D8045--
