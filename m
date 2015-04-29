Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD8231A0CBD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 12:03:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 01/32] powerpc/iommu: Split iommu_free_table
 into 2 helpers
Message-ID: <20150429020318.GE32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
In-Reply-To: <1429964096-11524-2-git-send-email-aik@ozlabs.ru>
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


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:25PM +1000, Alexey Kardashevskiy wrote:
> The iommu_free_table helper release memory it is using (the TCE table and
> @it_map) and release the iommu_table struct as well. We might not want
> the very last step as we store iommu_table in parent structures.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQDvlAAoJEGw4ysog2bOSeuoP/ilRSVW6EpkL32s9bVO1gLbP
t3NAlNQxLyqylMNndohFRLLaI0ZCkFyi9PsF1fCAK+pyMzFWDC4CiSUPAzNu5PjA
o8DRMHxybVaxzaImiotMxQgnsnLAXDsza3FtSc01qJwpjJs89KtgRQIObqa7+Xyj
DjbR1ODYSkwxFbD3r9Y/WChxuUVj2xaNBMcsXyoXyMKTjf/kJ3QnXoeS9Pcow0L6
w83UZisXgnQAIdZ+dTlulDK68EwvuTCuSChs6CMHDxNIgilEpgzq54qtnDTW8dRW
7MG4/KfWs9UKVQWjxPXrJ9xWxZc7Mffcsjim0qoJdvLWfeBvKrwygBA+CkJLFozL
xPlEAbAul1h4bPuB4vw7amMOAoqKCXQSUC7FkJArhvMTktLNZzyGW75Iu/+bp4dv
HKp6N36yBTYt5iV6QFQWFMp10GbTXsW/4t+6WpoV8ezidFWIYEK84lVLfZcZZvJj
Af9GP3n+pQ6fuLjy/jgGsKmwlIi4s0NfhwpSuujMS3qQtJj6FVuBD39AhVp0Xa3Z
VQpstp6wYhYy4rvlXlBhR413WV8E0wxC55LpKaxk97eh2cdCFzzPJk/eycloRcXH
o9orPy9AbgC0LbTXlKmcLhG4yf8JLUL+4PlUxFfU2ZS0sYhgeKcVMBuOo3cm+bPP
Uk2s6HmSaq+CUn32ePXW
=4u28
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
