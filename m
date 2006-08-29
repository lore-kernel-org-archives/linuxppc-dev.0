Return-Path: <marcus@mc.pp.se>
Received: from omoikane.mc.pp.se (ua-85-227-1-9.cust.bredbandsbolaget.se
	[85.227.1.9]) by ozlabs.org (Postfix) with ESMTP id 95FE767B32
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 07:06:02 +1000 (EST)
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH] EHCI Oops on CONFIG_NOT_COHERENT_CACHE system
References: <yf9bqq6p305.fsf@omoikane.mc.pp.se> <20060829150759.269420@gmx.net>
From: Marcus Comstedt <marcus@mc.pp.se>
Date: Tue, 29 Aug 2006 23:04:44 +0200
In-Reply-To: <20060829150759.269420@gmx.net> (Gerhard Pircher's message of
	"Tue, 29 Aug 2006 17:07:59 +0200")
Message-ID: <yf9mz9np82b.fsf@omoikane.mc.pp.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


"Gerhard Pircher" <gerhard_pircher@gmx.net> writes:

> Hi Marcus,
>
> I guess this message should also be forwarded to linux-usb-devel@lists.sourceforge.net. I hope the developers there can make some comments.
>
> Gerhard


Well, I figured the first thing to do would be to reach a consensus
here on whether or not atomic_t:s in DMA memory should be ruled as
unallowed.  Judging from the massive silence, there doesn't seem to be
any strong opinions either way though...


  // Marcus
