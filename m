Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Jul 2007 13:05:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070726030550.GA1149@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IDjSy-0003eC-T4@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 25, 2007 at 11:12:00AM -0500, Jon Loeliger wrote:
> Folks,
> 
> I'd like to make an official DTC Version 1.0.0 release soon!
> To that end, I've published a repo on jdl.com with a v1.0.0-rc1
> tag on it.  I anticipate some updates to the Documentation before
> a final 1.0.0 release still.  However, if you have something
> you would like to have be in The Real 1.0.0 release, please
> let me know soon!

It would certainly be great to have a release, since dtc is becoming
necessary for more and more kernel builds.

Only thing I'm not really happy with in the current release is the
versioning stuff.  For starters, it always reports my builds as
-dirty, even when they're not.  It also seems a bit hideously
complicated for what it does.  I'd prefer to see something simpler
using git-describe to derive the version strings directly from the git
tags themselves.  Obviously we need some sort of cacheing mechanism to
make the versioning work for tarball releases without the git history,
but I think we can handle that with a suitable "make dist" target.

I'll see if I can make a patch or two in the next few days.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
