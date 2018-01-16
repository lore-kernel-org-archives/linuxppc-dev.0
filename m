Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLHtT0zPkzF0TR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 15:53:53 +1100 (AEDT)
Date: Tue, 16 Jan 2018 15:53:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 "Tobin C. Harding" <me@tobin.cc>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: include linux/types.h in asm/hvcall.h
Message-ID: <20180116045347.GC30352@umbus.fritz.box>
References: <20180115133003.3447-1-msuchanek@suse.de>
 <87wp0ia3x1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
In-Reply-To: <87wp0ia3x1.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 02:16:58PM +1100, Michael Ellerman wrote:
> Michal Suchanek <msuchanek@suse.de> writes:
>=20
> > Commit 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
> > settings") uses u64 in asm/hvcall.h without including linux/types.h
> >
> > This breaks hvcall.h users that do not include the header themselves.
> >
> > Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
> >     settings")
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  arch/powerpc/include/asm/hvcall.h | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> Thanks. None of my ~250 defconfig test builds hit this, what config are
> you using?

I also hit this, but only when I backported the change to RH's 3.10
kernel.  I assumed something since then had added an indirect include.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpdhVgACgkQbDjKyiDZ
s5KqAg/+P8wx2xAgvydHMrfHQR67hwejhtnyLgonYe5tiVBQXN4/XOUFP4rDCClP
OVF/OcPl2oQz6hRGoZaz6YZvoq3zzpL/Glxa5Z2+tE4RRXvzy8zAGrJz1GxXmUli
LS22iO7Y+Bnkj2y89q98j0yJjboFm3rlyuto8uoeWdQhIKj+KwL+Z4n/wgwH6/sO
Q0xpvus1FKIbDP9QqjRe+te+mdMOmGgHpI3NWr0gk1Qzs8J+KDiBNXo7leE8k2Vh
qAKxRGA8c+iWDqltOYk2iC6yr/8o1nuBVIjd+icLQ0cChHsxsQZnzj9D3dHVSSqJ
Ye59pPe3zBNKgJ2H7E4hLsKqwTfWTOb9dQKM+IKaXaaK1gkAAUBhBn+PNwQJRGeW
xGgFLZr1kKqvPGLw3M/C6VsHtbZUmVxUIztAVGT+Edspv16YHjB/G5FR1g1ViNZi
LO/BYK3yHW3oJ1PqHvaGLVGmFTeB8LDmvA2cRSzUrprYkalF+yqMavCJ2QgWvynS
j81xUDqM6zzmYIe6TllBvjcsRIp5GK4KlmmzpN4kMkpbFUv9b7oKfmE/m/UMr+TO
U9UGT/b0LqRvf+s2oKZgUbtbhApt5rvbfF8Gkkv37hbWsNSF9CEZRgQIfx6pC+Dh
E5fvczBOx7/bODMTwD5HSi2nvbD83W4LGOjUH0qbxUKFUqmmqq4=
=1UZh
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
