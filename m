Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 463B867B67
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 02:59:29 +1000 (EST)
Date: Wed, 9 Aug 2006 10:03:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060809170323.GC17759@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<1155122309.4040.94.camel@localhost.localdomain>
	<1155128205.3944.1.camel@zod.rchland.ibm.com>
	<20060809163839.GB17759@mag.az.mvista.com>
	<E1GArEQ-0006OP-7H@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1GArEQ-0006OP-7H@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 09, 2006 at 11:48:34AM -0500, Jon Loeliger wrote:
> So, like, the other day "Mark A. Greer" mumbled:
> > > We're only talking about the _source_ files.  The .dts files.  Not the
> > > binary trees themselves.
> > > 
> > > The basic summary is that having a .dts in the kernel for every
> > > defconfig would be good.  (I think that was the summary anyway.)
> > 
> > That's my understanding too.  A 1-1 matching of default config files
> > and dts files kept in the kernel src trees.
> 
> And the keen observer who watches Paul's tree will have
> noticed that the first DTS file, mpc8641_hpcn.dts, has already
> been added to arch/powerpc/boot/dts!
> 
> > Any extra dts files 
> 
> ... of which there are none...

Yet...

> > ...would be kept whereever dtc src is stored (i.e., jdl.com).
> >  I haven't heard jdl agree to this, though.  :)
> 
> Sure.  No problem by me.
> 
> Though I do have a question WRT the notion of the libdt...
> 
> So, if I understand this proposal correctly, making libdt.a
> would mean that we will now have to link the kernel against
> this new, external dependency library.  It would also mean
> that we'd have to link U-Boot against this new, external
> library as well.
> 
> Did I misunderstand or is everyone hip, jiggie and down with that?

I thought the proposal was a master copy kept by you and then the
various users would copy it over when they wanted.

>From Hollis' email
(http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/023882.htm):

	"I think we should turn it into a library in the dtc source
	tree. The various projects using it could then include snapshots
	(to avoid dependencies)."

I think that means we copy.

Mark
