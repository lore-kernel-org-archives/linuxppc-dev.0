Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0726CB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 13:12:40 +1000 (EST)
Subject: Re: [PATCH -v2 0/7] powerpc: use asm-generic/dma-mapping-common.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090813085505.GA10671@elte.hu>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1250142522.3587.110.camel@pasglop>
	<20090813160625B.fujita.tomonori@lab.ntt.co.jp>
	<20090813074131.GH12143@elte.hu> <1250150981.3587.157.camel@pasglop>
	<20090813085505.GA10671@elte.hu>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 13:12:15 +1000
Message-Id: <1251342735.20467.2.camel@pasglop>
Mime-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	galak@kernel.crashing.orga
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-13 at 10:55 +0200, Ingo Molnar wrote:

> Ok! We could also stage it a bit (one or two weeks) in a separate 
> branch and allow a rebase, should you find any bugs during testing?

Allright so after various delays and sidetracking on my side, the
patches have been in my -test branch for long enough, I'm happy for them
to go in either way now.

I'm going to take them out of powerpc test for now and not put them in
my -next right away until I'm sure I have the right source to pull, at
which point I can just put from tip iommu.

Cheers,
Ben.
