Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B0DE9B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 17:07:37 +1000 (EST)
Date: Thu, 13 Aug 2009 16:07:20 +0900
To: benh@kernel.crashing.org, mingo@elte.hu
Subject: Re: [PATCH -v2 0/7] powerpc: use asm-generic/dma-mapping-common.h
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1250142522.3587.110.camel@pasglop>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1250142522.3587.110.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090813160625B.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, galak@kernel.crashing.orga
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 13 Aug 2009 15:48:42 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

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

Thanks!

This patchset depends on my swiotlb cleanup patchset:

git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git swiotlb

http://marc.info/?l=linux-ia64&m=124718816520156&w=2


My swiotlb cleanup patchset has been in -tip. It might be easier to
merge both the swiotlb patchset and this patchset in powerpc tree?
