Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6B2F5B7B99
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 18:08:14 +1000 (EST)
Subject: Re: [PATCH -v2 0/7] powerpc: use asm-generic/dma-mapping-common.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h4osc429m.wl%tiwai@suse.de>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1250142522.3587.110.camel@pasglop> <1250146313.3587.113.camel@pasglop>
	<s5h4osc429m.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 18:07:57 +1000
Message-Id: <1250150877.3587.155.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-13 at 09:11 +0200, Takashi Iwai wrote:
> I'm willing to rebase my patches to the generic dma_ops, so feel free
> to pull it first.

I think I'll end up pulling Ingo's iommu branch into powerpc-next to
get Fujita stuff, so if you rebase on top of his stuff, it will come
along just fine.

> It might need to add mmap_coherent op to all platforms when generic
> dma ops is used.  This would be more volume but less hackish than the
> previous version, OTOH :)
> 
Right :-)

Cheers,
Ben.
