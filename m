Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5FC1B2C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 23:36:59 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: enable Silicon image 3132 PCIe to SATA
 controller
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365633649-27046-1-git-send-email-scottwood@freescale.com>
Date: Thu, 11 Apr 2013 08:34:07 -0500
Message-Id: <0B8E67FE-16DE-4577-8CEF-D74C2D55A550@kernel.crashing.org>
References: <1365633649-27046-1-git-send-email-scottwood@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 10, 2013, at 5:40 PM, Scott Wood wrote:

> From: Roy ZANG <tie-fei.zang@freescale.com>
> 
> Some 85xx board, for example, P1020RDB-PC has on board silicon image
> PCIe to SATA controller and when booting up, the filesystem will auto mount
> to the SATA disk. So enable silicon image 3132 pcie to sata controller
> by default
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/configs/mpc85xx_defconfig     |    1 +
> arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
> 2 files changed, 2 insertions(+)

applied to next

- k
