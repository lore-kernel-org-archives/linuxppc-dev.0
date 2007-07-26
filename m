Return-Path: <dgibson@ozlabs.org>
Date: Fri, 27 Jul 2007 00:27:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070726142739.GB18684@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IE314-0000qF-5x@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 08:04:30AM -0500, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > On Wed, Jul 25, 2007 at 11:12:00AM -0500, Jon Loeliger wrote:
> > > Folks,
> > > 
> > > I'd like to make an official DTC Version 1.0.0 release soon!
> > 
> > It would certainly be great to have a release, since dtc is becoming
> > necessary for more and more kernel builds.
> > 
> > Only thing I'm not really happy with in the current release is the
> > versioning stuff.  For starters, it always reports my builds as
> > -dirty, even when they're not.
> 
> I think it won't do that once there is a tag available.

Your 1.0.0-rc1 tag is there, still showing as dirty.

> > It also seems a bit hideously
> > complicated for what it does.  I'd prefer to see something simpler
> > using git-describe to derive the version strings directly from the git
> > tags themselves.
> 
> That is essentially what is there now.  We just need a tag!

Um... no.  The base version comes from the numbers specified in the
Makefile, not from the git tag.

> >  Obviously we need some sort of cacheing mechanism to
> > make the versioning work for tarball releases without the git history,
> > but I think we can handle that with a suitable "make dist" target.
> 
> Sure.
> 
> > I'll see if I can make a patch or two in the next few days.
> 
> I would like to keep the current version mechanism as it
> is really quite similar to what is in the Kernel now.

First, I don't think it really is - except in superficial aspect of
how the version number is partitioned - the kernel has no auto version
generating thing of this type.  Second, I don't see that being similar
to the kernel's approach has any particular usefulness here, anyway.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
