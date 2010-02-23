Return-Path: <fkan@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BB937B7CEC
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 16:21:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAB448.1BFB95C9"
Subject: RE: [PATCH 1/1] NDFC: add support for alternate ECC format for ndfc
Date: Mon, 22 Feb 2010 21:21:53 -0800
Message-ID: <2B3B2AA816369A4E87D7BE63EC9D2F260615A5F2@SDCEXCHANGE01.ad.amcc.com>
References: <1266534678-30293-1-git-send-email-fkan@amcc.com>
	<20100220201155.27744439@opus.seanm.ca>
From: "Feng Kan" <fkan@amcc.com>
To: "Sean MacLennan" <smaclennan@pikatech.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CAB448.1BFB95C9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Sean:
=20
I will withdraw this patch. I had a talk with the U-Boot guys. The =
reason for this
patch was to support those guys that had their ECC ordering at (213) on =
the older
version of the kernel. Upgrading to (123) may be problematic. Since =
without a jtag
it would be a bit complex.=20
=20
I still think this NAND_ECC_SMC define is somewhat missleading. Given =
that
both 1-2-3 and 2-1-3 are supported by the correction routine.
Feng

________________________________

From: Sean MacLennan [mailto:smaclennan@pikatech.com]
Sent: Sat 2/20/2010 5:11 PM
To: Feng Kan
Cc: linux-mtd@lists.infradead.org; linuxppc-dev@ozlabs.org; Feng Kan
Subject: Re: [PATCH 1/1] NDFC: add support for alternate ECC format for =
ndfc



On Thu, 18 Feb 2010 15:11:18 -0800
Feng Kan <fkan@amcc.com> wrote:

> This is to lock down the ordering in the correction routine against
> the calculate routine. Otherwise, incorrect define would cause ECC
> errors.

Did you actually find a 44x PPC core that is not NAND_ECC_SMS format?

Cheers,
   Sean



------_=_NextPart_001_01CAB448.1BFB95C9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH 1/1] NDFC: add support for =
alternate ECC format for ndfc</TITLE>=0A=
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Type>=0A=
<META name=3DGENERATOR content=3D"MSHTML 8.00.7600.16490"></HEAD>=0A=
<BODY>=0A=
<DIV dir=3Dltr id=3DidOWAReplyText17815>=0A=
<DIV dir=3Dltr><FONT color=3D#000000 size=3D2 face=3DArial>Hi =
Sean:</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial>I will withdraw this patch. I =
had a talk with the U-Boot guys. The reason for this</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial>patch was to support those =
guys that had their ECC ordering at (213) on the older</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial>version of the kernel. =
Upgrading to (123) may be problematic. Since without a jtag</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial>it would be a bit complex. =
</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial>I still think this =
NAND_ECC_SMC define is somewhat missleading. Given that</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial>both 1-2-3 and 2-1-3 are =
supported by the correction routine.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2 face=3DArial>Feng</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT size=3D2 face=3DTahoma><B>From:</B> Sean MacLennan =
[mailto:smaclennan@pikatech.com]<BR><B>Sent:</B> Sat 2/20/2010 5:11 =
PM<BR><B>To:</B> Feng Kan<BR><B>Cc:</B> linux-mtd@lists.infradead.org; =
linuxppc-dev@ozlabs.org; Feng Kan<BR><B>Subject:</B> Re: [PATCH 1/1] =
NDFC: add support for alternate ECC format for ndfc<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Thu, 18 Feb 2010 15:11:18 -0800<BR>Feng Kan =
&lt;fkan@amcc.com&gt; wrote:<BR><BR>&gt; This is to lock down the =
ordering in the correction routine against<BR>&gt; the calculate =
routine. Otherwise, incorrect define would cause ECC<BR>&gt; =
errors.<BR><BR>Did you actually find a 44x PPC core that is not =
NAND_ECC_SMS format?<BR><BR>Cheers,<BR>&nbsp;&nbsp; =
Sean<BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01CAB448.1BFB95C9--
