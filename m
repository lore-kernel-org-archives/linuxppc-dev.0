Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D33567B7A
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2006 18:57:22 +1100 (EST)
In-Reply-To: <20060306074953.GE24869@suse.de>
References: <20060304191026.GA9815@suse.de>
	<200603061212.12815.michael@ellerman.id.au>
	<20060306073834.GA24869@suse.de>
	<590CA2B3-AACE-4B69-930D-9A66A42FFC83@kernel.crashing.org>
	<20060306074339.GC24869@suse.de>
	<1912CD56-027C-491D-B2A2-EA44AB4DDD14@kernel.crashing.org>
	<20060306074953.GE24869@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EA07A673-A993-490A-ADEC-29CFDF1DDAC1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] return to OF via trap, not exit
Date: Mon, 6 Mar 2006 08:57:42 +0100
To: Olaf Hering <olh@suse.de>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Can you do anything at that time anyway? I mean, reset-all pending
>>> either way.
>>
>> You can boot a different kernel, or try to work out what went wrong.
>
> No, I cant, all resources are possible busy.

That's a separate bug.  What resources do you see busy?  Allocated
memory, I/O devices?

> Either way, maybe checking
> what type stdout is and trap or exit depending on that.

That's better than always calling trap, sure.  Is there any reason
you can't just do it on Macs though?  Because the problem you're trying
to work around only happens there.

> And I dont see whats bad about 'trap handler called', other than being
> verbose.

Too verbose -- it prints useless information, and the actual error
message might scroll away.  No biggie of course, but why do the
workaround when not needed?


Segher
