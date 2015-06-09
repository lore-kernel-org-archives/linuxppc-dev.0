Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AA6A1A02D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 14:56:59 +1000 (AEST)
Date: Tue, 9 Jun 2015 13:57:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v12 27/34] powerpc/powernv: Implement multilevel
 TCE tables
Message-ID: <20150609035716.GB11000@voom.redhat.com>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
 <1433486126-23551-28-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
In-Reply-To: <1433486126-23551-28-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 04:35:19PM +1000, Alexey Kardashevskiy wrote:
> TCE tables might get too big in case of 4K IOMMU pages and DDW enabled
> on huge guests (hundreds of GB of RAM) so the kernel might be unable to
> allocate contiguous chunk of physical memory to store the TCE table.
>=20
> To address this, POWER8 CPU (actually, IODA2) supports multi-level
> TCE tables, up to 5 levels which splits the table into a tree of
> smaller subtables.
>=20
> This adds multi-level TCE tables support to
> pnv_pci_ioda2_table_alloc_pages() and pnv_pci_ioda2_table_free_pages()
> helpers.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVdmQbAAoJEGw4ysog2bOSXaMQALxIjlsnDVIuDlLd/zMpp8NL
kQmoKViBtTrMn1bCZ8W1MQtFrvBnLeq8VHMmBOeVbWJkbtDHMjOHULpZsEWkfkv4
8DUI++dSZgsuCUrCtiikCa9MWrNpCGgWfwvZIqbxxcwFDH7hBWeciGNXORqyTjh6
lnK5/Vky1nak4g1sKu4f6F3pArYs9Y5t6NcPQEkvsXABA7wPbuXgqaHDdFS5vDHM
nruT5ZxW+YItK0tWQgudVjAtFvum+syFnZCF1EcpCfhz0qeQOfdqI/+zJwg98UEo
TOyV1oVDGMO7sbjT0l6cSPuWWz/PknjX/GfOV4CeaVlpliogpUhCouLzpv+Mdrhk
R19ZqGhNnS9V0UL/xuCjjdLZtmQLz91NLgWXcrEkXBGlRT4+mG7PInO/gw4dh8cf
PufnkxVrVL6Pir9w8+dz4mNf/IWchGD7ny/UcA95wOZ5mZIePUlDI76ZuVmSj6Dd
d6biXQdz8KFWFMvoEVsK+9FLLrqOITpjYAmQfFS1KkXjjeZnTHZy03foBBXBhXPI
j8nV1Pb3y9dcZo+TpWo5TnqpsWCuSf81RB8fu/xQL5JHEIsM+g3YfrGj9v/2Wkyp
t6fLINERyKebtWivgksfHY3zX6TBiST4ys+PjQJEhOgcYwP/wcghVCfLlkv5asMv
R7qIW9keGcNaD5yFkHlH
=1fus
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
