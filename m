Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5875C1A0C2B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 16:49:08 +1000 (AEST)
Date: Mon, 1 Jun 2015 16:49:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 21/34] powerpc/powernv/ioda2: Add TCE
 invalidation for all attached groups
Message-ID: <20150601064922.GM22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-22-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
In-Reply-To: <1432889098-22924-22-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:45PM +1000, Alexey Kardashevskiy wrote:
> The iommu_table struct keeps a list of IOMMU groups it is used for.
> At the moment there is just a single group attached but further
> patches will add TCE table sharing. When sharing is enabled, TCE cache
> in each PE needs to be invalidated so does the patch.
>=20
> This does not change pnv_pci_ioda1_tce_invalidate() as there is no plan
> to enable TCE table sharing on PHBs older than IODA2.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbAByAAoJEGw4ysog2bOS3kUP/0c/tQfq5Fs2tc4dhPUR3TDH
ddDAedAiyAA/osBnVmDOXO1QI5W5FlufCj7hN0r2+qo5WJ+hPIjKuci+1ptEScUB
F6A1HErWcIFqFgVXU55xgurmWR7jjca4LOd2q0hARtrDcs7iRwyMfpQjqqkJXWms
a+Gwb9tKTLIfvs56Zgzfb/p22/F9O47JBVZl5CZWw5P7GKJsJqJHZUifJaZT8cVd
tnoc+RgI1KF0VfHM5z8Yu35PFKCyeRKQwMxl6SA2OgziXBwDLotvY3XXN6QLCh4y
fDgUGZpyO2sFeHNyhEy4PvqtNONtr9s0Vm3eN9/xsF0ES88wF/VV0M4zFgy5+jto
vKMvfXb6Gsw+pWCQaslAgcTcAEitkKHKftuxxqlvbJWvb51jnUgvZR0Bf56wc4OD
ahVMFh7i1YWBSq534UjpS4947ZfvGgV+dj5S1lRuYv264EeoFdfa4amConRLP4xa
nY/FmuxAB9cIO7tUXVMw7BlICUHwa/0V/A03IwK46hnkWMvGxfVzDwAhLn8/1ZtY
lJ+2uBvvowFGhfw8RxODIHLPsl/Kma/qnCUJdDIKnR6krqBYYnvLhxM/XWDNagzy
Vk3x+fQJK/m6dVwTW+fEkq3Iqd+rJBeTEH1CGU+XLmmtvAbH1yjINK90HmFJimTn
98TcQAl4oujJQMjJYe/m
=PZoZ
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--
