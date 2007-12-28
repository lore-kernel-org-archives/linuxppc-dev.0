Return-Path: <benh@kernel.crashing.org>
Subject: Re: update:   RE: nap/dfs on 7448
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
In-Reply-To: <556445368AFA1C438794ABDA8901891C07C113CC@USA0300MS03.na.xerox.net>
References: <556445368AFA1C438794ABDA8901891C0738E1E8@USA0300MS03.na.xerox.net>
	<1191304917.6310.99.camel@pasglop>
	<556445368AFA1C438794ABDA8901891C07C113CC@USA0300MS03.na.xerox.net>
Content-Type: text/plain
Date: Fri, 28 Dec 2007 16:19:45 +1100
Message-Id: <1198819185.7209.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-27 at 17:37 -0500, Leisner, Martin wrote:
> Turns out the Tundra TSI109 has various "problems" trying
> to nap -- its not a 7448 issue...
> 
> We're working with tundra to get a workaround (in software, they 
> won't respin the part).  It seems DMA while napping is an issue, we
> have to turn off the tsi109 ethernet queues before entering nap mode...
> 
> If anyone needs this work, let me know (it will  be covered under GPL).

This looks like yet another f*cked up bridge ... I wonder if we'll ever
get a half decent working northbridge for those processors...

Unfortunately, it looks like the market for those is limited to junk
from vendor A and shit from vendor B...

Is the problem limited to the TSI internal ethernet or it happens with
any DMA ?

Looks to me like turning off DMA in NAP mode basically makes NAP mode
unuseable, perdiod. You can't start loosing packets because your
processor is idle. So no power saving, and let's eat the watts since
they won't respin the part. Great !

Ben.
