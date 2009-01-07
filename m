Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1FB2DE358
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 03:06:01 +1100 (EST)
Message-Id: <373CF068-D08F-4AD0-BB67-2AA4E6D354A0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/5] powerpc: booke: Don't hard-code size of struct tlbcam
Date: Wed, 7 Jan 2009 10:03:52 -0600
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
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

> Some assembly code in head_fsl_booke.S hard-coded the size of struct  
> tlbcam
> to 20 when it indexed the TLBCAM table.  Anyone changing the size of  
> struct
> tlbcam would not know to expect that.
>
> The kernel already has a system to get the size of C structures into
> assembly language files, asm-offsets, so let's use it.
>
> The definition of the struct gets moved to a header, so that asm- 
> offsets.c
> can include it.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
> arch/powerpc/kernel/asm-offsets.c    |    8 ++++++++
> arch/powerpc/kernel/head_fsl_booke.S |    2 +-
> arch/powerpc/mm/fsl_booke_mmu.c      |    8 +-------
> arch/powerpc/mm/mmu_decl.h           |    9 +++++++++
> 4 files changed, 19 insertions(+), 8 deletions(-)

applied to next

- k
