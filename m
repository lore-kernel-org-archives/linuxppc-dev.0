Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D9F9DE3EB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 00:32:51 +1000 (EST)
Date: Wed, 23 Apr 2008 16:32:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: new warnings from stacktrace patch
Message-ID: <20080423143229.GA18667@lst.de>
References: <20080423175938.a4b3cc26.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080423175938.a4b3cc26.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 23, 2008 at 05:59:38PM +1000, Stephen Rothwell wrote:
> This is from commit fd3e0bbc6052ca9747a5332b382584ece83aab6d ("[POWERPC]
> Stacktrace support for lockdep").  We don't include asm-offsets.h in any
> other C file in the powerpc build.

I think the include can be safely removed.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/kernel/stacktrace.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/stacktrace.c	2008-04-23 15:28:05.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/stacktrace.c	2008-04-23 15:28:16.000000000 +0200
@@ -13,7 +13,6 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 #include <asm/ptrace.h>
-#include <asm/asm-offsets.h>
 
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
