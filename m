Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 288C367A33
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 18:37:10 +1000 (EST)
In-Reply-To: <451C3641.60107@ru.mvista.com>
References: <A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>	<1158787957.6002.307.camel@localhost.localdomain>	<20060920215738.GC24809@mag.az.mvista.com>	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>	<20060921133707.GA29137@gate.crashing.org>	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>	<20060922012408.GA13820@mag.az.mvista.com>	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>	<20060922185923.GB25738@mag.az.mvista.com>	<74E4B2E4-B59C-4998-B9FC-A77245C6AF6B@kernel.crashing.org>	<20060923081836.GA25298@mag.az.mvista.com>
	<D47FC822-2AB1-459A-B2EC-50A99552DC9A@kernel.crashing.org>
	<451C3641.60107@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <01DF3484-F136-4715-A308-8C7BA996F713@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Date: Sat, 30 Sep 2006 10:36:52 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Matt Porter <mporter@embeddedalley.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>    I looked into the OF 64-bit extensions spec, and "cell" is 64- 
> bit there.

Like I said before, a "cell" in OF has nothing to do with the items
in the device tree.

> So, "address" should look valid. I don't know whether PPC64 boxes  
> support 64-bit OF, or only 32-bit, however, the kernel

Most OF's on 64-bit machines are 64 bit.  The only defined client
interface for PowerPC is 32 bit though.  And, again, the format
of the device tree is independent of machine word size or other
environmental factors.

> doesn't seem to deal with 64-bit ones correctly, so I'm assuming  
> that 32-bit OF is at least available...
>    Anyway, I'm still missing the point of not using "address" which  
> is clearly intended for such case.

It also has many many problems and therefore should preferably
not be used.


Segher
