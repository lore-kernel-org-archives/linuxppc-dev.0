Return-Path: <mgreer@mvista.com>
Date: Thu, 10 Aug 2006 11:55:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] consolidated libdt proposal
Message-ID: <20060810185514.GA12848@mag.az.mvista.com>
References: <11155228690643c98691.1714636915.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11155228690643c98691.1714636915.miltonm@bga.com>
Cc: hollisb@us.ibm.com, pantelis@embeddedalley.com,
	linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org,
	xen-ppc-devel@lists.xensource.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 10, 2006 at 11:51:30AM -0500, Milton Miller wrote:
> On Tue Aug  8 2006 01:04:08 PM CDT, Mark A. Greer wrote:
> > If we're going to allow cmdline editing in the bootwrapper, we would
> > need to extend the size of a property.  We've never really talked about
> > cmdline editing in the powerpc branch but I assume that its a good
> > thing(tm).  I know I would like to have it so, IMHO, I think we should
> > add it (and therefore require extending a property).
> 
> We already have replace the command line merged (it's why my patches
> don't apply).

That's different.  What you're talking about is the code that supports
sticking a cmdline in a separate section of the zImage and using it.
What I'm talking about is editing the cmdline at runtime (as in what
used to happen in arch/ppc).

Not sure if we need all of these options but that's what I was talking
about.

Mark
