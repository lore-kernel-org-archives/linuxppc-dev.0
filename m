Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 Jan 2008 16:52:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/2] [POWERPC] 4xx: Add AMCC Haleakala (405EXr) dts
Message-ID: <20080116055243.GC5016@localhost.localdomain>
References: <1200380965-10245-1-git-send-email-sr@denx.de>
	<20080116004642.GD4283@localhost.localdomain>
	<200801160604.56766.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200801160604.56766.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 16, 2008 at 06:04:56AM +0100, Stefan Roese wrote:
> On Wednesday 16 January 2008, David Gibson wrote:
> > On Tue, Jan 15, 2008 at 08:09:25AM +0100, Stefan Roese wrote:
[snip]
> > > +			RGMII0: emac-rgmii@ef600b00 {
> > > +				device_type = "rgmii-interface";
> >
> > And especially not here.
> 
> Ok.
> 
> Your comments are valid for some of the other 4xx dts files too. Should I 
> create a patch that removes these device-types there too?

Yes please :).

[snip]
> > Oh, for crying out loud.  They put dcrs on the bridge as well as MMIO
> > registers. *facepalm*
> 
> Yep. PCIe on 4xx has DCR, SDR *and* MMIO registers.

Ungh.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
