Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8AACF1007D2
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 22:05:45 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o59C2OEY018089
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 06:02:25 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o59C5deU045936
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 06:05:40 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o59C5YXS031734
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 06:05:35 -0600
Date: Wed, 9 Jun 2010 08:05:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Christoph Egger <siccegge@cs.fau.de>
Subject: Re: [PATCH 5b/5] Removing dead CONFIG_PPC47x
Message-ID: <20100609120522.GH7801@zod.rchland.ibm.com>
References: <cover.1275925219.git.siccegge@cs.fau.de>
	<20100609110239.GA28290@faui48a.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100609110239.GA28290@faui48a.informatik.uni-erlangen.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	vamos@i4.informatik.uni-erlangen.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 01:02:39PM +0200, Christoph Egger wrote:
>CONFIG_PPC47x should actually be spelled CONFIG_PPC_47x as reported by
>Andreas Schwab.
>
>Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

Thanks, I'll pull this one in and get it merged.

josh

>---
> arch/powerpc/mm/44x_mmu.c |    4 ----
> 1 files changed, 0 insertions(+), 4 deletions(-)
>
>diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
>index d8c6efb..f70da7e 100644
>--- a/arch/powerpc/mm/44x_mmu.c
>+++ b/arch/powerpc/mm/44x_mmu.c
>@@ -76,11 +76,11 @@ static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
> 		"tlbwe	%1,%3,%5\n"
> 		"tlbwe	%0,%3,%6\n"
> 	:
>-#ifdef CONFIG_PPC47x
>+#ifdef CONFIG_PPC_47x
> 	: "r" (PPC47x_TLB2_S_RWX),
> #else
> 	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
> #endif
> 	  "r" (phys),
> 	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
> 	  "r" (entry),
>-- 
>1.6.3.3
>
