Return-Path: <dgibson@ozlabs.org>
Date: Tue, 28 Aug 2007 10:21:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 3/3] [POWERPC] Add PCI support for AMCC 440EPx (sequoia)
Message-ID: <20070828002128.GA3470@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825093001.4087.18160.stgit@localhost.localdomain>
	<20070827015719.GD12804@localhost.localdomain>
	<200708270821.35209.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200708270821.35209.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 27, 2007 at 08:21:35AM +0200, Stefan Roese wrote:
> On Monday 27 August 2007, David Gibson wrote:
> > On Sat, Aug 25, 2007 at 01:30:01PM +0400, Vitaly Bordug wrote:
[snip]
> > Unless there really is something peculiar about the EPx bridge
> > compared to say the GP, EP and other 4xx bridges, this should have a
> > more general name.
> 
> We originally started naming this file sequoia-pci.c and changed it to be 
> 440EPx specific (just by renaming). But you are right of course. We should 
> make it even more generic for 4xx PCI support. Perhaps we will overlook some 
> problems with other 4xx platforms, but those should be solved when other 
> platforms (Josh: 440ep and 405gp? ;)) will be added.
> 
> So what should it be called? arch/powerpc/syslib/ppc4xx_pci.c ?

Sounds ok, except that it's sysdev, not syslib in arch/powerpc of
course.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
