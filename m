Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0A6CB6FA6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Sep 2011 22:33:32 +1000 (EST)
Date: Fri, 9 Sep 2011 14:33:24 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Message-ID: <20110909123324.GQ1912@pengutronix.de>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
	<20110909114004.GP1912@pengutronix.de>
	<2239AC579C7D3646A720227A37E026811A22BD@039-SN1MPN1-005.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="glwmnIOgU1tcuP7N"
In-Reply-To: <2239AC579C7D3646A720227A37E026811A22BD@039-SN1MPN1-005.039d.mgd.msft.net>
Cc: Xu Lei-B33228 <B33228@freescale.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"cjb@laptop.org" <cjb@laptop.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--glwmnIOgU1tcuP7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2011 at 12:23:05PM +0000, Zang Roy-R61911 wrote:

> > > Freescale eSDHC registers only support 32-bit accesses,
> > > this patch ensures that all Freescale eSDHC register accesses
> > > are 32-bit.
> >=20
> > So, what about the byte-swapping that Anton needed? You are simply
> > removing that if I am not mistaken.
> I do not see any comment for this patch from Anton.

Maybe he is busy?

> You may miss the patch. Please confirm.

I don't understand, what needs to be confirmed? I am simply wondering
what happens to the byteswapping that Anton (back then) intentionally
implemented.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--glwmnIOgU1tcuP7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5qB5QACgkQD27XaX1/VRt1EgCgvPlM0RMhNf79EG6GbVp5HZAt
F7YAnj7UhssZdtEXp6sPSRcie6E7XNFi
=qeEA
-----END PGP SIGNATURE-----

--glwmnIOgU1tcuP7N--
