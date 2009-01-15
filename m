Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B5E9EDDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 15:44:07 +1100 (EST)
Date: Wed, 14 Jan 2009 20:44:07 -0800 (PST)
Message-Id: <20090114.204407.253886327.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc/fs_enet: Add missing irq free in error path.
From: David Miller <davem@davemloft.net>
In-Reply-To: <606FE12E-797E-4C0C-8FA7-5C162BD959A9@kernel.crashing.org>
References: <1D4ED273-13FB-4D2F-82B1-89D2F6F0B9A1@kernel.crashing.org>
	<490636B4.2010202@consentry.com>
	<606FE12E-797E-4C0C-8FA7-5C162BD959A9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, mditto@consentry.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 13 Jan 2009 10:28:15 -0600

> 
> On Oct 27, 2008, at 4:46 PM, Mike Ditto wrote:
> 
> > If something goes wrong attaching to phy driver, we weren't freeing
> > the IRQ.
> >
> > Signed-off-by: Mike Ditto <mditto@consentry.com>
 ...
> This seems to have gotten lost in the shuffle.  Can you please apply.

The netdev patchwork never saw it for some reason.

Applied, thanks.
