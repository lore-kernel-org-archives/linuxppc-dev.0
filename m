Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AB5C82C01CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 22:57:23 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/fsl: Update corenet32_smp_defconfig
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342003205-23378-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Wed, 11 Jul 2012 07:57:17 -0500
Message-Id: <57C63D0D-4190-4EEA-83AD-0952F2CBA93E@kernel.crashing.org>
References: <1342003205-23378-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 11, 2012, at 5:40 AM, Shengzhou Liu wrote:

> - Enable NAND support
> - Enable CONFIG_PCI_MSI and CONFIG_MMC_SDHCI_OF
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> arch/powerpc/configs/corenet32_smp_defconfig |    8 ++++++++
> 1 files changed, 8 insertions(+), 0 deletions(-)

applied to next

- k
