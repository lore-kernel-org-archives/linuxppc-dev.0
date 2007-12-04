Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 38B92DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 16:31:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83636.F637172F"
Subject: RE: [PATCH] [POWERPC] [v2] Improved documentation of device
	tree'ranges'.
Date: Mon, 3 Dec 2007 21:27:08 -0800
References: <20071204010818.AD4231798062@mail212-sin.bigfish.com>
	<20071204024025.GG32577@localhost.localdomain>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Message-Id: <20071204053148.C2FBCF00059@mail199-blu.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83636.F637172F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I'm actually a little embarrassed that I didn't pick that nit myself.. =
:)

-----Original Message-----
From: David Gibson [mailto:david@gibson.dropbear.id.au]
Sent: Mon 12/3/2007 6:40 PM
To: Stephen Neuendorffer
Cc: grant.likely@secretlab.ca; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] [v2] Improved documentation of device =
tree'ranges'.
=20

On Mon, Dec 03, 2007 at 05:08:57PM -0800, Stephen Neuendorffer wrote:
> I was misled by the prior language.  I've attempted to clarify how
> 'ranges' are used, in particular, how to get an identity mapping.
>=20
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Thanks for the update.  I particularly dislike the "1:1" terminology,
because in maths-speak *any* ranges translation is 1:1, unless it
includes overlapping ranges.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ =
_other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson



------_=_NextPart_001_01C83636.F637172F
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: [PATCH] [POWERPC] [v2] Improved documentation of device =
tree'ranges'.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I'm actually a little embarrassed that I didn't pick =
that nit myself.. :)<BR>
<BR>
-----Original Message-----<BR>
From: David Gibson [<A =
HREF=3D"mailto:david@gibson.dropbear.id.au">mailto:david@gibson.dropbear.=
id.au</A>]<BR>
Sent: Mon 12/3/2007 6:40 PM<BR>
To: Stephen Neuendorffer<BR>
Cc: grant.likely@secretlab.ca; linuxppc-dev@ozlabs.org<BR>
Subject: Re: [PATCH] [POWERPC] [v2] Improved documentation of device =
tree'ranges'.<BR>
<BR>
<BR>
On Mon, Dec 03, 2007 at 05:08:57PM -0800, Stephen Neuendorffer =
wrote:<BR>
&gt; I was misled by the prior language.&nbsp; I've attempted to clarify =
how<BR>
&gt; 'ranges' are used, in particular, how to get an identity =
mapping.<BR>
&gt;<BR>
&gt; Signed-off-by: Stephen Neuendorffer =
&lt;stephen.neuendorffer@xilinx.com&gt;<BR>
<BR>
Acked-by: David Gibson &lt;david@gibson.dropbear.id.au&gt;<BR>
<BR>
Thanks for the update.&nbsp; I particularly dislike the &quot;1:1&quot; =
terminology,<BR>
because in maths-speak *any* ranges translation is 1:1, unless it<BR>
includes overlapping ranges.<BR>
<BR>
--<BR>
David Gibson&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | I'll have my music baroque, =
and my code<BR>
david AT gibson.dropbear.id.au&nbsp; | minimalist, thank you.&nbsp; NOT =
_the_ _other_<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | _way_ _around_!<BR>
<A =
HREF=3D"http://www.ozlabs.org/~dgibson">http://www.ozlabs.org/~dgibson</A=
><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C83636.F637172F--
