Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <20050806005941.5d1fe432.sfr@canb.auug.org.au>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<688ba2276de281a9473b030a16a514c0@embeddededge.com>
	<20050805174705.731ffa05.sfr@canb.auug.org.au>
	<200508051353.23750.arnd@arndb.de>
	<20050806005941.5d1fe432.sfr@canb.auug.org.au>
Content-Type: text/plain
Message-Id: <1125089709.32488.35.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 26 Aug 2005 15:55:11 -0500
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning
	Merger Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-08-05 at 09:59, Stephen Rothwell wrote:

> > Another interesting point about it is which define to use. For s390, we
> > decided to '#ifdef __s390x__' rather than '#ifdef CONFIG_ARCH_S390X' or
> > 'ifdef CONFIG_64BIT', because CONFIG_* does not work when including the
> > headers from user space.
> 
> Well noone should even include kernel headers from user space :-) and my
> understanding is that glibc "sanitizes" its version of the kernel headers
> anyway.
> 
> > Using CONFIG_64BIT instead of __powerpc64__ only within #ifdef __KERNEL__
> > would be correct but less consistant.
> 
> The advantage of using CONFIG_64BIT as much as possible is that it shows
> us places that can be consolidated across the various architectures
> (which is a bit of a passion of mine :-)).  And more consolidation should
> make life easier for the glibc folks in the long run.

Hi guys,

Well, the time has come when I need an answer to this
question in order to make more progress on merging
some include files.

Anyone care to take a semi-authoritative stand on what
symbol to use to distinguish 32/64-bit-ness in the
include files?

Thanks,
jdl
