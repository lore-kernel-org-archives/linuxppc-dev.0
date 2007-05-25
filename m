Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9E09DDED8
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 00:25:49 +1000 (EST)
In-Reply-To: <18006.31742.533944.368969@cargo.ozlabs.ibm.com>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
	<2994f78d2591e45517247003d613bb98@kernel.crashing.org>
	<1180051272.32247.1087.camel@localhost.localdomain>
	<adf40b0a9d45728359da78fa45efab8a@kernel.crashing.org>
	<18006.31742.533944.368969@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a50ad0ac767c59abbf644f7d6bf8ced6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
Date: Fri, 25 May 2007 16:25:43 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Only if you think the device tree is a configuration
>> mechanism for the OS.
>
> Well, actually, it's whatever we want it to be...

Oh not this discussion again.

> There is some value in making the device tree abstract and general,
> but not an overwhelming value that trumps all other considerations.

Yes, there can be other considerations; however, not making
a mess out of it all is certainly a very important one in
my book.


Segher
