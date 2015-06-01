Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 039371A0673
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 14:17:54 +1000 (AEST)
Date: Mon, 1 Jun 2015 14:03:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 05/34] powerpc/iommu: Always release
 iommu_table in iommu_free_table()
Message-ID: <20150601040304.GG22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
In-Reply-To: <1432889098-22924-6-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:29PM +1000, Alexey Kardashevskiy wrote:
> At the moment iommu_free_table() only releases memory if
> the table was initialized for the platform code use, i.e. it had
> it_map initialized (which purpose is to track DMA memory space use).
>=20
> With dynamic DMA windows, we will need to be able to release
> iommu_table even if it was used for VFIO in which case it_map is NULL
> so does the patch.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa9l4AAoJEGw4ysog2bOScNkP/1WkAIWDhmWonKLBdV5Ocls9
c/p8Aha1gGFnmwmJ3Gn5nr9fG6QMxRarv8emo7DbXE8ScQ9M+Y+Riwhz/D0zufFi
m4D+JsH7pfGhVosG8v994ZBLUSlvCRraMg+xtIqmCNuE/Jx/iQDa7aMV6Lw84LLY
VVMKKB3NszULgkkFIi+gBRWjTl0JcMxhrfDjsrlRHQSZVJjCYjTcJvX1ha190Vfx
QCCEMSRwu1d1PNg/jdIHyJgmVLT/K1oXXoHvb+AaDySDAh0P+Pvi2pCXbeTThMi8
d+LU4muFEyj6YzsBX75Jflklb4VifurFKztdA+PVZBAWjqEAwBSagLVRGZEPcnwf
Pn5f7VAOrLYNni7cew5iPOQvzlaMHHlAg9FTReIKFbu8dLyZud/nZpxtJQZaUpis
nQYr3Hi3IqQ6a6FBdP7zPBS2xzMRZADC3W1SFnnhDL8QUpWdWKhs0CVqTk6EJrHb
rD+asbIn6xmST7U4pSV/rl1v579lSGGm5NqIneILUl2qXzHvIhBUYR+R238VUhLB
Y6/xyHKKpxwif1eT5gCtP/OhL3fi/nA2oSPCjmP7PUeNIs3hkvHaUlpD6/tpXH7Z
5RFPXSMizcuiF5bs/0TWvb1I05+K3ee6cRP7TPHbxFNAx8e3CV24WtAhXz8IA3cO
Y2h+j7UzRr1yaDME7BQj
=xbc8
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
