Return-Path: <mgreer@mvista.com>
Date: Tue, 15 Jan 2008 10:31:19 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/4] powerpc: mv64x60 - Use early_* PCI accessors for
	hotswap reg
Message-ID: <20080115173119.GB26853@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080115102129.a4666143.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080115102129.a4666143.sfr@canb.auug.org.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 10:21:29AM +1100, Stephen Rothwell wrote:
> Hi Mark,
> 
> On Mon, 14 Jan 2008 15:51:50 -0700 "Mark A. Greer" <mgreer@mvista.com> wrote:
> >
> > +++ b/arch/powerpc/sysdev/mv64x60.h
> > @@ -3,10 +3,32 @@
> >  
> >  #include <linux/init.h>
> >  
> > +#include <asm/prom.h>
> 
> You probably meant to include linux/of.h here

Umm, apparently...  :)

Mark
