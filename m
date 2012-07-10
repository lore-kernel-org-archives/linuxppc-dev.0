Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A20852C020B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 21:44:17 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/fsl: Update corenet64_smp_defconfig
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341916802-19619-2-git-send-email-Shengzhou.Liu@freescale.com>
Date: Tue, 10 Jul 2012 06:44:13 -0500
Message-Id: <F985F265-DA57-47F9-AB53-4A889929BF7A@kernel.crashing.org>
References: <1341916802-19619-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1341916802-19619-2-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: Harninder Rai <harninder.rai@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Minghuan Lian <Minghuan.Lian@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 5:40 AM, Shengzhou Liu wrote:

> * Enable USB, MMC, SATA, MTD, NAND, PAMU, RTC
> * Enable FSL RAID on P5020
> * Enable general RAID features (MD + async-tx)
> * Enable RTC on P2041RDB
> * Enable UIO SRIO & UIO DMA
> * Enable USDPAA SHMEM driver
> * Enable ePAPR HV support
> * Enable PCI-E support
>=20
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> arch/powerpc/configs/corenet64_smp_defconfig |   94 =
++++++++++++++++++++++++--
> 1 files changed, 89 insertions(+), 5 deletions(-)

Is this patch really against upstream?  We dont have PAMU, UIO =
SRIO/DMA,etc upstream.

- k=
