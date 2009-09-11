Return-Path: <pbathija@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 07A47B6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 19:27:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA32C2.20FB9606"
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Fri, 11 Sep 2009 02:23:37 -0700
Message-ID: <9D1E2BDCB5C57B46B56E6D80843439EB0580C929@SDCEXCHANGE01.ad.amcc.com>
References: <1251926572.10090.17.camel@Adam> <200909110712.11858.sr@denx.de>
	<1252646270.8566.64.camel@pasglop> <200909110725.36208.sr@denx.de>
	<9D1E2BDCB5C57B46B56E6D80843439EB0580C926@SDCEXCHANGE01.ad.amcc.com>
	<1252647621.8566.67.camel@pasglop>
From: "Pravin Bathija" <pbathija@amcc.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: Andrea Zypchen <azypchen@intldata.ca>, lebon@lebon.org.ua,
	Prodyut Hazarika <phazarika@amcc.com>, tburns@datacast.com,
	Stefan Roese <sr@denx.de>, linuxppc-dev@lists.ozlabs.org,
	azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA32C2.20FB9606
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt wrote:
> Do you know many drivers that do config space accesses without using
> the config space accessors ?

> Such drivers should be banned to oblivion.

> Cheers,
> Ben.

I'm not aware of such drivers in the 2.6.30+ kernel.
=20
Thanks,
Pravin

On Thu, 2009-09-10 at 22:35 -0700, Pravin Bathija wrote:
> Thanks Stefan. The whole intention of the patch/hack (or whatever one
> might call it :) ) was to avoid rogue drivers from setting
> pci_cache_line_size to non-zero value even though the underlying
> hardware doesn't support MRM calls. Nonetheless this approach works
> only if the drivers use the kernel API for PCI config space access
> provided by the powerpc platform driver.
>




------_=_NextPart_001_01CA32C2.20FB9606
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>RE: AW: PowerPC PCI DMA issues =
(prefetch/coherency?)</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3527" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText94079 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2><FONT =
face=3D"Times New Roman">Benjamin Herrenschmidt =
wrote:</FONT></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2><FONT =
face=3D"Times New Roman">&gt; Do you know many drivers that do config =
space accesses without using<BR>&gt; the config space accessors =
?<BR><BR>&gt; Such drivers should be banned to oblivion.<BR><BR>&gt; =
Cheers,<BR>&gt; Ben.</FONT><BR></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>I'm not aware =
of such drivers in the 2.6.30+ kernel.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Pravin</FONT></DIV></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Thu, 2009-09-10 at 22:35 -0700, Pravin Bathija =
wrote:<BR>&gt; Thanks Stefan. The whole intention of the patch/hack (or =
whatever one<BR>&gt; might call it :) ) was to avoid rogue drivers from =
setting<BR>&gt; pci_cache_line_size to non-zero value even though the =
underlying<BR>&gt; hardware doesn't support MRM calls. Nonetheless this =
approach works<BR>&gt; only if the drivers use the kernel API for PCI =
config space access<BR>&gt; provided by the powerpc platform =
driver.<BR>&gt;<BR><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01CA32C2.20FB9606--
