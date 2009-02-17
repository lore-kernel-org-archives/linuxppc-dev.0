Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8AFCDDDA9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 01:43:14 +1100 (EST)
Message-Id: <22854A2F-2FBD-4F1A-B623-DB5C91E97509@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <2a27d3730902170638h43724c03k6b50843158842e1e@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] fix the interrupt loss problem on powerpc IPIC (2.6.23)
Date: Tue, 17 Feb 2009 08:43:03 -0600
References: <D728AD1FA2543948B89DE29C5BF4CD0716AC2DDE@bjmail1.bj.datangmobile.com>
	<76C7F485-EF75-4B83-B673-564E6243C7C6@kernel.crashing.org>
	<2a27d3730902170638h43724c03k6b50843158842e1e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, "<dayu@datangmobile.cn>" <dayu@datangmobile.cn>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 17, 2009, at 8:38 AM, Li Yang wrote:

> On Tue, Feb 17, 2009 at 10:12 PM, Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> On Feb 17, 2009, at 6:44 AM, <dayu@datangmobile.cn> <dayu@datangmobile.cn 
>> >
>> wrote:
>>
>>> From: Da Yu <dayu@datangmobile.cn>
>>> Date: Tue, 17 Feb 2009 19:58:20 +0800
>>> Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC  
>>> (2.6.23)
>>>
>>> Signed-off-by: Da Yu <dayu@datangmobile.cn>
>>> ---
>>
>> Please provide a bit more description as to why this fixes the issue.
>
> The pending register is write 1 clear.  If there are more than one
> external interrupts pending at the same time, acking the first
> interrupt will also clear other interrupt pending bits.  That will
> cause loss of interrupt.
>
> - Leo

Thanks.  That should be included in the commit message.

- k
