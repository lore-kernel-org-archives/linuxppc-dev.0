Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DF65DDF06
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 03:09:54 +1100 (EST)
Message-Id: <54AD0075-E36B-4A95-BFD9-C750E590513F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <479DFA0A.1060706@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 0/9] 83xx DTS fixes and v1 conversions
Date: Mon, 28 Jan 2008 10:09:43 -0600
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<Pine.LNX.4.64.0801280904310.19922@blarg.am.freescale.net>
	<479DFA0A.1060706@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 28, 2008, at 9:51 AM, Paul Gortmaker wrote:

> Kumar Gala wrote:
>> On Mon, 28 Jan 2008, Paul Gortmaker wrote:
>>
>>
>>> This series incorporates my earlier qe/muram fix before converting
>>> the existing mpc83xx DTS files to v1 format.  I've also redone the
>>> mpc834x_mds with the IRQs as decimal as per Kumar's comments and
>>> re-included that too.  I've kept each board as a separate commit
>>> in case one of them conflicts with what someone else is working on.
>>>
>>> Boards covered are: 8349mds, 8349mitx, 8349mitx-gp, 836x_mds,
>>> 8323_mds, 8323_rdb, and the 8313_rdb.  Plus a small tweak to the
>>> sbc8349 (it was already v1 -- but IRQs were in hex.)
>>>
>>> I've fed all the files to DTC before and after to ensure the
>>> output is the same after the conversion.
>>>
>>> I'm not aware of any explicit rules for what is hex vs decimal.
>>> I've tried to keep things that are usually discussed in decimal
>>> as decimal quantities (i.e. cache size, IRQ, counts, indicies)
>>> and all other data that you'd normally expect in hex (addresses,
>>> IRQ flags, masks) as hex -- including prefixing 0x on values from
>>> zero to 10 where it tends to make rows of numbers (e.g. ranges)
>>> align for better readability, even though it isn't required.
>>>
>>>
>>
>> Can you regen these patches (2..9) againast my latest tree.  Also, a
>> single patch that cleans up all the boards is sufficient.
>>
>
> The patches should be current to your tree still as of today; they  
> are based on:
>
> f09f415ea23272ae68f9322f90246680d46f4868        not-for-merge
> branch 'for-2.6.25' of git://git.kernel.org/pub/scm/linux/kernel/git/ 
> galak/powerpc
>
> My patch #1 with all four qe/muram boards was posted earlier here:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050767.html
>
> Let me know what you need them based against and I can respin
> as required.

I've pushed out a bunch of stuff today.

commit 390167efa329d11099957108fc23d1ad15c3f37e

I'm expect a respin since the patches don't currently apply to my tree.

- k
