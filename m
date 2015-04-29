Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC3BD1A0CBD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 12:05:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 02/32] Revert "powerpc/powernv: Allocate struct
 pnv_ioda_pe iommu_table dynamically"
Message-ID: <20150429020504.GF32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
In-Reply-To: <1429964096-11524-3-git-send-email-aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:26PM +1000, Alexey Kardashevskiy wrote:
> This reverts commit 9e8d4a19ab66ec9e132d405357b9108a4f26efd3 as
> tce32_table has exactly the same life time as the whole PE.
>=20
> This makes use of a new iommu_reset_table() helper instead.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQDxQAAoJEGw4ysog2bOSqZ0P/jgnFDsFVgHMl+moVdl/9EgQ
+xr/R6q6rA/KL69jxVYWJeYO363BGfYwAl1URMcXoDljw3v2AgSym2mRr/CRSKZ0
1NQA67ROhn5DiOEMOIRvH9Y3ii5adee7HlUE9SLKmbLYO9lGBv15fU2M53AAtuCi
UmDSrCt/EQznzVAB/+8NER5xjvGWlwQIi7FNl2BhIuyXqOjuCdPQK8HnfTx8z/7o
mmm6w0p3lfEb3vWU6Z7ReQ9hS7LRuR+Bjl6wQmrCMz53No+Uo7z2/ntE8xnddz0E
ctmBeia2AXA/YFxoxXE+Qn3DWdsfprQKcVtSHqMwFV9jYLDUtvb0xy/c90N5ZeAU
pnLxWoF5VVuxlz9migTkVotz8XYxFetj2DcgokwqEu2eCxfMrcve9zWvs2WwOLTG
llicw65S/lGA2/aUcOF3x5nxaxl7CSgPPpFN4B3R2G08IImMwZQfIBJalAjR1p+m
4uHsk7ypVxVY9kscrJcpewcaNU9qa9rrkUEj0+Ec9zsLasdwkGv5nFx/OvBQcAYX
a8zKcgcv8wJZMvUhutc9vlQHxfRSFfEiWAQS1pbuxVBC4aoyzZxOvwAklLaffbi9
jlbhhrEXof+jReaAw5p5FhE1Odo8XCv80OVK9lAKw9Fw1sEXuDW3g/9kNBB/ws8Y
d2EamIpA3ZaqCTTdMszJ
=89rM
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
