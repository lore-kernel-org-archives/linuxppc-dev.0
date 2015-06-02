Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420E11A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 15:01:43 +1000 (AEST)
Date: Tue, 2 Jun 2015 14:37:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 34/34] vfio: powerpc/spapr: Support Dynamic
 DMA windows
Message-ID: <20150602043719.GG3186@voom.fritz.box>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-35-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
In-Reply-To: <1432889098-22924-35-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:58PM +1000, Alexey Kardashevskiy wrote:
> This adds create/remove window ioctls to create and remove DMA windows.
> sPAPR defines a Dynamic DMA windows capability which allows
> para-virtualized guests to create additional DMA windows on a PCI bus.
> The existing linux kernels use this new window to map the entire guest
> memory and switch to the direct DMA operations saving time on map/unmap
> requests which would normally happen in a big amounts.
>=20
> This adds 2 ioctl handlers - VFIO_IOMMU_SPAPR_TCE_CREATE and
> VFIO_IOMMU_SPAPR_TCE_REMOVE - to create and remove windows.
> Up to 2 windows are supported now by the hardware and by this driver.
>=20
> This changes VFIO_IOMMU_SPAPR_TCE_GET_INFO handler to return additional
> information such as a number of supported windows and maximum number
> levels of TCE tables.
>=20
> DDW is added as a capability, not as a SPAPR TCE IOMMU v2 unique feature
> as we still want to support v2 on platforms which cannot do DDW for
> the sake of TCE acceleration in KVM (coming soon).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbTL/AAoJEGw4ysog2bOSuf8QAMnDUjB3Mj+IEYjJRI+XF49U
/FAaLYfAQv/PzyaFGR96IdT169gjV29dmLciu1t47l4gWBkLO4cQSXlC7plDmTaK
SyulYqwVEgDx7nv/QSvsZL8tr2i5IXvHCScLHgtrreowKZVMpVw00cshncapBOC3
eifRjMCrEJuUBVnCxXl1c7S+uKkzWWJaDzIZm4SLii2sppdw72Ac/+LTyZrBInCa
qNFHXYH4YDiJYzAHMvq3j91oEZddoZBlAA+03H1hpnjYEGQJbDPvus63GnXuA+Gy
wUajq5PyfKLFCfDoFvrHQMbtu4ZYtPaLwlCBxirNRgMWPhtMYZWwLQSob6hni8u+
pnK+16+GSIb6/if/+yPzbMmkBMcY+/Zk0VZHp6gW0T4C48nDDpCjPW4Nu7S9IweN
DAqeiRCwNlvH1mNAdSRgOLvMnAJ5JL4LaCU8M3w3Dj6L/nHF2WpywtlDfnxjyNZx
t7CE6iDojGj5m3t15JY/7Tk+zdH1+6w9GftMDuOW97BM605s05XR2DQArkfwqJUn
IdzPMR4CQs57B8NHp2HTGMPijK5y0hXmJm6HqqKK7hUH3jrAngolbzRgZDihxKia
gECy2s6PD0JO/PDEb6WvdNqJyzg1OhQ6UYCNcW9htjWLtcL8RG+jr+Y+HrPgqHDD
//IlB6gNZlaBHlij1o6A
=IMCx
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
