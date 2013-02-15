Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D4F2E2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 07:14:27 +1100 (EST)
Subject: Re: [linuxppc-dev][PATCH] powerpc/fsl_pci: Store the pci controller
 device pointer in the pci controller structure.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1358162880-16012-1-git-send-email-Varun.Sethi@freescale.com>
Date: Fri, 15 Feb 2013 14:14:29 -0600
Message-Id: <D7E51DF1-07FC-4D38-A762-989BAEF31FF0@kernel.crashing.org>
References: <1358162880-16012-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 14, 2013, at 5:28 AM, Varun Sethi wrote:

> The pci controller structure has a provision to store the device =
strcuture
> pointer of the corresponding platform device. Currently this =
information is
> not stored during fsl pci controller initialization. This information =
is
> required while dealing with iommu groups for pci devices connected to =
the fsl
> pci controller. For the case where the pci devices can't be =
paritioned, they=20
> would fall under the same device group as the pci controller.
>=20
> This patch stores the platform device information in the pci =
controller
> structure during initialization.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |    9 +++++++--
> arch/powerpc/sysdev/fsl_pci.h |    2 +-
> 2 files changed, 8 insertions(+), 3 deletions(-)

applied to next

- k=
