Return-Path: <Martin.Leisner@xerox.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: update:   RE: nap/dfs on 7448
Date: Thu, 27 Dec 2007 17:37:11 -0500
Message-ID: <556445368AFA1C438794ABDA8901891C07C113CC@USA0300MS03.na.xerox.net>
In-Reply-To: <1191304917.6310.99.camel@pasglop>
References: <556445368AFA1C438794ABDA8901891C0738E1E8@USA0300MS03.na.xerox.net>
	<1191304917.6310.99.camel@pasglop>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Turns out the Tundra TSI109 has various "problems" trying
to nap -- its not a 7448 issue...

We're working with tundra to get a workaround (in software, they=20
won't respin the part).  It seems DMA while napping is an issue, we
have to turn off the tsi109 ethernet queues before entering nap mode...

If anyone needs this work, let me know (it will  be covered under GPL).

marty

>   -----Original Message-----
>   From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>   Sent: Tuesday, October 02, 2007 2:02 AM
>   To: Leisner, Martin
>   Cc: linuxppc-dev
>   Subject: Re: nap/dfs on 7448
>  =20
>  =20
>   On Mon, 2007-10-01 at 17:32 -0400, Leisner, Martin wrote:
>   > I asked this on linuxppc-embedded a week ago (I didn't even know
this
>   > list existed until last week -- another reason to get rid of
>   > linuxpcc-embedded).
>   >
>   > Has anyone gotten NAP/DFS to reliably work on a 7448?
>   >
>   > I'm seeing strange problems with peripherals...(using a ram disk
>   > works fine).
>  =20
>   Could it be that your host bridge isn't properly waking up the CPU
to
>   DOZE state for snooping DMA ? (It might require some delays on QACK
in
>   some cases, I know Apple had workarounds in those areas, maybe
something
>   along those lines need to be configured in the chipset).
>  =20
>   Ben.
>  =20
