Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BEE1FDE4CA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:37:42 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n07EZK56001056
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 07:35:20 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n07EbcdZ105368
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 07:37:38 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n07Ebcqm005390
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 07:37:38 -0700
Date: Wed, 7 Jan 2009 09:37:24 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix missing semicolons in mmu_decl.h
Message-ID: <20090107143724.GF17171@zod.rchland.ibm.com>
References: <20090107035702.C9114474D7@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090107035702.C9114474D7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 02:56:51PM +1100, Benjamin Herrenschmidt wrote:
>This is a brown paper bag from one of my earlier patches that
>breaks build on 40x and 8xx.
>
>And yes, I've now added 40x and 8xx to my list of test configs :-)
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Please get it into your tree so people stop emailing me about it
being broken :).

josh

>---
>
> arch/powerpc/mm/mmu_decl.h |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2009-01-07 14:52:33.000000000 +1100
>+++ linux-work/arch/powerpc/mm/mmu_decl.h	2009-01-07 14:52:43.000000000 +1100
>@@ -30,11 +30,11 @@
> #if defined(CONFIG_40x) || defined(CONFIG_8xx)
> static inline void _tlbil_all(void)
> {
>-	asm volatile ("sync; tlbia; isync" : : : "memory")
>+	asm volatile ("sync; tlbia; isync" : : : "memory");
> }
> static inline void _tlbil_pid(unsigned int pid)
> {
>-	asm volatile ("sync; tlbia; isync" : : : "memory")
>+	asm volatile ("sync; tlbia; isync" : : : "memory");
> }
> #else /* CONFIG_40x || CONFIG_8xx */
> extern void _tlbil_all(void);
>@@ -47,7 +47,7 @@ extern void _tlbil_pid(unsigned int pid)
> #ifdef CONFIG_8xx
> static inline void _tlbil_va(unsigned long address, unsigned int pid)
> {
>-	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory")
>+	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
> }
> #else /* CONFIG_8xx */
> extern void _tlbil_va(unsigned long address, unsigned int pid);
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
