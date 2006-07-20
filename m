Return-Path: <bdc@carlstrom.com>
Received: from electricrain.com (electricrain.com [207.7.145.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2562F67B9A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 07:56:37 +1000 (EST)
Date: Thu, 20 Jul 2006 14:56:33 -0700
Message-ID: <lezmf4j5ym.wl%bdc@carlstrom.com>
From: "Brian D. Carlstrom" <bdc@carlstrom.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: AltiVec in the kernel
In-Reply-To: <20060720190523.GA27775@pb15.lixom.net>
References: <20060719181047.GL5905@austin.ibm.com>
	<001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
	<20060720174255.GP5905@austin.ibm.com>
	<le8xmoktav.wl%bdc@carlstrom.com>
	<20060720190523.GA27775@pb15.lixom.net>
Cc: 'Paul Mackerras' <paulus@samba.org>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
Reply-To: "Brian D. Carlstrom" <bdc@carlstrom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At Thu, 20 Jul 2006 14:05:23 -0500, Olof Johansson wrote:
> On Thu, Jul 20, 2006 at 11:47:04AM -0700, Brian D. Carlstrom wrote:
> > A quick grep memcpy in the recent glibc sources on my linux/ppc box
> > seems to show no where near that level of optimization, but I admit
> > that I could have missed something.
> 
> http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html

Very interesting. According to that page, the memcpy optimizations seem
to be using 64-bit operations and that 128-bit AltiVec operations are
still being solicited. 

I was encouraged to see the following: 

    If you need to build generic distributions (supporting several
    <cpu_types>) you can leverage the dl_procinfo support built into
    glibc. This mechanism allows for multiple versions of the core
    libraries (libc, libm, librt, libpthread, libpthread_db) to be
    stored in hardware/platform specific subdirectories under /lib[64].

However, I'm guessing this addon is not something found in common
distributions for PowerPC like Debian, Fedora, Gentoo, Ubuntu, ...

-bri
