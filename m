Return-Path: <benh@kernel.crashing.org>
Subject: Re: nap/dfs on 7448
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
In-Reply-To: <556445368AFA1C438794ABDA8901891C0738E1E8@USA0300MS03.na.xerox.net>
References: <556445368AFA1C438794ABDA8901891C0738E1E8@USA0300MS03.na.xerox.net>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 16:01:57 +1000
Message-Id: <1191304917.6310.99.camel@pasglop>
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


On Mon, 2007-10-01 at 17:32 -0400, Leisner, Martin wrote:
> I asked this on linuxppc-embedded a week ago (I didn't even know this
> list existed until last week -- another reason to get rid of
> linuxpcc-embedded).
> 
> Has anyone gotten NAP/DFS to reliably work on a 7448?
> 
> I'm seeing strange problems with peripherals...(using a ram disk
> works fine).

Could it be that your host bridge isn't properly waking up the CPU to
DOZE state for snooping DMA ? (It might require some delays on QACK in
some cases, I know Apple had workarounds in those areas, maybe something
along those lines need to be configured in the chipset).

Ben.
