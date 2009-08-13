Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 74447B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 18:55:34 +1000 (EST)
Date: Thu, 13 Aug 2009 10:55:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -v2 0/7] powerpc: use asm-generic/dma-mapping-common.h
Message-ID: <20090813085505.GA10671@elte.hu>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1250142522.3587.110.camel@pasglop>
	<20090813160625B.fujita.tomonori@lab.ntt.co.jp>
	<20090813074131.GH12143@elte.hu>
	<1250150981.3587.157.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250150981.3587.157.camel@pasglop>
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


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Ben, what's your preference? I waited for your reaction with these 
> > bits, i.e. they are not in tip:core/iommu yet.
> 
> Oh I though they were... discard my previous private mail about 
> missing Ack's then :-)
> 
> I'll review them more in depth hopefully tomorrow but they look 
> good.

Sure - take your time.

> > One variant would be what Fujita suggested: you could pull 
> > core/iommu as a basis (it's a well-tested, problem-free tree at 
> > the moment, with no big risky items), and then pull/apply the 
> > powerpc specific bits from Fujita.
> 
> Or we can have the patches in core/iommu and I pull the whole 
> thing in powerpc-next. [...]

Ok! We could also stage it a bit (one or two weeks) in a separate 
branch and allow a rebase, should you find any bugs during testing?

	Ingo
