Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2CC9BB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 16:52:14 +1000 (EST)
Subject: Re: [PATCH -v2 0/7] powerpc: use asm-generic/dma-mapping-common.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1250142522.3587.110.camel@pasglop>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1250142522.3587.110.camel@pasglop>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 16:51:53 +1000
Message-Id: <1250146313.3587.113.camel@pasglop>
Mime-Version: 1.0
Cc: galak@kernel.crashing.orga, Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org, mingo@elte.hu, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-13 at 16:44 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-08-05 at 14:08 +0900, FUJITA Tomonori wrote:
> 
> > The above swiotlb patchset was merged in -tip so I think that merging
> > this patchset via -tip too is the easiest way to handle this patchset.
> > 
> > The patchset also is available via a git tree:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git powerpc
> 
> Hi !
> 
> While I generally agree here with the patches, I'm not sure it should be
> merged via -tip since it mostly touches arch/powerpc files (and I need
> to review it a bit more carefully, hopefully you'll have Ack's hitting
> your mailbox later today).

Maybe best is that I pull your series too. Note that your patch clashes
with Takashi's addition of dma_mmap_coherent() :

http://patchwork.ozlabs.org/patch/29595/

Can you sort that out with Takashi as I'd like his patch in -next soon
too.

Cheers,
Ben.
