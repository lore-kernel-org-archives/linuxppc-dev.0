Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EEE61A0414
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 14:56:59 +1000 (AEST)
Date: Tue, 9 Jun 2015 14:23:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v12 26/34] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Message-ID: <20150609042324.GF11000@voom.redhat.com>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
 <1433486126-23551-27-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
In-Reply-To: <1433486126-23551-27-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 04:35:18PM +1000, Alexey Kardashevskiy wrote:
> This is a part of moving DMA window programming to an iommu_ops
> callback. pnv_pci_ioda2_set_window() takes an iommu_table_group as
> a first parameter (not pnv_ioda_pe) as it is going to be used as
> a callback for VFIO DDW code.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> Changes:
> v12:
> * removed comment from commit log about pnv_pci_ioda2_tvt_invalidate()/
> pnv_pci_ioda2_invalidate_entire()


Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVdmo8AAoJEGw4ysog2bOSf28P/jndHLM9Fb7U6qbB7WgFWxIL
/XJAan1cf912B02DjQscPUbiESodOWB13Ihal9jSrZxf8iIvX0ZxWqE5TqTwEHGs
ryuUHzIF/g65AZsfoNwIkhjTkwewnmxW3tWozQRZgApEgDyk3JI431768pAF1X7V
N3+8a2nkzm7FORiIWOCfIxYvnU3GCnlX1YKTAnXQEBIV03gq9PWzbhunRBY2ueKP
WcI/7tnlBk+gJMnaD8A1miC7J8y8YzzrCXAYJ+BJskW7fxkiN22W9bF8HdG90B5X
tvyTgBC8uOo4IBW/MGPiUdQLkcyCAlHDOEFqKzzDpNiFnTxgRZZqV6yrEfboF9po
Cq1gzH4041Gly91CyCEv59NMAIBB68SxlqF162kEvHdx9tlszHxy3n/KAydWrO12
B8vZWl15Ud06z5WJHfQQP8AWOmfPDP5fd7Qqtm+vlLNvKNnxADqjhZfYjrsmMz6/
katXZwNWwRWKhfbB+hUQZraHxr0dIHqBBBieV68tVtEs8dntt4euhza5rCu4X7we
AonXZV+MQBQIzipmo7OIOH8ufTCO/KiJSzczWLsyCb95YSrH4IEcpty2zyO0Cyjh
0110QAfelCeHlCTX0I6IJaKZsXRbXonPuIm5TJubP5lG/C81CRYnI75dHEDaTnpN
5LnAMX90F0GFruRkQuGx
=+F5e
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
