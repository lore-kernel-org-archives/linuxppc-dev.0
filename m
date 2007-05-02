Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F28D1DDF92
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 03:58:31 +1000 (EST)
In-Reply-To: <1178116438.13233.65.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9e6a5a396bff2c6bc4728c9fa0b1a0c8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
Date: Wed, 2 May 2007 19:57:47 +0200
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Ultimately we want to put the disabled cpus in sleep mode, but that
>> will require a suitable cache flush routine.
>
> I don't have any docs for the particular processors the G5s have, do
> they have a sleep mode?

Yes; they have many different power saving modes
(doze, nap, deep nap, sleep), and the clock can
be scaled down, too.  The details are different
for each of 970, 970FX, 970MP.

Documentation for 970FX and 970MP is here:
<http://www-306.ibm.com/chips/techlib/techlib.nsf/products/ 
PowerPC_9XX_Microprocessors>


Segher
