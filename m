Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B93711A04C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 14:03:31 +1000 (AEST)
Date: Tue, 16 Jun 2015 13:40:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] powerpc/iommu/ioda2: Enable compile with IOV=on
 and IOMMU_API=off
Message-ID: <20150616034034.GM13352@voom.redhat.com>
References: <1434354599-22659-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RXc6EO4W1yUvSQ0X"
In-Reply-To: <1434354599-22659-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RXc6EO4W1yUvSQ0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2015 at 05:49:59PM +1000, Alexey Kardashevskiy wrote:
> The pnv_pci_ioda2_unset_window() function is used to do the final
> cleanup of a DMA window being released:
> - via VFIO ioctl by the guest request;
> - via unplugging a virtual PCI function.
> However the function was under #ifdef CONFIG_IOMMU_API and was missing.
>=20
> This moves the helper outside of IOMMU_API block and enables it
> for either or both IOMMU_API and PCI_IOV.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RXc6EO4W1yUvSQ0X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVf5qyAAoJEGw4ysog2bOSh7YP/0QOuhCoRbC+7PflbluizBcY
ubMm9Ty1/2hruKAwf+qZ4FTAlyJDNgeRcD4TfrsiGgdpZ88L9CT1WyiOvtIHDUvt
FJflDtDuCrkDIhs9Mb+todeoHD7QPySl0ztRJWOu+jqBEWyM+xcoJJgCtJMssUyw
op1ds9g4K1CuTUuDDzIBsR4sYlfWnHlI6YLal4CDMVYkmAg94kM2r2zQ8T+Eszwc
GtbiHvjMWk2MVKgCbJVigWlxTUvqThn5vWWPOWPbu1WquVBFYnDDXwOFlKdDGy9x
evgD6vbSfm8/aVqORxLV4ClUWFhKIKzOHLczSVLejaRRsmmXzgj2MzS1JbrKRzod
fOaluLqcDcGI3gQ0P/6wn3EO4Z6iYYrI3ZKm8lgK/wWyvz97QTnKpNmorCVav6Vd
oH8wXskkwbnDN7q2owG7bjoU7Pyz2CBjw75Jl5GudilgI+fl8Ei0d2vXM9irM3Hg
DK1yfwu2vPTkT7d3LUcz2SLL9i7BWPIMsSD6zlYh1haBNA2kzgETHkCEqAiObHkf
+jCdOZtdynCHsIlX/ToaL/f1sxoPmKK/INaAl2xJZcGjUyXs6nXelnMBdkpmSMxM
VsO3CdtLU8OHPdSO6XnfIlRcaB6/OE30sA+y/7bH0pzX29M5ACsycBVJEaGbNwpd
Lg7ANVUF3haWPo8TBpx/
=db1u
-----END PGP SIGNATURE-----

--RXc6EO4W1yUvSQ0X--
