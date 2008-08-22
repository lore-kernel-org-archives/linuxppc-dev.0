Return-Path: <fkan@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02-ext1.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 60E27DE041
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 01:46:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9046C.9610C681"
Subject: RE: [PATCH] AMCC PPC460GT/EX PCI-E de-emphasis adjustment fix
Date: Fri, 22 Aug 2008 08:33:52 -0700
Message-ID: <2B3B2AA816369A4E87D7BE63EC9D2F26049F7995@SDCEXCHANGE01.ad.amcc.com>
References: <1219380814-17229-1-git-send-email-fkan@amcc.com>
	<20080822133020.GE22283@yoda.jdub.homelinux.org>
From: "Feng Kan" <fkan@amcc.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: sr@denx.de, Tirumala Reddy Marri <tmarri@amcc.com>,
	linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C9046C.9610C681
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Feng Kan fkan@amcc.com

________________________________

From: Josh Boyer [mailto:jwboyer@gmail.com]
Sent: Fri 8/22/2008 6:30 AM
To: Feng Kan
Cc: linuxppc-embedded@ozlabs.org; Tirumala Reddy Marri; sr@denx.de
Subject: Re: [PATCH] AMCC PPC460GT/EX PCI-E de-emphasis adjustment fix



On Thu, Aug 21, 2008 at 09:53:34PM -0700, fkan@amcc.com wrote:
>From: Tirumala R Marri <tmarri@amcc.com>
>
>During recent tests with PCI-E , it has been found the
>DRV + De-Emphasis values are not optimum. These new values
>are tested thouroughly.
>
>Signed-off-by: Tirumala R Marri <tmarri@amcc.com>

If you are sending out a patch for someone, you need to include your
Signed-off-by as well.  Just reply to this with it, no need to resend
the just for this.

Stefan, this looks good to me.  Or at least as far as I can tell from
the somewhat magic values :)  Any comments?

josh



------_=_NextPart_001_01C9046C.9610C681
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH] AMCC PPC460GT/EX PCI-E =
de-emphasis adjustment fix</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.6000.16711" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText70825 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>Signed-off-by: Feng Kan <A =
href=3D"mailto:fkan@amcc.com">fkan@amcc.com</A></FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Josh Boyer =
[mailto:jwboyer@gmail.com]<BR><B>Sent:</B> Fri 8/22/2008 6:30 =
AM<BR><B>To:</B> Feng Kan<BR><B>Cc:</B> linuxppc-embedded@ozlabs.org; =
Tirumala Reddy Marri; sr@denx.de<BR><B>Subject:</B> Re: [PATCH] AMCC =
PPC460GT/EX PCI-E de-emphasis adjustment fix<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Thu, Aug 21, 2008 at 09:53:34PM -0700, =
fkan@amcc.com wrote:<BR>&gt;From: Tirumala R Marri =
&lt;tmarri@amcc.com&gt;<BR>&gt;<BR>&gt;During recent tests with PCI-E , =
it has been found the<BR>&gt;DRV + De-Emphasis values are not optimum. =
These new values<BR>&gt;are tested =
thouroughly.<BR>&gt;<BR>&gt;Signed-off-by: Tirumala R Marri =
&lt;tmarri@amcc.com&gt;<BR><BR>If you are sending out a patch for =
someone, you need to include your<BR>Signed-off-by as well.&nbsp; Just =
reply to this with it, no need to resend<BR>the just for =
this.<BR><BR>Stefan, this looks good to me.&nbsp; Or at least as far as =
I can tell from<BR>the somewhat magic values :)&nbsp; Any =
comments?<BR><BR>josh<BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C9046C.9610C681--
