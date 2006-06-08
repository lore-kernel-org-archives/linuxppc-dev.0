Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2D6CF67BD5
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 23:41:02 +1000 (EST)
Subject: Re: [PATCH 7/10] Add use of mpc86xx.h include files in legacy
	header files.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <542A1CA4-6A5A-41DA-98D2-C61D5376B761@kernel.crashing.org>
References: <1149720157.23938.202.camel@cashmere.sps.mot.com>
	<542A1CA4-6A5A-41DA-98D2-C61D5376B761@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1149773816.23938.226.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 08:36:56 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-07 at 23:49, Kumar Gala wrote:
> On Jun 7, 2006, at 5:42 PM, Jon Loeliger wrote:
> 
> >
> > Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> >
> > ---
> >
> >  include/asm-ppc/io.h      |    2 ++
> >  include/asm-ppc/ppc_sys.h |    2 ++
> >  include/asm-ppc/serial.h  |    2 ++
> >  3 files changed, 6 insertions(+), 0 deletions(-)
> 
> Are the io.h & serial.h really needed for ARCH=powerpc?  What does  
> serial.h get from asm/mpc86xx.h?  I can see the possibility of io.h  
> needing some stuff from asm/mpc86xx.h

I'll check and do a round of include scrubbing.
There was some silliness going on there earlier,
but it could have been cleaned up along the way too.


> > index 40f197a..4eaf80d 100644
> > --- a/include/asm-ppc/ppc_sys.h
> > +++ b/include/asm-ppc/ppc_sys.h
> > @@ -27,6 +27,8 @@ #elif defined(CONFIG_83xx)
> >  #include <asm/mpc83xx.h>
> >  #elif defined(CONFIG_85xx)
> >  #include <asm/mpc85xx.h>
> > +#elif defined(CONFIG_PPC_86xx)
> > +#include <asm/mpc86xx.h>
> 
> this should go since I can't imagine your using ppc_sys.

Right.  Leftover cleaning tidbits.  It's gone.

Thanks,
jdl
