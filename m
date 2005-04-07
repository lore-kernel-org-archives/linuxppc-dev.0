Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id EF08B67B33
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 10:09:37 +1000 (EST)
Message-ID: <42547A39.4060001@nortel.com>
Date: Wed, 06 Apr 2005 18:09:29 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <425429BF.1050706@nortel.com> <1112829596.9518.210.camel@gaston>	
	<42547112.9000302@nortel.com> <1112831363.9518.215.camel@gaston>	
	<4254771B.2070802@nortel.com> <1112831823.9568.219.camel@gaston>
In-Reply-To: <1112831823.9568.219.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: question on inline assembly and long long values
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2005-04-06 at 17:56 -0600, Chris Friesen wrote:
>>Benjamin Herrenschmidt wrote:
>>>But the kernel code always runs in 64 bits mode...
>>
>>The ppc kernel (not ppc64) runs in 64-bit mode?  An unsigned long long 
>>fits in a single register in C code?
> 
> Ah no, it doesn't, but then, be careful to have interrupts off when you
> do that are the interrupt handler won't save the high half of the
> registers between the mtmsrd and your "splitting" of it.

Right.  All this stuff is running with interrupts off.

Chris
