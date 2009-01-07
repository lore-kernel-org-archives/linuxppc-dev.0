Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D3D6DE5A2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 03:07:15 +1100 (EST)
Message-Id: <EAA6E8B6-668D-4700-A69B-A175B3766B0A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-2-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/5] powerpc: booke: Remove num_tlbcam_entries
Date: Wed, 7 Jan 2009 10:04:58 -0600
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
	<1228793699-23110-2-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 8, 2008, at 9:34 PM, Trent Piepho wrote:

> This is a global variable defined in fsl_booke_mmu.c with a value  
> that gets
> initialized in assembly code in head_fsl_booke.S.
>
> It's never used.
>
> If some code ever does want to know the number of entries in TLB1,  
> then
> "numcams = mfspr(SPRN_TLB1CFG) & 0xfff", is a whole lot simpler than a
> global initialized during kernel boot from assembly.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
> arch/powerpc/kernel/head_fsl_booke.S |    4 ----
> arch/powerpc/mm/fsl_booke_mmu.c      |    1 -
> arch/powerpc/mm/mmu_decl.h           |    2 --
> 3 files changed, 0 insertions(+), 7 deletions(-)

applied to next

- k
