Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22FDB67B20
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 23:11:28 +1100 (EST)
In-Reply-To: <20060323210357.GC24667@suse.de>
References: <20060304191026.GA9815@suse.de>
	<200603061212.12815.michael@ellerman.id.au>
	<20060306073834.GA24869@suse.de>
	<590CA2B3-AACE-4B69-930D-9A66A42FFC83@kernel.crashing.org>
	<20060306074339.GC24869@suse.de>
	<1912CD56-027C-491D-B2A2-EA44AB4DDD14@kernel.crashing.org>
	<20060306074953.GE24869@suse.de>
	<EA07A673-A993-490A-ADEC-29CFDF1DDAC1@kernel.crashing.org>
	<20060323210357.GC24667@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D857A5CA-8D59-4047-AFAF-35FC421FDEE2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] return to OF via trap, not exit
Date: Fri, 24 Mar 2006 13:13:43 +0100
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

On 23-mrt-2006, at 22:03, Olaf Hering wrote:
>  On Mon, Mar 06, Segher Boessenkool wrote:
>> That's better than always calling trap, sure.  Is there any reason
>> you can't just do it on Macs though?  Because the problem you're  
>> trying
>> to work around only happens there.
>
> Maybe something like this? Only compile tested

That looks fine yes (if it runs ;-) ), thanks!

> Do not call prom exit prom_panic. It clears the screen and the exit  
> message is lost.
> On some (or all?) pmacs it causes another crash when OF tries to  
> print the
> date and time in its banner.
>
> Set of_platform earlier to catch more prom_panic() calls.
>
> Signed-off-by: Olaf Hering <olh@suse.de>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
