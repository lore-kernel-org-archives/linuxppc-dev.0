Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E70A1A07DB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:21:24 +1100 (AEDT)
In-Reply-To: <20150821110515.94DBB1A241A@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: Shorten irq_chip name for the SIU
Message-Id: <20151012112123.D420814027C@ozlabs.org>
Date: Mon, 12 Oct 2015 22:21:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-21-08 at 11:05:15 UTC, Christophe Leroy wrote:
> show_interrupts() expects the irq_chip name to be max 8 characters
> otherwise everything get misaligned
> 
> # cat /proc/interrupts
>            CPU0
>  17:          0   CPM PIC   0 Level     error
>  19:          0  MPC8XX SIU  15 Level     tbint
>  20:         90   CPM PIC   4 Level     cpm_uart
>  38:      29746  MPC8XX SIU   5 Level     fs_enet-mac
>  39:          0  MPC8XX SIU   7 Level     fs_enet-mac
>  47:        401   CPM PIC   5 Level     fsl_spi
>  68:          1  MPC8XX SIU   2 Level     phy_interrupt, phy_interrupt, phy_interrupt
> LOC:    7225485   Local timer interrupts for timer event device
> LOC:          9   Local timer interrupts for others
> SPU:          0   Spurious interrupts
> PMI:          0   Performance monitoring interrupts
> MCE:          0   Machine check exceptions
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/255e8e046c3925ee45a86946

cheers
