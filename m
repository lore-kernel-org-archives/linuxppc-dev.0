Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Sep 2007 13:37:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070912033749.GE20218@localhost.localdomain>
References: <230A7A2A-3184-4BC2-B8AC-C94090B532B0@kernel.crashing.org>
	<20070911155558.GA10743@lixom.net>
	<11B85E70-D643-4013-A9B3-59CD76F9D7AB@kernel.crashing.org>
	<20070911171521.GB10743@lixom.net> <46E6CE9A.8080402@freescale.com>
	<20070911173308.GA11951@lixom.net> <46E6D4D4.2050600@freescale.com>
	<C1272D92-42A0-43E4-9AE0-12161178AAA2@kernel.crashing.org>
	<20070912030005.GA20218@localhost.localdomain>
	<0F762D4F-C84B-4979-92D4-42C5D40AE455@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0F762D4F-C84B-4979-92D4-42C5D40AE455@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 10:35:01PM -0500, Kumar Gala wrote:
> 
> On Sep 11, 2007, at 10:00 PM, David Gibson wrote:
> 
> > On Tue, Sep 11, 2007 at 12:59:22PM -0500, Kumar Gala wrote:
> >>
> >> On Sep 11, 2007, at 12:48 PM, Scott Wood wrote:
> >>
> >>> Olof Johansson wrote:
> >>>> On Tue, Sep 11, 2007 at 12:21:30PM -0500, Scott Wood wrote:
> >>>>> Olof Johansson wrote:
> >>>>>> On Tue, Sep 11, 2007 at 11:00:28AM -0500, Kumar Gala wrote:
> >>>>>>> well the ifdefs are orthogonal.  We don't have a way of knowing
> >>>>>>> primary from the device tree today.
> >>>>>> How about something like "fsl,primary-phb" in the bus device
> >>>>>> node? I don't
> >>>>>> know, maybe it's already been discussed and turned down for some
> >>>>>> reason.
> >>>>> It's more of a Linux issue than anything to do with the hardware.
> >>>>
> >>>> That doesn't stop firmware from telling linux which bus is the
> >>>> primary
> >>>> one on the system to help out.
> >>>
> >>> The entire notion of a "primary" PCI bus is due to a Linux flaw.
> >>>
> >>> If we did put it in the device tree, it should be something like
> >>> "linux,primary-phb".  But since Linux can tell from the node's
> >>> children,
> >>> there doesn't seem to be much point.
> >>
> >> Once someone rights code to do this I'm happy to change over.  I took
> >> this model of explicitly knowing the primary PHB from the pmac code.
> >
> > In the meantime, couldn't the code still be merged, using an explicit
> > test of the root node's 'compatible' or 'model' properties to decide
> > on the right primary bus.
> 
> I will be, I'm not going to wait on having some device tree spec for  
> this.  The board code can handle it until we come to some agreement  
> on how to do this.  I'm in agreement with Scott in that code should  
> be added to scan or allow explicit determination.  Adding a 'prop' to  
> the device tree just for linux seems a bit silly.

Yes, saw that in your new version after I'd posted that.  Sorry.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
