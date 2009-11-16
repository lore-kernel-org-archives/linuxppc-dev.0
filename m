Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 85AC2B7BED
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 21:20:53 +1100 (EST)
Date: Mon, 16 Nov 2009 02:21:01 -0800 (PST)
Message-Id: <20091116.022101.241160893.davem@davemloft.net>
To: w.sang@pengutronix.de
Subject: Re: [PATCH] net/can: add driver for mscan family & mpc52xx_mscan
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091116101205.GA30609@pengutronix.de>
References: <20091113.205138.168699769.davem@davemloft.net>
	<4AFFEC2C.6000106@grandegger.com>
	<20091116101205.GA30609@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Mon, 16 Nov 2009 11:12:05 +0100

>> >> Taken from socketcan-svn, fixed remaining todos, cleaned up, tested with a
>> >> phyCORE-MPC5200B-IO and a custom board.
>> >>
>> >> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>> > 
>> > Applied.
>> 
>> Unfortunately too early. I will send my review tomorrow. Sorry for the
>> delay.
> 
> So, I'd assume that I now have to send an incremental patch instead of a V2?

Yes.
