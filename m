Return-Path: <dgibson@ozlabs.org>
Date: Mon, 21 May 2007 15:13:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ibm_emac: Correctly detect old link speed
Message-ID: <20070521051311.GB7778@localhost.localdomain>
References: <200705161300.08521.sr@denx.de>
	<20070516173002.GA22331@gate.ebshome.net>
	<200705162044.47776.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705162044.47776.sr@denx.de>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 08:44:47PM +0200, Stefan Roese wrote:
> On Wednesday 16 May 2007, Eugene Surovegin wrote:
> > On Wed, May 16, 2007 at 01:00:08PM +0200, Stefan Roese wrote:
> > > This patch fixes a bug where the link speed change was not
> > > detected correctly. This occured on a 440SPe (EMAC4) system
> > > where the old link speed was 100Mbps and the new link speed
> > > is 1000Mbps.
> >
> > Good catch, Stefan. Unfortunately, I have to NACK your patch - you
> > broke non EMAC4 builds.
> 
> Yes, you're right of course.
> 
> > Correct fix is just to remove EMAC_MR1_MF_1000GPCS from the first
> > if condition.
> 
> Yep.
> 
> > I'll send correct fix shortly along with other queued patches.
> 
> Thanks.

I've merged essentially the same fix into the device tree aware
"new_emac" driver.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
