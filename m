Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 325FDDDFE8
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 02:49:43 +1000 (EST)
In-Reply-To: <1178158307.17299.55.camel@localhost.localdomain>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
	<17977.9796.15991.630737@cargo.ozlabs.ibm.com>
	<f885d6b1472525fb5bebdd96ae4c3157@kernel.crashing.org>
	<1178151690.17299.46.camel@localhost.localdomain>
	<15a6025d58d0f62ee10efab20dc98278@kernel.crashing.org>
	<1178158307.17299.55.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3796663898c24f426d39466404271eb2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
Date: Thu, 3 May 2007 18:49:00 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Isn't it just a GPIO, like on older Macs?  Of course, we
>> cannot bring a CPU back online after doing that so it's
>> pretty useless I suppose.
>
> We don't know for sure what the gpio does... wether it does a CPU soft
> reset or tickles the SPU to make it do special things that cause us to
> branch at 0x100. We do get the CPU back after that though. We use that
> to bring them in after boot.

Yeah.  It's probably the SRESET pin, come to think of it.

It doesn't seem logical that this would save more power
than (deep) NAP mode, so forget the whole idea.  Or
someone could measure it if they think it might help
still.


Segher
