Return-Path: <R65777@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3416DB6FF5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 20:47:23 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH 0/6] Description for PCI patches using platform driver
Date: Fri, 8 Jun 2012 10:47:12 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03D71F38@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1339148527-16911-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1339148527-16911-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Friday, June 08, 2012 3:12 PM
> To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> Cc: Li Yang-R58472; benh@kernel.crashing.org; Wood Scott-B07421; Bhushan =
Bharat-
> R65777; Jia Hongtao-B38951
> Subject: [PATCH 0/6] Description for PCI patches using platform driver
>=20
> This series of patches are to unify pci initialization code and add PM su=
pport
> for all 85xx/86xx powerpc boards. But two side effects are introduced by =
this
> mechanism which listed below:
>=20
> 1. of_platform_bus_probe() will be called twice but in some cases duplica=
tion
>    warning occured. We fix this in [PATCH 5/6].
>=20
> 2. Edac driver failed to register pci nodes as platform devices. We fix t=
his
>    in [PATCH 6/6].

With these patches will not the SWIOTLB will not be initialized even if PCI=
/PCIe demanded?

Thanks
-Bharat

>=20
> These patches are against 'next' branch on:
> http://git.kernel.org/?p=3Dlinux/kernel/git/galak/powerpc.git
