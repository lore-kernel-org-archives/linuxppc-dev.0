Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0CE222C00D8
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2012 00:08:04 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/86xx: fsl_pcibios_fixup_bus requires
 CONFIG_PCI
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1350330741-11390-2-git-send-email-timur@freescale.com>
Date: Sun, 25 Nov 2012 07:07:35 -0600
Message-Id: <E39D0E6D-C855-44C3-B8DB-FBF044CCA4D6@kernel.crashing.org>
References: <1350330741-11390-1-git-send-email-timur@freescale.com>
 <1350330741-11390-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: paul.gortmaker@windriver.com, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 15, 2012, at 2:52 PM, Timur Tabi wrote:

> Function fsl_pcibios_fixup_bus() is available only if PCI is enabled.  The
> MPC8610 HPCD platform file was not protecting the assigned with an #ifdef,
> which results in a link failure when PCI is disabled.  Every other platform
> already has this #ifdef.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)

applied to next

- k
