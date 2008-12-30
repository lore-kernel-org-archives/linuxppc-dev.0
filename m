Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B4739DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 13:19:07 +1100 (EST)
Date: Mon, 29 Dec 2008 18:19:08 -0800 (PST)
Message-Id: <20081229.181908.214463121.davem@davemloft.net>
To: nhorman@tuxdriver.com
Subject: Re: [PATCH] clean up of netif_rx_reschedule() changes in drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20081229153757.GA2857@localhost.localdomain>
References: <20081229102509.GA11111@linux.vnet.ibm.com>
	<20081229214144.43be8c1d.sfr@canb.auug.org.au>
	<20081229153757.GA2857@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Neil Horman <nhorman@tuxdriver.com>
Date: Mon, 29 Dec 2008 10:37:57 -0500

> On Mon, Dec 29, 2008 at 09:41:44PM +1100, Stephen Rothwell wrote:
> > Hi Kamalesh,
> > 
> > On Mon, 29 Dec 2008 15:55:29 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> > > greping through the sources for the changes missed out, we have
> > > 
> > 	.
> > 	.
> > > 
> > > Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
 ...
> Thanks guys, not sure how my patch missed that.  I did an allmodconfig build
> that passed successfully.  Thanks!

It's very simple, you're not building on powerpc or ARM :-)

> Acked-by: Neil Horman <nhorman@tuxdriver.com>

Applied, thanks everyone.
