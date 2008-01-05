Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC7D1DDE26
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 07:53:29 +1100 (EST)
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200801051338.17957.sr@denx.de>
References: <1199526609-12290-1-git-send-email-sr@denx.de>
	<1199528388.7291.55.camel@pasglop>  <200801051338.17957.sr@denx.de>
Content-Type: text/plain
Date: Sun, 06 Jan 2008 07:53:06 +1100
Message-Id: <1199566386.7291.58.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-01-05 at 13:38 +0100, Stefan Roese wrote:
> On Saturday 05 January 2008, Benjamin Herrenschmidt wrote:
> > On Sat, 2008-01-05 at 10:50 +0100, Stefan Roese wrote:
> > > Performance tests done by AMCC have shown that 256 buffer increase the
> > > performance of the Linux EMAC driver. So let's update the default
> > > values to match this setup.
> > >
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > ---
> >
> > Do we have the numbers ? Did they also measure latency ?
> 
> I hoped this question would not come. ;) No, unfortunately I don't have any 
> numbers. Just the recommendation from AMCC to always use 256 buffers.

Ok. Well, it's just a .config option so I suppose the patch is fine. Can
you also update the defconfigs (at least for the recent AMCC boards) ?

Ben.
