Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTj4G59yTzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 19:12:13 +1000 (AEST)
Date: Fri, 19 May 2017 11:12:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, sr@denx.de,
 jwboyer@linux.vnet.ibm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, trivial@kernel.org,
 Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] powerpc/sequoia: fix NAND partitions not to overlap
Message-ID: <20170519091207.GA3940@amd>
References: <20170402100535.GA18340@amd> <20170517120613.GA583@amd>
 <20170517143717.ad818a2282378fc7a38af1ff@linux-foundation.org>
 <20170518094813.GA12038@amd>
 <87efvl75ts.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <87efvl75ts.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Well... two partitions at same place. If you use one, you will corrupt
> > information on the other one.
> >
> > OTOH this moves partition around (so that they don't overlap) so it is
> > probably not stable candidate.
> >
> > I guess this is not huge issue; people using these boards probably
> > have custom dts changes, anyway...
>=20
> Or no one's even using it anymore.
>=20
> I can take this via powerpc, I won't mark it for stable etc.

That sounds good.

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlketucACgkQMOfwapXb+vJh2QCeKtRi+wgeu2f1BTH9CuKl/dR+
sHgAnjwnjHwNjaA0rIcsScDu2Pt8DClS
=RWEx
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
