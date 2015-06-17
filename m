Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8D291A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 17:25:09 +1000 (AEST)
Date: Wed, 17 Jun 2015 17:05:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] powerpc/iommu/ioda2: Enable compile with IOV=on
 and IOMMU_API=off
Message-ID: <20150617070518.GW13352@voom.redhat.com>
References: <1434354599-22659-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2NVUe83uzBILE3UT"
In-Reply-To: <1434354599-22659-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2NVUe83uzBILE3UT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2015 at 05:49:59PM +1000, Alexey Kardashevskiy wrote:
> The pnv_pci_ioda2_unset_window() function is used to do the final
> cleanup of a DMA window being released:
> - via VFIO ioctl by the guest request;
> - via unplugging a virtual PCI function.
> However the function was under #ifdef CONFIG_IOMMU_API and was missing.
>=20
> This moves the helper outside of IOMMU_API block and enables it
> for either or both IOMMU_API and PCI_IOV.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2NVUe83uzBILE3UT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgRwuAAoJEGw4ysog2bOSMlwQAM/57KFPz2c/RTWmEm7IVbsw
9pyHU11tGbjfkpXz5qhhn8NWlGGscM89rQYtMrmDbnE8jxUq0TcDucW3ie3s2eUo
qf4J8aGZ9zlOga/xon4nCKSZs3MSfPUkdTfWm/68jUy6cwQCAt0PplHCgCpBRhtW
C1KFYma7Q/977JZJ09Z+Tytfq4YMbAN0qfI9gLxVs9A9wp/oS6SVbPd9SkJTnWLR
gdU6MhwOoE53ChFIoqnM3sB71v+fxQZM6dliIaR4EOQ/WIWgk+eQ5zF4Le1vA3QT
xiZMWj7KYWLXxARrRFbTqwvHCmSKjOr4vMsbHOY+ZiOrRDQ93ao7ikoWuQcsgUYb
fXG4smSngw07pEResaRd5ok5l43Cei3uv8BX3Gs9fXk/RYYk2fP4dbHKkgqqzsCA
FqI/CSRa4ZK/33UR4QeF+mytWX3Z9sQPSbRm907lRGZGkZyQzq+YMNqQCyeCYcnx
zcSkH/y7ElGNRX9NoeaSfaijmzOSwwwYcDxh/6g4N6ZN/sLix6OIxy04D8/6WWsb
HXgbTA1NBoSSHmEaV0wh8tDztpbh77bc9HkkOmid72W1CqSeAkPJnIOdiV14mqXy
ZvGv+4Kk4MgvvEWozMElePcHYuDlgIzM0xG7mRXs9hdIB6hbmS485LSTcSfUCdMR
64ZuIB0wR+mPnCCENcLU
=Lp7z
-----END PGP SIGNATURE-----

--2NVUe83uzBILE3UT--
