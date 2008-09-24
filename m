Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3150DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 02:20:50 +1000 (EST)
Message-Id: <E65E6703-BF63-4C1A-AB40-D0BB3012A6DA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1222272084-13012-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v6] POWERPC: Allow 32-bit hashed pgtable code to support
	36-bit physical
Date: Wed, 24 Sep 2008 11:20:41 -0500
References: <1222272084-13012-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2008, at 11:01 AM, Becky Bruce wrote:

> This rearranges a bit of code, and adds support for
> 36-bit physical addressing for configs that use a
> hashed page table.  The 36b physical support is not
> enabled by default on any config - it must be
> explicitly enabled via the config system.
>
> This patch *only* expands the page table code to accomodate
> large physical addresses on 32-bit systems and enables the
> PHYS_64BIT config option for 86xx.  It does *not*
> allow you to boot a board with more than about 3.5GB of
> RAM - for that, SWIOTLB support is also required (and
> coming soon).
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
> This patch depends on Kumar's recent patch
> [PATCH v9 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support -
> we've both made modifications to set_pte_at.

applied to git.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
mmu

- k
