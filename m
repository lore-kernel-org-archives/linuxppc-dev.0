Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] edac: Add Cell memory controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20071004170047.30883e02.sfr@canb.auug.org.au>
References: <1191476442.154524.519055590678.qpush@grosgo>
	<20071004054106.E5329DDE3C@ozlabs.org>
	<20071004170047.30883e02.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 17:07:43 +1000
Message-Id: <1191481663.22572.163.camel@pasglop>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	bluesmoke-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-04 at 17:00 +1000, Stephen Rothwell wrote:
> On Thu, 04 Oct 2007 15:40:44 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > +++ linux-work/drivers/edac/cell-edac.c	2007-10-04 15:34:46.000000000 +1000
> > @@ -0,0 +1,258 @@
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/stop_machine.h>
> > +#include <asm/io.h>
> > +#include <asm/machdep.h>
> > +#include <asm/cell-regs.h>
> 
> Since you use the of_ accessors, you should include linux/of.h

Looks like it gets pulled in by somebody on my behalf, I suppose I can
respin the patch though or just send a corrective add-on (I prefer the
later as I have to go home now :-)

Ben.
