Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ACF13B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 23:31:47 +1000 (EST)
Message-Id: <F7570C22-925A-4B34-AA27-04079071FD07@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1250159900.24143.7.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH -v2 0/7] powerpc: use asm-generic/dma-mapping-common.h
Date: Thu, 13 Aug 2009 08:31:13 -0500
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1250142522.3587.110.camel@pasglop>
	<20090813160625B.fujita.tomonori@lab.ntt.co.jp>
	<20090813074131.GH12143@elte.hu>
	<1250150981.3587.157.camel@pasglop>
	<20090813085505.GA10671@elte.hu> <1250159900.24143.7.camel@pasglop>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 13, 2009, at 5:38 AM, Benjamin Herrenschmidt wrote:

> On Thu, 2009-08-13 at 10:55 +0200, Ingo Molnar wrote:
>
>>> Or we can have the patches in core/iommu and I pull the whole
>>> thing in powerpc-next. [...]
>>
>> Ok! We could also stage it a bit (one or two weeks) in a separate
>> branch and allow a rebase, should you find any bugs during testing?
>
> Sounds like a plan.
>
> I'll try to sort that out tomorrow, I can stick them in my -test  
> branch
> (which is rebase friendly) for a while too.

Getting them all in your -test branch gives Becky and I an opportunity  
to test them w/all the other PPC changes on the platforms we have that  
enable SWIOTLB today.

- k
