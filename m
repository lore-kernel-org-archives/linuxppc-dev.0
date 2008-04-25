Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34D81DE558
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 23:37:13 +1000 (EST)
Message-Id: <21BCF98A-DE5B-4F5C-8A8B-EC2EB07458FE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209128614.5420.6.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [RFC][WIP][PATCH] Add IRQSTACKS to ppc32
Date: Fri, 25 Apr 2008 08:37:02 -0500
References: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
	<20080425072332.GB23053@lst.de> <1209128614.5420.6.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2008, at 8:03 AM, Benjamin Herrenschmidt wrote:
>
> On Fri, 2008-04-25 at 09:23 +0200, Christoph Hellwig wrote:
>> On Thu, Apr 24, 2008 at 12:37:50AM -0500, Kumar Gala wrote:
>>> config IRQSTACKS
>>> 	bool "Use separate kernel stacks when processing interrupts"
>>> -	depends on PPC64
>>
>> Why do we have this as a user-selectable option?  It should be on by
>> default on 32 or 64bit.
>
> History maybe ? In the early days it was a bit "experimental" (we  
> had a
> couple of issues that popped up with some thread flags not being
> properly recovered etc...). Nowadays, I agree it should not be an
> option.

for some reason I felt that it was pretty much required on ppc64 when  
I did the port over to ppc32.

Do we think we want to poke Paul to get this in for v2.6.26 so we can  
get it some more testing on all the ppc32 systems?

- k
