Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wqgj5sBrzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 13:30:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: remove deprecated attach_adapter callback
In-Reply-To: <20180821150240.19964-1-wsa@the-dreams.de>
References: <20180821150240.19964-1-wsa@the-dreams.de>
Date: Thu, 23 Aug 2018 13:30:57 +1000
Message-ID: <87in41lpxq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang <wsa@the-dreams.de> writes:

> So, I wanted to do this in the next cycle, but Linus seems to want it this
> cycle already [1], so here it is:
>
> Remove the attach_adapter callback from the 2.4 times by converting
> the last user to a custom probing mechanism based on deferred probing. We used
> this already in commit ac397c80de89 ("ALSA: ppc: keywest: drop using attach
> adapter") successfully on HW, so we agreed to use it on the windtunnel driver
> as well.
>
> With the last user gone, we can then remove the callback \o/ I think this
> allows for more cleanup in the core, but let's do this later and focus on the
> removal for now.
>
> Tested on a Renesas R-Car Salvator-XS board (M3N) by using and rebinding
> various I2C busses. Build bot and checkpatch are happy, too.
>
> I'd like to send a pull request to Linus this merge window, so looking forward
> to super fast comments, acks, etc...

Sure, I don't have a G4 hooked up to test this, so just merge it and if
it breaks we can fix it.

cheers
