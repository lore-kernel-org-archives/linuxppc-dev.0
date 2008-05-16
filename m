Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5FBA4DDEDC
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 02:01:11 +1000 (EST)
Subject: Re: [PATCH 3/5] powerpc: C2K board driver
From: Remi Machet <rmachet@slac.stanford.edu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080516144645.490114f6.sfr@canb.auug.org.au>
References: <1210897468.13992.16.camel@pcds-ts102.slac.stanford.edu>
	<20080516144645.490114f6.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 16 May 2008 09:01:32 -0700
Message-Id: <1210953692.13992.28.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-05-16 at 14:46 +1000, Stephen Rothwell wrote:
> Hi Remi,
> 
> On Thu, 15 May 2008 17:24:28 -0700 Remi Machet <rmachet@slac.stanford.edu> wrote:
> >
> > +#include <linux/stddef.h>
> > +#include <linux/kernel.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/seq_file.h>
> > +
> > +#include <asm/machdep.h>
> > +#include <asm/prom.h>
> > +#include <asm/system.h>
> > +#include <linux/time.h>
> > +#include <asm/time.h>
> > +#include <linux/kexec.h>
> 
> Normally we don'y mix linux/ and asm/ includes (put all the linux ones at
> the top).
> 
> You need to include <linux/of.h> because you use the device tree accessor
> functions.
> 
Sorry, I made the mistake when correcting a few checkpatch.pl warnings.
I will fix that and re-submit.

Thanks,

Remi
