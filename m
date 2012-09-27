Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 976BE2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 22:33:07 +1000 (EST)
Subject: Re: [PATCH][v2] powerpc/fsl-pci: use 'Header Type' to identify PCIE
 mode
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1348465852-6507-1-git-send-email-Minghuan.Lian@freescale.com>
Date: Thu, 27 Sep 2012 07:33:08 -0500
Message-Id: <8BCDA75C-2454-4301-B40F-86E5AC023FD3@kernel.crashing.org>
References: <1348465852-6507-1-git-send-email-Minghuan.Lian@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 24, 2012, at 12:50 AM, Minghuan Lian wrote:

> The original code uses 'Programming Interface' field to judge if PCIE =
is
> EP or RC mode, however, some latest silicons do not support this =
functionality.
> According to PCIE specification, 'Header Type' offset 0x0e is used to
> indicate header type, so change code to use 'Header Type' field to
> judge PCIE mode. Because FSL PCI controller does not support 'Header =
Type',
> patch still uses 'Programming Interface' to identify PCI mode.
>=20
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> Change log:
> v2 -=20
> keep the original PCI initialization order according to kumar's =
recommendations.
>=20
> arch/powerpc/sysdev/fsl_pci.c |   37 =
++++++++++++++++++++++++-------------
> 1 file changed, 24 insertions(+), 13 deletions(-)

applied to next

- k=
