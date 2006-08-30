Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 95B9067B97
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 00:25:17 +1000 (EST)
In-Reply-To: <9mz9np82b.fsf@omoikane.mc.pp.se>
References: <9mz9np82b.fsf@omoikane.mc.pp.se>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3e3f83654b861ae77c6c07cf207ba6af@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] EHCI Oops on CONFIG_NOT_COHERENT_CACHE system
Date: Wed, 30 Aug 2006 09:24:57 -0500
To: Marcus Comstedt <marcus@mc.pp.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Aug 30, 2006, at 7:04 AM, Marcus Comstedt wrote:
> "Gerhard Pircher" <gerhard_pircher at gmx.net> writes:
>> I guess this message should also be forwarded to
>> linux-usb-devel at lists.sourceforge.net. I hope the developers there
>> can make some comments.
>
> Well, I figured the first thing to do would be to reach a consensus
> here on whether or not atomic_t:s in DMA memory should be ruled as
> unallowed.  Judging from the massive silence, there doesn't seem to be
> any strong opinions either way though...

I think its a case of the people that know the architecture agree
that atomics and DMA do not mix, and that this is an issue for
usb-devel to fix.

The other question is: does the current access polute the cache by
reading things where the device is supposed to be writing?

I think some on that list are familiar with the issues for incoherent
DMA, as some of the other usb drivers have been cleaned up in that
regard.

My suggestion is take the issue over there, and only cc us here if
you get pushback over there.

milton
