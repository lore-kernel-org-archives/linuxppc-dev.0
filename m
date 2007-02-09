Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 4C250DDED2
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 04:49:30 +1100 (EST)
Date: Fri, 9 Feb 2007 10:50:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [RFC] mpc5200 device tree bindings refinement
Message-ID: <20070209175029.GB23362@mag.az.mvista.com>
References: <11710062092006-git-send-email-grant.likely@secretlab.ca>
	<20070209173149.GA23362@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070209173149.GA23362@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 10:31:49AM -0700, Mark A. Greer wrote:
> On Fri, Feb 09, 2007 at 12:30:09AM -0700, Grant Likely wrote:
> 
> Hi Grant,
> 
> > Much needed refinement of mpc5200 device tree binding specifications.
> > 
> > Short list:
> 
> <snip>
> 
> > - Specify reqiured 'cell-index' property to identify between multiple SOC
> >   devices of the same type.  (Useful for arbitrating shared register access)
> 
> <snip>
> 
> > +Important child node properties
> > +name		type		description
> > +----		----		-----------
> > +cell-index	int		When multiple devices are present, is the
> > +				index of the device in the hardware (ie. There
> > +				are 6 PSC on the 5200 numbered PSC1 to PSC6)
> > +				    PSC1 has 'cell-index = <0>'
> > +				    PSC4 has 'cell-index = <3>'
> > +
> 
> Dale Farnsworth and I have the exact same problem with the Marvell
> bridges (e.g., 2 MPSC ctlrs use different bits in the same reg).

Hrm, as I reread this, I may have misunderstood the purpose of cell-index. :(
