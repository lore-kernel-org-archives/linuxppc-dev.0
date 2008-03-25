Return-Path: <tytso@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C37EDDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 01:01:03 +1100 (EST)
Date: Tue, 25 Mar 2008 09:54:54 -0400
From: Theodore Tso <tytso@MIT.EDU>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] ppc: Export empty_zero_page
Message-ID: <20080325135454.GK30110@mit.edu>
References: <E1JZGwo-0000vf-2v@closure.thunk.org>
	<20080312034110.GT6887@bakeyournoodle.com>
	<20080312144239.GY15804@mit.edu> <20080312202431.GG15804@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080312202431.GG15804@mit.edu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So I screwed this one up.  Mea culpa, mea culpa, mea maxima culpa....

I assume Stephen's already sent this to patch to you guys (I picked it
up from the linux-next git tree), but just in case he didn't....

						- Ted


>From 7919d4874fe991abd0b686ac1f68131c818cdb36 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 13 Mar 2008 16:16:10 +1100
Subject: [PATCH] really export empty_zero_page

It was being protected by CONFIG_PPC32.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/ppc_ksyms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 65d14e6..1e89eb5 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -57,7 +57,6 @@ extern void program_check_exception(struct pt_regs *regs);
 extern void single_step_exception(struct pt_regs *regs);
 extern int sys_sigreturn(struct pt_regs *regs);
 
-EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
@@ -191,3 +190,4 @@ EXPORT_SYMBOL(intercept_table);
 EXPORT_SYMBOL(__mtdcr);
 EXPORT_SYMBOL(__mfdcr);
 #endif
+EXPORT_SYMBOL(empty_zero_page);
-- 
1.5.4.1.144.gdfee-dirty
