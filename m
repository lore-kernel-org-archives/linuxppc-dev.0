Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id ED431DE147
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 12:28:20 +1100 (EST)
Date: Thu, 29 Jan 2009 17:28:16 -0800 (PST)
Message-Id: <20090129.172816.174153340.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] ucc_geth: Change uec phy id to the same format as
	gianfar's
From: David Miller <davem@davemloft.net>
In-Reply-To: <FD1B55B4-574B-4B77-889D-FD81D77DCA5E@kernel.crashing.org>
References: <1233254342-8435-1-git-send-email-Haiying.Wang@freescale.com>
	<FD1B55B4-574B-4B77-889D-FD81D77DCA5E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Haiying.Wang@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 29 Jan 2009 12:42:38 -0600

> 
> On Jan 29, 2009, at 12:39 PM, Haiying Wang wrote:
> 
> > The commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4 changes the gianfar's phy id to
> > the format like "mdio@xxxx:xx", but uec still uses the old format like "xxxxxxxx:xx".
> > For the board whose UEC uses gianfar-mdio like MPC8568MDS, the phy can not be attached
> > because of the incompatible phy id format. This patch changes uec's phy id to the same
> > format as gianfar's.
> >
> > Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> > ---
> > drivers/net/ucc_geth.c           |   20 ++++++++++++++++++--
> > drivers/net/ucc_geth.h           |    2 ++
> > drivers/net/ucc_geth_mii.c       |   12 +++++++++++-
> > drivers/net/ucc_geth_mii.h       |    1 +
> > 4 files changed, 32 insertions(+), 3 deletions(-)
> 
> David,
> 

Applied to net-2.6, thanks.
