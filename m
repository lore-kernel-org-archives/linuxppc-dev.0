Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36117DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 08:25:50 +1100 (EST)
Date: Tue, 31 Mar 2009 14:22:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Add hvc_console to MAINTAINERS
Message-Id: <20090331142252.3bf74fe1.akpm@linux-foundation.org>
In-Reply-To: <1238533823.9715.292.camel@localhost>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
	<20090330205553.GA19278@yoda.jdub.homelinux.org>
	<20090330141852.59baaeda.akpm@linux-foundation.org>
	<20090331132944.GB2332@yoda.jdub.homelinux.org>
	<1238533823.9715.292.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, roel.kluin@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 31 Mar 2009 14:10:23 -0700
Joe Perches <joe@perches.com> wrote:

> On Tue, 2009-03-31 at 09:29 -0400, Josh Boyer wrote:
> > Add a MAINTAINERS entry for the hypervisor virtual console support
> > used on IBM POWER servers.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > ---
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c5f4e9d..387ad45 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2176,6 +2176,11 @@ W:       http://www.ia64-linux.org/
> >  T:     git kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
> >  S:     Maintained
> >  
> > +IBM HYPERVISOR VIRTUAL CONSOLE
> > +P:     Several
> > +L:     linuxppc-dev@ozlabs.org
> > +S:     Maintained
> > +
> >  IBM MCA SCSI SUBSYSTEM DRIVER
> >  P:     Michael Lang
> >  M:     langa2@kph.uni-mainz.de
> 
> I think this sort of entry should not be acceptable.
> Maintainers should have individual names and contact addresses.

There isn't a maintainer.

But people send patches to the wrong list, so the ppc guys (who use
this driver) don't get to see them.

That's a practical, real-world problem.  We should have a fix for it.

> An exploder entry should be OK though.
> For instance, the DVB subsystem:
> 
> 	DVB SUBSYSTEM AND DRIVERS
> 	P:	LinuxTV.org Project
> 	M:	linux-media@vger.kernel.org
> 
> A list entry could be something like:
> 
> 	P:	Linux PCMCIA Team
> 	L:	linux-pcmcia@lists.infradead.org
> 

I'm unclear on what the difference is here..
