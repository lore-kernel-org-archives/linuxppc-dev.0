Return-Path: <akpm@osdl.org>
Received: from mail.osdl.org (fw.osdl.org [65.172.181.6])
	by ozlabs.org (Postfix) with ESMTP id 9B53667A90
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 17:15:14 +1100 (EST)
Date: Tue, 25 Jan 2005 22:15:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20050125221517.6ec13d0f.akpm@osdl.org>
In-Reply-To: <1106696607.6249.18.camel@gaston>
References: <1106696607.6249.18.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, luther@gluck.debian.org
Subject: Re: [PATCH] ppc32: (Updated) Pegasos support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>  Here's an updated version of the pegasos support patch for ppc32, fixing
>  a typo in the previous one.

I already sent the first version to Linus.  That's reason 42 for preferring
incremental diffs ;)


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Here's an updated version of the pegasos support patch for ppc32, fixing a
typo in the previous one.  Driver patches to come soon.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/platforms/chrp_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc/platforms/chrp_pci.c~ppc32-updated-pegasos-support arch/ppc/platforms/chrp_pci.c
--- 25/arch/ppc/platforms/chrp_pci.c~ppc32-updated-pegasos-support	2005-01-25 22:14:12.685346992 -0800
+++ 25-akpm/arch/ppc/platforms/chrp_pci.c	2005-01-25 22:14:12.688346536 -0800
@@ -304,6 +304,6 @@ chrp_find_bridges(void)
 	}
 
 	/* Do not fixup interrupts from OF tree on pegasos */
-	if (is_pegasos != 0)
+	if (is_pegasos == 0)
 		ppc_md.pcibios_fixup = chrp_pcibios_fixup;
 }
_
