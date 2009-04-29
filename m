Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC168DDF6B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 22:48:21 +1000 (EST)
Message-Id: <C9C597A9-3096-4BF1-8559-15FADFB2AEAD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20090429114448.GA13129@lst.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/6] powerpc: Move #ifdef'ed body of do_IRQ() into a
	separate function
Date: Wed, 29 Apr 2009 07:48:04 -0500
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
	<20090425181823.GA10481@lst.de>
	<1240879747.11027.2.camel@localhost>
	<20090429114448.GA13129@lst.de>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2009, at 6:44 AM, Christoph Hellwig wrote:

> On Tue, Apr 28, 2009 at 10:49:07AM +1000, Michael Ellerman wrote:
>> On Sat, 2009-04-25 at 20:18 +0200, Christoph Hellwig wrote:
>>> On Thu, Apr 23, 2009 at 11:31:37AM +1000, Michael Ellerman wrote:
>>>> +#ifdef CONFIG_IRQSTACKS
>>>
>>> Wasn't there a plan to make CONFIG_IRQSTACKS the unconditional  
>>> default?
>>
>> Not sure. Looks like the 64-bit configs all turn it on, and all but  
>> one
>> or two of the 32-bit configs don't.
>
> Yeah, but do they have a reason not to turn it on?  Having irqstacks
> is a lot safer than no having it because the stack useage is a lot  
> more
> predictable.  And not having to maintain two codepathes is also a
> benefit all by itself.

I think Ben, Paul and I had discussed just universally enabling it.   
Can't remember why Ben hadn't done that yet.

- k
