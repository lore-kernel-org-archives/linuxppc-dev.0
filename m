Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B068FDDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 06:45:35 +1000 (EST)
Message-Id: <5AB78B49-1033-424C-958D-58E72264AF24@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1220989419-26861-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: fix interrupt values for DMA2 in MPC8610 HPCD
	device tree
Date: Fri, 12 Sep 2008 15:45:27 -0500
References: <1220989419-26861-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 9, 2008, at 2:43 PM, Timur Tabi wrote:

> For Freescale 8xxx devices that use an MPIC, the interrupt numbers  
> in the
> device tree must be 16 greater than the values documented in the  
> reference
> manual.  In these chips, the MPIC is wired to use the first 16  
> numbers for
> external interrupts, but the documentation numbers internal  
> interrupts from 0.
>
> In the MPC8610 HPCD device tree, the interrupt properties for the  
> DMA channels
> for DMA2 were not the adjusted values.  This patch fixes that.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> I have no idea how this was missed for so long, but this patch is a
> must-fix for 2.6.27.
>
> (changes for v2: improve changelog text)
>
> arch/powerpc/boot/dts/mpc8610_hpcd.dts |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)

applied.

- k
