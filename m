Return-Path: <R1AAHA@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8F5B2C0106
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 02:34:03 +1000 (EST)
Date: Mon, 15 Apr 2013 11:30:17 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: fix usage of setup_pci_atmu()
Message-ID: <20130415113017.69fd8dacd93264b9c9b54001@freescale.com>
In-Reply-To: <5881.1366004521@ale.ozlabs.ibm.com>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
 <5881.1366004521@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 15 Apr 2013 15:42:01 +1000
Michael Neuling <mikey@neuling.org> wrote:

> Linux next is currently failing to compile mpc85xx_defconfig with:
>   arch/powerpc/sysdev/fsl_pci.c:944:2: error: too many arguments to function 'setup_pci_atmu'
> 
> This is caused by (from Kumar's next branch):
>   commit 34642bbb3d12121333efcf4ea7dfe66685e403a1
>   Author: Kumar Gala <galak@kernel.crashing.org>
>   powerpc/fsl-pci: Keep PCI SoC controller registers in pci_controller
> 
> Which changed definition of setup_pci_atmu() but didn't update one of
> the callers.  Below fixes this.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Kumar: this is for your next tree

Reviewed-by: Kim Phillips <kim.phillips@freescale.com>

Thanks,

Kim
