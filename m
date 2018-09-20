Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3Tr0WqkzF3Cc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:22:06 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8K4JUUg054801
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 00:22:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mkysf97hd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 00:22:04 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 20 Sep 2018 05:22:02 +0100
Date: Thu, 20 Sep 2018 14:21:53 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
In-Reply-To: <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20180920042153.GA28551@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 04:58:54PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >=20
> > The original PCI error recovery functionality was for the powerpc-speci=
fic
> > IBM EEH feature.  PCIe subsequently added some similar features, includ=
ing
> > AER and DPC, that can be used on any architecture.
> >=20
> > We want the generic PCI core error handling support to work with all of
> > these features.  Driver error recovery callbacks should be independent =
of
> > which feature the platform provides.
> >=20
> > Add the generic PCI core error recovery files to the powerpc EEH
> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > generic PCI error handling strategy.
> >=20
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> I applied the following to for-linus for v4.19.  Russell, if you want
> to be removed, let me know and I'll do that.

Cheers!

Acked-by: Sam Bobroff <sbobroff@linux.ibm.com>

> commit 3fed0e04026c
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Sep 12 11:55:26 2018 -0500
>=20
>     MAINTAINERS: Update PPC contacts for PCI core error handling
>    =20
>     The original PCI error recovery functionality was for the powerpc-spe=
cific
>     IBM EEH feature.  PCIe subsequently added some similar features, incl=
uding
>     AER and DPC, that can be used on any architecture.
>    =20
>     We want the generic PCI core error handling support to work with all =
of
>     these features.  Driver error recovery callbacks should be independen=
t of
>     which feature the platform provides.
>    =20
>     Add the generic PCI core error recovery files to the powerpc EEH
>     MAINTAINERS entry so the powerpc folks will be copied on changes to t=
he
>     generic PCI error handling strategy.
>    =20
>     Add Sam and Oliver as maintainers for this area.
>    =20
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ece30f15777..f23244003836 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11203,8 +11203,14 @@ F:	tools/pci/
> =20
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>  M:	Russell Currey <ruscur@russell.cc>
> +M:	Sam Bobroff <sbobroff@linux.ibm.com>
> +M:	Oliver O'Halloran <oliveroh@au1.ibm.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> +F:	Documentation/PCI/pci-error-recovery.txt
> +F:	drivers/pci/pcie/aer.c
> +F:	drivers/pci/pcie/dpc.c
> +F:	drivers/pci/pcie/err.c
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>  F:	arch/powerpc/kernel/eeh*.c
>  F:	arch/powerpc/platforms/*/eeh*.c
>=20

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlujIFkACgkQMX8w6AQl
/iIeyAf9EQwpT4DIACletswv4K//3NA6uBrzgk+Q9+8feDaHqcyGyWcmfaB1sUna
VWeJuf/ItC3k87VBcD0AQK7H0g8Vl5dzKJ5vCMk1T6Zb7Xi7ByYXuydTgF+CGmNW
G8+pAsTjVGcud28E4/qnVKCw52kSP8qBaA9Ap1MfMEKJ1uYrUdGIuWjOGHsIESHq
P7+w1NpQgxiB/m0kpVfjmhMLw52u2RyFePgnEBseynZXHuPUcnldmh7cT5YvJ002
dCboGzTsMJHhb8AKBnyLXzypU5Hb/cStq9/CdEWJutGPsTVAV88PyYwgQpq3huHt
EG75dY8whbFJb3681f8MJjnl2wxzmw==
=tPu3
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
