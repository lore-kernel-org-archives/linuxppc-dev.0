Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A669BDDEC3
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:50:26 +1000 (EST)
Date: Tue, 03 Apr 2007 18:50:26 -0700 (PDT)
Message-Id: <20070403.185026.26966290.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070404024400.56d016e1@the-village.bc.nu>
References: <20070404022828.5c9b97f3@the-village.bc.nu>
	<Pine.LNX.4.63.0704031804350.21680@qynat.qvtvafvgr.pbz>
	<20070404024400.56d016e1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: david.lang@digitalinsight.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 4 Apr 2007 02:44:00 +0100

> Well the better designed serial setups on Linux use numbering so that you
> can look on the multiplexor boxes and know straight away what the
> correlation between port number and name is. In the same was as "S0 is
> console 1" is nice to have its also nice to have "mux 1 port 4" easily
> calculable not think

If you want hierarchy, create it:

/sys/blah/serial/controllerX/portY

and keeping them all under the ttyS? major keeps the simple
cases working sanely too.
