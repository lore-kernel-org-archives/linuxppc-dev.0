Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5302ADE01D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 18:39:07 +1000 (EST)
Date: Fri, 18 Apr 2008 01:38:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 3/3] Use __weak macro for smp_setup_processor_id
Message-Id: <20080418013857.92824cfb.akpm@linux-foundation.org>
In-Reply-To: <1208506747.6958.402.camel@pasglop>
References: <20080418065728.31AF4DE255@ozlabs.org>
	<20080418000717.5a9c9758.akpm@linux-foundation.org>
	<1208506747.6958.402.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Apr 2008 18:19:07 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2008-04-18 at 00:07 -0700, Andrew Morton wrote:
> > On Fri, 18 Apr 2008 16:56:18 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > Use the __weak macro instead of the longer __attribute__ ((weak)) form
> > > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > --
> > > 
> > >  init/main.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- linux-work.orig/init/main.c	2008-04-18 16:44:32.000000000 +1000
> > > +++ linux-work/init/main.c	2008-04-18 16:44:37.000000000 +1000
> > > @@ -500,7 +500,7 @@ static void __init boot_cpu_init(void)
> > >  	cpu_set(cpu, cpu_possible_map);
> > >  }
> > >  
> > > -void __init __attribute__((weak)) smp_setup_processor_id(void)
> > > +void __init __weak smp_setup_processor_id(void)
> > >  {
> > >  }
> > 
> > ack on all three. Please fold #3 into #1 and add both to git-powerpc.
> 
> Damn ! I took 5mn to actually split it out in order to not do two
> different things in one patch :-)

ah, I misread it.  I thought this was changing the __attribute__((weak))
which patch #1 added.  But it's changing a different one.  I though that
was odd.

> Will do.

whatever ;)
