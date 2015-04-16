Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B8251A0CC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:50:02 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:43:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 20/31] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Message-ID: <20150416064351.GK3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-21-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8kI7hWEHMS8Z+7/0"
In-Reply-To: <1428647473-11738-21-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8kI7hWEHMS8Z+7/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:31:02PM +1000, Alexey Kardashevskiy wrote:
> This is a part of moving DMA window programming to an iommu_ops
> callback.
>=20
> This is a mechanical patch.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8kI7hWEHMS8Z+7/0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1onAAoJEGw4ysog2bOSp+4P+wfKK2LdSzarhCYV+xXszxe/
gBv+fM6ajpejwPa836JPfAluLN84ryASLUxb+4xeACxjGoEkm1FBnXCeuPeQIhPQ
ezUAMG0v+1bNnjeD2j/iiXsNjfWVnXUbSFOFaIoM53hJfq9nprMzhIntsp8vyo87
EPari88lZWZab2I/FPeLpN0HACV31J1gfG6oq2dcRoXsjkUKkmR9nSJ+J+oe1+NO
meAwcS8yQIlraa5nzFB0/36lDkoRtX+F5uQ11APj2bQa4GS/nh6pvsoxUXBvd8dh
xZx9h/554zOWTjBJyuTtRa2XdVM6wx5grOVHp9qPqrqq7qlFwMMiyEuozFJRzI+t
pBP+CpXhipBC5YgS+p9z6f9pHzLDIabBKrUPJTBv1QtqGWuRcUp0YwgPVF0bQ+Y1
xfl/6O/ATVk0kUGy39pzkBoGc5QmJ3i2ZuAQu4tzwP5SXnNlnKKEUS9MKk/XbBZv
BbUJPl6adpgp9+91ULmt3Lq6o+hVzDpvfruubzfgVTDXMYeduBb6egfekrNdI9wF
DuMzzopdqMEaFONs4NJx99qX3CDYfdi9CZ9e4/JFoUZHG5UPJ/A4gBV22cKbvBub
Qq88iMDNvb9YUjT86oQhz9tnJ+nSmY86kEF3wWbTs9hyau/odAsaOOftIpRB5nsG
m1KK4R3fgFCRjDx6yluq
=gz1w
-----END PGP SIGNATURE-----

--8kI7hWEHMS8Z+7/0--
