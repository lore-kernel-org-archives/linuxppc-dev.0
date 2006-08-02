Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 44FBE67B9D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 02:56:48 +1000 (EST)
Date: Wed, 2 Aug 2006 10:00:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060802170032.GD17652@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<17616.12251.339657.215571@cargo.ozlabs.ibm.com>
	<200608021441.23429.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200608021441.23429.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 02:41:23PM +0200, Arnd Bergmann wrote:
> On Wednesday 02 August 2006 06:53, Paul Mackerras wrote:
> > > +#ifdef __powerpc64__
> > > +typedef unsigned long                u64;
> > > +#else
> > > +typedef unsigned long long   u64;
> > > +#endif
> > 
> > This is potentially confusing, because the __powerpc64__ relates to
> > the boot wrapper not the kernel, and we don't build a 64-bit boot
> > wrapper on any platform (not yet anyway).  Maybe this needs a comment.
> > 
> Moreover, even if we ever build this on __powerpc64__, the 
> typedef unsigned long long u64 would still do the right thing.
> It only ever becomes a problem when mixing with u64 the c99 uint64_t,
> which is defined the other way.

I copied that code from somewhere but I forget where & can't seem to
find it now.  I'll get rid of it for now.

Mark
