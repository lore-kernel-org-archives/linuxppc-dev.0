Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE743DF47C
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:21:02 +1000 (EST)
In-Reply-To: <5bba19e33a518178eb46f2a1758cff40@kernel.crashing.org>
References: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
	<20070911141711.GE1932@ld0162-tx32.am.freescale.net>
	<1DE5CB62-9EF1-42BA-93F3-CE15DD94F5DD@kernel.crashing.org>
	<6b92503d73565f8add983e64ad5d5d39@kernel.crashing.org>
	<A78D5AE1-8578-4971-800E-7209258365F1@kernel.crashing.org>
	<5bba19e33a518178eb46f2a1758cff40@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C5470240-1B7C-4AE2-912B-62B280C0904E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Thu, 13 Sep 2007 16:23:50 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2007, at 11:53 AM, Segher Boessenkool wrote:

>>> What is a "front side cache"?  What exactly does it cache?  If it's
>>> a cache for one CPU only, that fact should be shown in the device
>>> tree somehow.
>>
>> Its in front of the memory controllers.  Its not specific to a  
>> given CPU.
>
> Ah, I see.  That relationship is implicit in the device tree already,
> both this cache controller and that memory controller are child nodes
> of the same soc node, so your device tree is fine.
>
> Just for my own understanding, is this a coherent cache?  (I'm too
> lazy to read the manual ;-) )

yes its coherent.  Our caches tend to be coherent.

- k
