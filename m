Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20050902163708.12c1abe3.sfr@canb.auug.org.au>
References: <1125607912.16685.111.camel@cashmere.sps.mot.com>
	<20050902163708.12c1abe3.sfr@canb.auug.org.au>
Content-Type: text/plain
Message-Id: <1126039509.25148.54.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 06 Sep 2005 15:45:09 -0500
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH Merge more include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-09-02 at 01:37, Stephen Rothwell wrote:
> On Thu, 01 Sep 2005 15:51:52 -0500 Jon Loeliger <jdl@freescale.com> wrote:
> >
> > This patch merges several include files from
> > asm-ppc and asm-ppc64 into the new asm-powerpc.
> > 
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> 
> > +#ifndef _POWERPC_BUGS_H
> 
> I would use _ASM_POWERPC_... but that is just me.

I'll start using _ASM_POWERPC_ from now on.  I will
also submit a different patch to do a round of this
sort of cleanup.

Can we get an official call on the GPL header in
include files?  I'm defaulting to adding them for now.

> Looks good.

Thanks.  More coming, of course.

So, will you resubmit patches based on your 3/3 patch
that cover the slid-through the cracks set, or shall I?
I'm thinking pmac_features.h, dbdma.h, keylargo.h, etc.

Thanks,
jdl
