Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A88251A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 14:17:53 +1000 (AEST)
Date: Mon, 1 Jun 2015 13:40:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 01/34] powerpc/eeh/ioda2: Use
 device::iommu_group to check IOMMU group
Message-ID: <20150601034011.GC22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
In-Reply-To: <1432889098-22924-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:25PM +1000, Alexey Kardashevskiy wrote:
> This relies on the fact that a PCI device always has an IOMMU table
> which may not be the case when we get dynamic DMA windows so
> let's use more reliable check for IOMMU group here.
>=20
> As we do not rely on the table presence here, remove the workaround
> from pnv_pci_ioda2_set_bypass(); also remove the @add_to_iommu_group
> parameter from pnv_ioda_setup_bus_dma().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa9QbAAoJEGw4ysog2bOSTpUQAJ6NA6yYXR4xY5xunMuxQuFa
IpqJM9NxHWzNhMVNFxajzG7SOrOMzAN341fRE4/bmQAWDwdJC3bNEb8m7pTjwR+Y
m/+qNz6r1YrOrGZK7XYkPQkBZF46RBjET9oQ6BIdTYCwNQBKmHQNTmHXgyuGsLnL
LHsqpJdJpNqz37NYzr1WRnEu5ulZkXX3qbY6l8aSfwOqbht5f3IYOaeRyq/NF/Ur
ueka4Mj9BEcMPzoC5PotF8eHhSN9Vquxp2QMSh5YAjN1Su/N71R3F6ePMtedvdJz
/G7b6zQ8sAQWm/JsSsJElwEN39melWrd2P+mCIUbaUroThmOkQDXJX5ECHunpt0r
iVYwIV1fgUS4NwQk5FOR7+BqDzjIWKvN6Kk0/L7zIoNkuQjEQq0DUtCoVDld9ce7
rvq2IHOw0qcEkBPKxNKrD0teolgyzX/EYi6gZ4cnH7OyXCWfO78dTFKkZBM7iOXs
EbYDF3sZQS65EkpTCCw7Qzeo83HpOh+w9psUxWFVtbp+KTsX5mS8MpwPpUfaj2MZ
xcqotlyl7hHXoxgYaXd3/q+/CNKYdl7z89N4OS0HPKyLzqFP7xa7Uya9HRXyiPqN
/D3dWXBqUgDNlJ/hOuLRTSjvdDZvlIktlHY/2aAPEpiEenJB6Ys6SBUBLcgWZQip
rBFwS19HND8GiqFpBl/v
=jtpU
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
