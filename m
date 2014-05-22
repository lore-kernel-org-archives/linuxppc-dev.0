Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE0801A058E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 08:53:11 +1000 (EST)
Date: Thu, 22 May 2014 17:37:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: powerpc: remove checks for CONFIG_BOOK3E_MMU_TLB_STATS
Message-ID: <20140522223758.GA20343@home.buserror.net>
References: <1400608550.4912.48.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1400608550.4912.48.camel@x220>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 20, 2014 at 07:55:50PM +0200, Paul Bolle wrote:
> Three checks for CONFIG_BOOK3E_MMU_TLB_STATS were added in v2.6.32. But
> the related Kconfig symbol was never added. These checks have always
> evaluated to false. Remove them.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> ---
> Untested.
> 
> A second order cleanup is now possible (ie, TLB_MISS_PROLOG_STATS and
> friends are, well, defined away). Perhaps it is preferable to include
> that cleanup in this patch.
> 
>  arch/powerpc/include/asm/exception-64e.h | 38 --------------------------------
>  arch/powerpc/mm/tlb_low_64e.S            | 10 ---------
>  2 files changed, 48 deletions(-)

/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S: Assembler messages:
/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:89: Error: unrecognized opcode: `tlb_miss_prolog_stats'
/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:238: Error: unrecognized opcode: `tlb_miss_prolog_stats'
/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:269: Error: unrecognized opcode: `tlb_miss_prolog_stats'
/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:281: Error: unrecognized opcode: `tlb_miss_prolog_stats'
/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:441: Error: unrecognized opcode: `tlb_miss_prolog_stats'
/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:510: Error: unrecognized opcode: `tlb_miss_prolog_stats'
/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:881: Error: unrecognized opcode: `tlb_miss_prolog_stats'
/home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:918: Error: unrecognized opcode: `tlb_miss_prolog_stats'

-Scott
