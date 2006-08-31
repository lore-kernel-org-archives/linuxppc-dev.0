Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B57F67B6D
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Sep 2006 07:32:38 +1000 (EST)
In-Reply-To: <1157025771.12526.133.camel@localhost.localdomain>
References: <7cc604637892c0a00a5e3e38192494d7@bga.com>
	<1156978993.12526.97.camel@localhost.localdomain>
	<11BC5236-0411-402A-A3F1-0FB5E8059FA0@kernel.crashing.org>
	<1157025771.12526.133.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E4FB3954-2B96-4806-9FF2-684E0E0135AD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PCIe enhanced configuration mechanism support on ppc arch
Date: Thu, 31 Aug 2006 23:31:10 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The U3/U4 HT config access code never returns the error though; it
>> happily accesses the config space of the next device instead.  Got
>> a patch, will send it later -- it's not a regression, there's no big
>> hurry for 2.6.18.
>
> Better to have it in if possible though. Thanks

I'm more worried about having 2.6.18 work at all, sorry.  I might
be fast enough of course (ahem), but no promises :-)


Segher
