Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DEBA1A0063
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:40:17 +1000 (AEST)
Date: Tue, 2 Jun 2015 10:54:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 30/34] powerpc/iommu/ioda2: Add
 get_table_size() to calculate the size of future table
Message-ID: <20150602005449.GC3186@voom.fritz.box>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-31-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
In-Reply-To: <1432889098-22924-31-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:54PM +1000, Alexey Kardashevskiy wrote:
> This adds a way for the IOMMU user to know how much a new table will
> use so it can be accounted in the locked_vm limit before allocation
> happens.
>=20
> This stores the allocated table size in pnv_pci_ioda2_get_table_size()
> so the locked_vm counter can be updated correctly when a table is
> being disposed.
>=20
> This defines an iommu_table_group_ops callback to let VFIO know
> how much memory will be locked if a table is created.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbP7ZAAoJEGw4ysog2bOS6AYP/3MciL9K4uM8hxn4FgKvkFXV
rp+eMP7FnvsQylNB2ZtZwQuAJUuswnbjXda1Rts88RuYX8aJMDFnmTjXhEezOd7Z
LsRSTiyysILB/Khp63pGBeEyrsbX72GSMclxnEJMJbQR3rFvFmcllg7DXcIKKII8
iJ+R1cwDkzh1O8L0r4hh8lAyiueWaru2i4OjinanJyEyj2f1njaLZsaV/amfaUd3
+EfMWms914e4wP0WU4YDzGjcYw2WJDD70fCPLRxpIM2s2gXVcpWnvE+gkailVYqB
FrSEA7xFTGnuRoZ4NRlBau/tOQ7NqKL9FkaeN3JxlkIIIHzNoZZAIcWvjxHYxDKl
vZAuL8bnysp5OnqPz3a360plVJ5PfJt8boPJjSIpJL3SWXg0El5rlcO6s8+ABJ86
6y/U8O6g2FZRRchXg7EKE6FG+IXjv1bd19lhc5B/57LvfPajzySiYm3sC2vkLpla
HwAO6BLB4RcXpM27izh6QDYet/dlwAK8JiH5T1E1+SX+DpYmP2+81imxpXkdRE7Y
E2Y9s3vhcJyxq+8N16w5Zw5pxUdNktXGYM1jF3HNr8lgSGvUCii9RwIEFfbuUrMN
/Ya31KBzmpm9wYejP/Fv/OeXLYcpzH7VJFdJSU/6boc+v/9OEeXCY0hJVkMXvB4/
P0nBw2rs2HREYDyODs4O
=Y9Xo
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
