Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C278ADE0A0
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 06:37:16 +1000 (EST)
Message-Id: <DD3EF5A2-E154-4E31-8729-1FB630BB9B25@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1240242875-3247-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: don't disable SATA interrupts on Freescale
	MPC8610 HPCD
Date: Tue, 21 Apr 2009 15:35:09 -0500
References: <1240242875-3247-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2009, at 10:54 AM, Timur Tabi wrote:

> The ULI 1575 PCI quirk function for the Freescale MPC8610 HPCD was  
> disabling
> the SATA INTx interrupt, even when SATA support was enabled.  This  
> was safe,
> because the SATA driver re-enabled it.  But with commit a5bfc471  
> ("ahci: drop
> intx manipulation on msi enable"), the driver no longer does this,  
> and so SATA
> support on the 8610 HPCD is broken.
>
> The original quirk function disabled INTx because it caused some other
> interrupt problem during early development on this board, but no one  
> remembers
> any more what that problem was, and it doesn't seem to occur any more.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/fsl_uli1575.c |    5 -----
> 1 files changed, 0 insertions(+), 5 deletions(-)


applied to merge.

- k
