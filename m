Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 0242AB7BFA
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 23:50:24 +1000 (EST)
Date: Sat, 03 Oct 2009 15:50:12 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc/5200: make BestComm gen_bd microcode exchangeable
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20091003094417.GA24206@pengutronix.de> (from
	w.sang@pengutronix.de on Sat Oct  3 11:44:17 2009)
Message-Id: <1254577821.3331.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-4y3kjl6WMJKMWiWKYP1Q"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-4y3kjl6WMJKMWiWKYP1Q
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram:

Am 03.10.09 11:44 schrieb(en) Wolfram Sang:
> you wrote your own microcode? :)

I modified the bcom_gen_bd_rx_task for a LPB peripheral as to perform =20
Endianess swapping during the transfer (works meanwhile :-).   =20
Modifying the standard kernel code for testing seemed to be the wrong =20
approach for me, so I wrote that patch...

If possible, I would also like to have a crc32 calculation performed by =20
BestComm, but unfortunately there is no documentation and Freescale =20
doesn't give any support, so it's all trial and error and error and =20
error...  If you have any idea, pointers would be appreciated!

> approach looks ok to me in general, but this patch is line-wrapped.

I don't think so - the message body is a "format=3Dflowed" (RFC 3676) =20
text/plain part.  Maybe your MUA doesn't display that format correctly =20
(Outlook?)?  Or is '3676 in general not acceptable for patches?

[snip]
> spaces instead of tabs
[snip]
> Two empty lines.

Thanks - will submit a fixed patch next week, stay tuned...

Cheers, Albrecht.


P.S.: Did your mtd-ram/physmap_of patch you submitted a while ago make =20
it into the stock kernel?  I have some pending extra work (16-bit LPB =20
RAM access) building on top of it...

--=-4y3kjl6WMJKMWiWKYP1Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKx1acn/9unNAn/9ERAiRaAJ98shof5l2Wphll6qr6Asz7l13NGQCgrpC7
NBLtb0uamruBIUVTEC6zJuc=
=gnyn
-----END PGP SIGNATURE-----

--=-4y3kjl6WMJKMWiWKYP1Q--
