Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3847467BC0
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jul 2006 02:51:42 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6LGpV2X023263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 12:51:31 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6LGpVtx288584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 10:51:31 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6LGpUfC021468
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 10:51:31 -0600
Date: Fri, 21 Jul 2006 11:51:30 -0500
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: AltiVec in the kernel
Message-ID: <20060721165130.GS5905@austin.ibm.com>
References: <lezmf4j5ym.wl%bdc@carlstrom.com>
	<000001c6acd3$ea93f5c0$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001c6acd3$ea93f5c0$99dfdfdf@bakuhatsu.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: 'Olof Johansson' <olof@lixom.net>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 21, 2006 at 09:42:32AM -0500, Matt Sealey wrote:
>  
> > > http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html
> > 
> > 128-bit AltiVec operations are still being solicited. 
> 
> "Still"?
> 
> http://www.freevec.org/ 
> 
> Been there for months, before the glibc thing. Most of the functions
> are ready. Anyone can bugfix this. The beauty of GPL. The ugly part
> is.. we've had this there for months. Nobody has contributed a single
> update or bugfix or even a performance test as far as I know.

Sounds like a problem of advertising and communications.  This is
kind of "under the radar" for most users and developers. It needs to
work out-of-the-box, most people, even those with interest in
performance, will not even be aware of the possibility to tne this.

It should be folded into glibc. It is up to the altivec product vendor
to nag the glibc folks into folding it in. This task could be as hard
as writing the code in the first place.

> Indeed it's a cute feature but we were scared away by the glibc guys

Many maintainers of core libraries have similar behaviour patterns.
Besides glibc, gcc and gsl come to mind. This is becase they get tired out
by naive eager-beavers who walk in with the greatest idea in the world,
make a big fuss about it, and the proceed to demonstrate that they have 
absolutely no clue of what they're talking about.  For every ten of 
those, there's maybe one legit idea. Worse, many of these "clueless 
newbies" come in the surprising shape of PhD's working outside thier 
specialty, and can convingingly sling jargon and authority for a while 
before its realized they're just... clueless.

If you've got good code, you'll just need to be persistent.

--linas
