Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT8m4fv3zF2Rr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:37:12 +1000 (AEST)
Date: Wed, 2 May 2018 16:16:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel 0/2] KVM: PPC: Allow backing bigger guest IOMMU
 pages with smaller physical
Message-ID: <20180502061608.GC3517@umbus.fritz.box>
References: <20180502040723.20545-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
In-Reply-To: <20180502040723.20545-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 02:07:21PM +1000, Alexey Kardashevskiy wrote:
> This is to allow the guest to use big host IOMMU pages even when
> the exact page size (i.e. 16MB) is not supported by the host
> (i.e.P9).

Thanks for implementing this, it will make a bunch of things rather easier.

>=20
>=20
> Please comment. Thanks.
>=20
>=20
>=20
> Alexey Kardashevskiy (2):
>   KVM: PPC: Use correct page shift in H_STUFF_TCE
>   KVM: PPC: Allow backing bigger guest IOMMU pages with smaller physical
>     pages
>=20
>  arch/powerpc/kvm/book3s_64_vio.c    | 68 +++++++++++++++++++++++++++++--=
------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 54 +++++++++++++++++++++++++----
>  2 files changed, 100 insertions(+), 22 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrpV6UACgkQbDjKyiDZ
s5JypA/+Ov89yfLjRigq1VIQC0VZyHfl0hqgj41DetLj7gUY0jG0f0EHEnYbtulJ
ODl9m55VTdtX4dfFK+sx72cj7i2+QTGK67adljLmGqDqMn4oEqjd7Zj8R5zSr9Ls
Jnrq6WMBjNdJvT3bGxut8DqOOpifBgCLAeREap6y9FSSouH4uGv+vCYm2ILylSOl
TOi7nru2VApR9IFvJRSf975414RiZlHrP/hQ5Y06BagHqNkYY2gJMofdHPdoZOha
b9I5D9S3Y3a9yZq6crVHYZLObHuxcEVHPPL+WxOHiEza/9pH4IjjP6/zdP+R3kgE
NUEe+2dT6F1Yj2/cFJ8fcruPaoK5Eik8j9XXE2Y4TMSWiV7OFm1vA18GGmeyt0B+
eKrABfCEeVSsHzTx7AGKw9r+DsM7BbfGBy/GfaIzP9oMPi+58tAbZWg1IklpT4r8
H9U0/xO3l2q4vxszRf/URN+11a6pwl/bgtylA9qpcjopsyB/mKSqJRk6/iE4UVfb
+KRkTPG9HiE7hujlMbA4K4Pmy0srRIenZ/2Yx8iCIY83BmRPquFG4k6EDtRlqfiV
NOrQM9iv4cZbWAJ2QAB/kiY/GEj8ap/Ro3yba9sJwa61k4m/6UKfMut46ylBFgjo
S9TwMhvitew/PQObFgL6lUtGbQKH2fEz0vEbkxf9mHQM8jcQFec=
=LIT2
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
