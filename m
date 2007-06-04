Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF9CADDE37
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 00:37:30 +1000 (EST)
In-Reply-To: <466406BB.3070607@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>	
	<1180769992.14025.1.camel@localhost.localdomain>	
	<4662E7EA.70506@ru.mvista.com>	
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>	
	<46630256.8050909@ru.mvista.com>
	<1180904670.31677.18.camel@localhost.localdomain>
	<466406BB.3070607@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <879d8eb0b405619a9e457d137c27baa2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Mon, 4 Jun 2007 16:37:21 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> So you are saying that because the current linux MTD stuff can only
>> probe (which doesn't always work), we should not put the proper chip
>> interface type in the device-tree ?
>
>    No. But if/when we put it, it'll only be able to influence 
> interface probing, but not "force" the interface.

Of course it can; that just means you have to fix MTD
and/or the way your platform calls MTD.

>    The money was not the only factor, you know, I was under the 
> pressure of schedules, and had a lot more things to do.

The bigger Linux community does not (and should not)
care about your corporate schedules.  Your patches
won't be merged upstream until they are deemed to be
of acceptable quality.  If that doesn't fit your
employer's schedule, well tough luck, they can maintain
their own kernel fork I'm sure?


Segher
