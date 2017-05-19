Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTltB1BRpzDqdg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 21:18:42 +1000 (AEST)
Date: Fri, 19 May 2017 13:18:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, mark.rutland@arm.com,
 devicetree@vger.kernel.org, trivial@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, paulus@samba.org,
 Andrew Morton <akpm@osdl.org>, jwboyer@linux.vnet.ibm.com,
 sr@denx.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/sequoia: fix NAND partitions not to overlap
Message-ID: <20170519111837.GB3940@amd>
References: <20170402100535.GA18340@amd> <20170517120613.GA583@amd>
 <20170517143717.ad818a2282378fc7a38af1ff@linux-foundation.org>
 <20170518094813.GA12038@amd>
 <87efvl75ts.fsf@concordia.ellerman.id.au>
 <87zie95fiq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
In-Reply-To: <87zie95fiq.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >>> >=20
> >>> > Ping? Two partitions at same place are bad news...
> >>>=20
> >>> Please expand on "bad news"?  What are the runtime effects of this
> >>> change?  Decisions about which kernel(s) to patch depend on this info.
> >>
> >> Well... two partitions at same place. If you use one, you will corrupt
> >> information on the other one.
> >>
> >> OTOH this moves partition around (so that they don't overlap) so it is
> >> probably not stable candidate.
> >>
> >> I guess this is not huge issue; people using these boards probably
> >> have custom dts changes, anyway...
> >
> > Or no one's even using it anymore.
> >
> > I can take this via powerpc, I won't mark it for stable etc.
>=20
> It became:
>=20
>     Author:     Pavel Machek <pavel@denx.de>
>=20
>     powerpc/sequoia: Fix NAND partitions not to overlap
>    =20
>     Currently the DTS defines two partitions at the same addresses, if you
>     use one, you will corrupt information on the other one. Fix it by
>     shifting the second partition.
>    =20
>     Signed-off-by: Pavel Machek <pavel@ucw.cz>
>     [mpe: Reconstruct change log from email thread]
>     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>=20
>=20
> Minor nit, your From: address doesn't match your Signed-off-by: address,
> which trips my "check patch is signed-off-by author" script. I can
> just ignore it, but I think it's preferable if they match.

Sorry about that (I have automatic scripts changing From:). It is
still me, but I guess denx should get the credit here, so you can use.

Signed-off-by: Pavel Machek <pavel@denx.de>

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlke1I0ACgkQMOfwapXb+vKlowCeIg/maTYewrDWFy3K3nNMIqAZ
crQAn2Ex/X+jLSb/b5PyYZYXS8O4fyae
=9dWT
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
