Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86E5FB6F5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 13:00:24 +1000 (EST)
Subject: Re: linux-next: build failure after merge of the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20110701113942.5cfed9a3.sfr@canb.auug.org.au>
References: <20110701113942.5cfed9a3.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jul 2011 13:00:12 +1000
Message-ID: <1309489212.14501.237.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-01 at 11:39 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> arch/powerpc/include/asm/setup.h: Assembler messages:
> arch/powerpc/include/asm/setup.h:6: Error: Unrecognized opcode: `extern'
> make[2]: *** [arch/powerpc/kernel/head_64.o] Error 1
> 
> Caused by commit a9c0f41b3a64 ("powerpc: Add printk companion for
> ppc_md.progress").  Clearly not build tested for 64 but powerpc :-(
> 
> I have used the version of the powerpc tree from next-20110630 for today.

Crap !

I had fixed that locally, and ... forgot to commit --amend before
pushing it.

I'll stick a fixup patch right next to it.

Cheers,
Ben.
