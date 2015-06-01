Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E32271A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 14:17:53 +1000 (AEST)
Date: Mon, 1 Jun 2015 13:58:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 04/34] powerpc/iommu: Put IOMMU group explicitly
Message-ID: <20150601035848.GF22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
In-Reply-To: <1432889098-22924-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:28PM +1000, Alexey Kardashevskiy wrote:
> So far an iommu_table lifetime was the same as PE. Dynamic DMA windows
> will change this and iommu_free_table() will not always require
> the group to be released.
>=20
> This moves iommu_group_put() out of iommu_free_table().
>=20
> This adds a iommu_pseries_free_table() helper which does
> iommu_group_put() and iommu_free_table(). Later it will be
> changed to receive a table_group and we will have to change less
> lines then.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa9h3AAoJEGw4ysog2bOSXvYP+wZ2LDgSK8rbJjlazt5xzv+x
5CZWQHJ93pSSpBMGGLWKOfsdbgcU7+TxTqo18G8uepVQjy6KqE+AGFLeKDP6uIZD
JWRjB4HG3DwAfcpZUQrLtUbHshPQyjz//pFYOuMz7ZauIBY2hhdx+Zl8vu6m1noU
HPLBnLDPD7ccp/oBFNDxTznYiJStMuVRJzwdV8jxbtr0P7t/cS9ZyHl9q/Dx2t3A
OMzhhRJUB8UgqMX2FfFfPpK3rdJ9g4xvoUrztMbzCmvAFgihlYtZMBygeLwbOXGq
V6Qr7j82JRc5DtZtUXCQ/Syp9CYyCkAgtW6Ka55FQMs3ZuWqvd/a1yvpDPgINn3W
z4DnKWzJZ2Txex+vvK7VvZHrTzfx7cGRHrhw43SjYJyc0csU//58f7NQIN1oaiJD
gxjykC9oLRYz5sKUjfYkU+i+mjRJXqDZPmI8lDWHcRk9dkrubBVGGQLQLiLjUPIx
U5ReXTCHqEwoKkvZEb+i3w0rTdjIjXS1hfbgQadGCZXk2df4qSWr0OVOenLqkVuY
QF5wRGj7pPZjny5vYjs+JxNT1bhlxyGxYM1tmo/SN2DLI5BfzBPmHyIX5XwGcZas
mMR23LEygl9/gzPCe48YAL1Y/L9pKzGuQ4ZyjqyY2tTZ0zQkk6ApyXbWL4x6xY+o
MBC7B+XFiKcCoNeHKw6P
=FwUc
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
