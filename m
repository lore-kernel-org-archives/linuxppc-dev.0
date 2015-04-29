Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEF8B1A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:50:03 +1000 (AEST)
Date: Wed, 29 Apr 2015 14:27:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 19/32] powerpc/powernv/ioda2: Rework
 iommu_table creation
Message-ID: <20150429042722.GP32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-20-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="o41d8xLWOaLD8vYh"
In-Reply-To: <1429964096-11524-20-git-send-email-aik@ozlabs.ru>
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


--o41d8xLWOaLD8vYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:43PM +1000, Alexey Kardashevskiy wrote:
> This moves iommu_table creation to the beginning to make following changes
> easier to review. This starts using table parameters from the iommu_table
> struct.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--o41d8xLWOaLD8vYh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQF2qAAoJEGw4ysog2bOSJjQQAJxm3lHmy4GUjGJPAO+Jmq9s
C7KcbUEPO9ErGn2GqfKqqiPCUNN/ZeGxBORUyde1+g+pqxB8W8OQ2KTxTlulVkEK
1eRi6+w0vxY2aV+ywjoez3J8vviJ75nvxv4dUfTSiUPK4SBfAXqX9UTPIUGVRCPV
IE5jrvf8JzUg3d4p80yujO5aoxl2sRIaSr03ze6kdWcRkur32mJDhXAvdOSs1JLL
q5GCQlyQOpBIErpVRSW8AIJ2aWW/McXbgbkU/NyKVIdufInzjLx7cepPB0Sujf60
D/qsAfH5CBwnmOkpkXuk1dg4JnH5WsmvUtvKw5LJZ0YWtpC9BLKtTZT2pzwI52en
p/b973E1uzrA/kgbe2+XBzrAwZ8TKavStDpuVMMUodTKK2ItFMHAskezVBy32RBy
UuNvQTmNA+PRsbhZdUa+5uQQGpA2TruFSA0w4X00jPPezH/u3GqbRcDx4z1rpTBV
EyBEskDV0ueRpE60x/daSnIgUFTrEvz3fO9FwZM4/Ad6SGD12LzYLGptsawykVIT
c6+k0GUDAuNOwH1hNwCS3YJOP3jkhsa+FG0/EmJna/ya0G2UH8DmhPVaG04RXD+y
lbPZa2xsdiLXirvElu95Mde6WiWI1Mzp5qdOq+e9RZvroUj+2sU9F/7ldxQUm0Y7
XKNWLyEHkcWDtEssw5kV
=i5Wb
-----END PGP SIGNATURE-----

--o41d8xLWOaLD8vYh--
