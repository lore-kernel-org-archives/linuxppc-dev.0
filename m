Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Nov 2007 11:34:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: libfdt as its own repo and submodule of dtc?
Message-ID: <20071102003406.GA19839@localhost.localdomain>
References: <C98039BC-92DE-4398-B198-EDAD12A3670C@kernel.crashing.org>
	<E1ImtSB-0003vC-0j@jdl.com> <4727665E.1070109@ge.com>
	<20071030234011.GE2784@localhost.localdomain>
	<F940E9CC-1F15-4EC5-94DC-A600FD702380@kernel.crashing.org>
	<20071031225624.GB16119@localhost.localdomain>
	<1193925881.15380.8.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193925881.15380.8.camel@ld0161-tx32>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	Jerry Van Baren <gerald.vanbaren@ge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 01, 2007 at 09:04:42AM -0500, Jon Loeliger wrote:
> On Wed, 2007-10-31 at 17:56, David Gibson wrote:
> 
> > I'm not too keen on using a git feature that's more recent than the
> > git in most distros.
> 
> I'm going to consider this argument null and void on two fronts:
> 
> You don't use git for patch generation and submission anyway.

True.  It wasn't clear to me whether using this git-submodule thing
would also affect pulling.

> The Linux Community happily embraced and used early
> versions of git, installing it themselves if needed,
> long before it was available in _any_ distro.

I don't think this is a comparable situation.  For one, dtc does not
have the clout of Linux.  For another, at the time there was hardly
anything in the way of suitable solutions that were out there in
distros.  That's not the case now - we can do nearly everything we
want with the git in recent distros, I don't think there's call to
require a newer version for one extra feature.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
