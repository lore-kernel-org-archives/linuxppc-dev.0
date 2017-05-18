Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT5wM0Qq6zDqZR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 19:48:18 +1000 (AEST)
Date: Thu, 18 May 2017 11:48:13 +0200
From: Pavel Machek <pavel@denx.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sr@denx.de, jwboyer@linux.vnet.ibm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 trivial@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] powerpc/sequoia: fix NAND partitions not to overlap
Message-ID: <20170518094813.GA12038@amd>
References: <20170402100535.GA18340@amd> <20170517120613.GA583@amd>
 <20170517143717.ad818a2282378fc7a38af1ff@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
In-Reply-To: <20170517143717.ad818a2282378fc7a38af1ff@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-05-17 14:37:17, Andrew Morton wrote:
> On Wed, 17 May 2017 14:06:13 +0200 Pavel Machek <pavel@denx.de> wrote:
>=20
> > On Sun 2017-04-02 12:05:36, Pavel Machek wrote:
> > > Fix overlapping NAND partitions.
> > >=20
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > Ping? Two partitions at same place are bad news...
>=20
> Please expand on "bad news"?  What are the runtime effects of this
> change?  Decisions about which kernel(s) to patch depend on this info.

Well... two partitions at same place. If you use one, you will corrupt
information on the other one.

OTOH this moves partition around (so that they don't overlap) so it is
probably not stable candidate.

I guess this is not huge issue; people using these boards probably
have custom dts changes, anyway...

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkdbd0ACgkQMOfwapXb+vKSwgCdEH0np4PeA0yHxMf1KJy8HJ7I
fE8AoKN4cfbkO+bYmOOzY/msQyboWBPW
=p+oE
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
