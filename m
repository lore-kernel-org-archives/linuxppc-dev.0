Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8C78568890
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2005 13:45:39 +1100 (EST)
Date: Sun, 11 Dec 2005 18:45:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20051211184520.7f565283.akpm@osdl.org>
In-Reply-To: <1134353605.6989.69.camel@gaston>
References: <1134353605.6989.69.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix clock spreading setting on some powermacs
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
> The code that sets the clock spreading feature of the Intrepid ASIC
>  must not be run on some machine models or those won't boot. This
>  fixes it.

I have a bunch of powerpc fixes for 2.6.15, some of which are in Paul's
tree.  I presently have:

powerpc-fix-a-huge-page-bug.patch
powerpc-remove-debug-code-in-hash-path.patch
fix-windfarm-model-id-table.patch
powerpc-set-cache-info-defaults.patch
powerpc-fix-slb-flushing-path-in-hugepage.patch
powerpc-add-missing-icache-flushes-for-hugepages.patch
ppc32-set-smp_tb_synchronized-on-up-with-smp-kernel.patch

Linus is back online now.  Paul, do you intend to send a batch to Linus? 
If so, please do so asap so I can merge up anything that's left over.
