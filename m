Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D188D1A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 14:17:53 +1000 (AEST)
Date: Mon, 1 Jun 2015 13:55:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 03/34] powerpc/powernv/ioda: Clean up IOMMU
 group registration
Message-ID: <20150601035542.GE22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
In-Reply-To: <1432889098-22924-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:27PM +1000, Alexey Kardashevskiy wrote:
> The existing code has 3 calls to iommu_register_group() and
> all 3 branches actually cover all possible cases.
>=20
> This replaces 3 calls with one and moves the registration earlier;
> the latter will make more sense when we add TCE table sharing.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa9e+AAoJEGw4ysog2bOSrJkQAL77wrzcbbsCQYFTMzclG+qw
T6UzhRb4HKugp/idWExuH/+8LgsdDxseKQOg7R0z4YDxNcQMEFCq1yxfycmbD+dc
i2MY8zW342puzjKhTunozYKhzSYokMEiRUTxvPLPe2sKb0EMvh58RC3tsqclQEPV
H5/mRsgOnq5z73EZUySitJ9fVayRVl3Ia52RlOCrUvTj2/XPYvAyEh+styNUCGC3
gZAVkrRgf/DChimtWVyOggD22HfHUDtbv0acbW3Irwgy7ml6NkV0yPrtfubF7Mom
vAum6UiX23TFq8BesySIJ6q+uRZkh5VNdV8NXZiq33gGLIt42zzA0B7j//NTjpfg
QP8mvKr3TqgmaAUe7V3H7QaEteV02lTaNqNEtMVH1pb8fxQqNSoUBO9WNkTNBak9
H/QBD2w0MiEAYkNgU2c4skimK/MmVC+aAvuYn/N1SX+3XNpexJNkQEi82LOaGFfY
7wG5M2tQUm7m+I5NoYWFL2tdiUpVeN0gQzNwXXvSnXWoBdSloYduLvuyoLzo4SEn
WtYC0V/XBdaeFJtFIqsBvYNM3XYCNE/uKMCgJBd+NdGg4M1ZHrY36hohPS92heJi
yOHavhSQ4XAMWAqzIVnmpn5AqaWlhR2R7HoiT4WJ6pTodmvxL4GOdeVQg1sodYUt
wpGZAW0MWiZWe0lONBSr
=w4x/
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
