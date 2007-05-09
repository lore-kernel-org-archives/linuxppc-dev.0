Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDDBFDDE40
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 00:33:23 +1000 (EST)
In-Reply-To: <20070508001808.GD7449@localhost.localdomain>
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
	<B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
	<463F9A38.6080408@freescale.com>
	<AC7B08C0-E41A-458F-8E9F-59901443600A@freescale.com>
	<3FE06AFA-BEE6-46CF-B12C-29D979AE50D7@kernel.crashing.org>
	<20070508001808.GD7449@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <baf8c79aa13de543816d62162d4f9928@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 05/13] Document the fsl,
	magic-packet property in gianfar nodes.
Date: Wed, 9 May 2007 16:33:12 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> As I previously wrote internally, it's only needed because some
>>>> versions of the device have it and some don't; what it really means
>>>> is that certain bits in certain registers are valid.

So have the driver detect this based on "compatible"
or "model".

> Further, is there already a standard description for WoL capability
> described in one of the OF binding documents.  Segher?

[Cc: me if you want me to answer, I was reading this
thread with the "d" key, you got lucky].

There is no standard wake-on-lan thing in any binding
as far as I know.  I don't see how it would be useful
anyway, it's all just the device driver's job as far
as I can see.


Segher
