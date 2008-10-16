Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CDC1DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 21:39:37 +1100 (EST)
Date: Thu, 16 Oct 2008 12:39:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next:  build failure
Message-ID: <20081016103916.GA30745@elte.hu>
References: <20081016202907.978d00b1.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081016202907.978d00b1.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
	linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next build (powerpc allyesconfig) failed like this:
> 
> In file included from arch/powerpc/include/asm/mmu-hash64.h:17,
>                  from arch/powerpc/include/asm/mmu.h:8,
>                  from arch/powerpc/include/asm/pgtable.h:8,
>                  from arch/powerpc/mm/slb.c:20:
> arch/powerpc/include/asm/page.h:76: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'memstart_addr'
> arch/powerpc/include/asm/page.h:77: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'kernstart_addr'
> 
> Caused by commit 600715dcdf567c86f8b2c6173fcfb4b873e25a19 ("generic: add
> phys_addr_t for holding physical addresses") from the tip-core tree.
> This only fails if CONFIG_RELOCATABLE is set.
> 
> I have applied the patch below.

applied to tip/core/urgent, thanks Stephen!

	Ingo
