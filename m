Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7311DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 16:58:04 +1000 (EST)
In-Reply-To: <20070509182630.GA19495@ld0162-tx32.am.freescale.net>
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
	<B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
	<463F9A38.6080408@freescale.com>
	<AC7B08C0-E41A-458F-8E9F-59901443600A@freescale.com>
	<3FE06AFA-BEE6-46CF-B12C-29D979AE50D7@kernel.crashing.org>
	<20070508001808.GD7449@localhost.localdomain>
	<baf8c79aa13de543816d62162d4f9928@kernel.crashing.org>
	<20070509182630.GA19495@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <385038798e00654a5cbd38165b06734b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 05/13] Document the fsl,
	magic-packet property in gianfar nodes.
Date: Thu, 10 May 2007 08:57:52 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>>> As I previously wrote internally, it's only needed because some
>>>>>> versions of the device have it and some don't; what it really 
>>>>>> means
>>>>>> is that certain bits in certain registers are valid.
>>
>> So have the driver detect this based on "compatible"
>> or "model".
>
> Thus requiring the driver to maintain a list of models/compatibles for
> every possible combination of features,

Most likely a very short list.  But you know best
of course.

> rather than letting the device
> tree specify them individually.  What would be the advantage in that?

It's a tradeoff -- describing every single bit of
the hardware in the device tree is a way bigger
maintenance burden, be careful not to go overboard
with it.


Segher
