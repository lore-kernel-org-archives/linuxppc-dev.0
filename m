Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 98BA7474FB
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 09:08:17 +1100 (EST)
Date: Tue, 06 Jan 2009 14:08:17 -0800 (PST)
Message-Id: <20090106.140817.59130790.davem@davemloft.net>
To: afleming@freescale.com
Subject: Re: [PATCH] gianfar: ensure ECNTRL[R100] is cleared on link state
	change
From: David Miller <davem@davemloft.net>
In-Reply-To: <8E33B4C2-F1E3-4C64-86E4-6EAA4C7151C5@freescale.com>
References: <1231275171-21388-1-git-send-email-galak@kernel.crashing.org>
	<8E33B4C2-F1E3-4C64-86E4-6EAA4C7151C5@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leo@rock.ap.freescale.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@freescale.com>
Date: Tue, 6 Jan 2009 14:56:25 -0600

> 
> On Jan 6, 2009, at 2:52 PM, Kumar Gala wrote:
> 
> > From: Leo Li <leo@rock.ap.freescale.net>
> >
> > When changing the link between 100Mbps and 1Gbps in SGMII mode it was
> > found out that the link would stop working.  The issue is that ECNTRL[R100]
> > needs to be cleared when in 1Gbps mode.  Older reference manuals didn't
> > require the explicitly clearing but has since been found it that it is
> > needed.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> Acked-by: Andy Fleming <afleming@freescale.com>

Applied, thanks everyone.
