Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblG554fhzDqvB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:13 +1100 (AEDT)
In-Reply-To: <20171102174936.7cc061cc@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: build failure after merge of the powerpc tree
Message-Id: <3yblG540Dpz9sRg@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-02 at 06:49:36 UTC, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc64
> allnoconfig) failed like this:
> 
> arch/powerpc/kernel/irq.o: In function `.replay_system_reset':
> irq.c:(.text+0x10): undefined reference to `.ppc_save_regs'
> 
> Caused by commit
> 
>   78adf6c214f0 ("powerpc/64s: Implement system reset idle wakeup reason")
> 
> I have applied the following fix patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 2 Nov 2017 17:45:18 +1100
> Subject: [PATCH] powerpc/64s: ppc_save_regs is now needed for all 64s builds
> 
> Fixes: 78adf6c214f0 ("powerpc/64s: Implement system reset idle wakeup reason")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fc2a5a6161a26b386eb0936b74a852

cheers
