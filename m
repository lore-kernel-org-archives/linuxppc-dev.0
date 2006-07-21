Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3300D67B96
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jul 2006 00:42:48 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Brian D. Carlstrom'" <bdc@carlstrom.com>,
	"'Olof Johansson'" <olof@lixom.net>
Subject: RE: AltiVec in the kernel
Date: Fri, 21 Jul 2006 09:42:32 -0500
Message-ID: <000001c6acd3$ea93f5c0$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <lezmf4j5ym.wl%bdc@carlstrom.com>
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 

> -----Original Message-----
> From: linuxppc-dev-bounces+matt=genesi-usa.com@ozlabs.org 
> [mailto:linuxppc-dev-bounces+matt=genesi-usa.com@ozlabs.org] 
> On Behalf Of Brian D. Carlstrom
> Sent: Thursday, July 20, 2006 4:57 PM
> To: Olof Johansson
> Cc: 'Paul Mackerras'; 'linuxppc-dev list'
> Subject: Re: AltiVec in the kernel
> 
> At Thu, 20 Jul 2006 14:05:23 -0500, Olof Johansson wrote:
> > On Thu, Jul 20, 2006 at 11:47:04AM -0700, Brian D. Carlstrom wrote:
> > > A quick grep memcpy in the recent glibc sources on my 
> linux/ppc box 
> > > seems to show no where near that level of optimization, 
> but I admit 
> > > that I could have missed something.
> > 
> > http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html
> 
> Very interesting. According to that page, the memcpy 
> optimizations seem to be using 64-bit operations and that 
> 128-bit AltiVec operations are still being solicited. 

"Still"?

http://www.freevec.org/ 

Been there for months, before the glibc thing. Most of the functions
are ready. Anyone can bugfix this. The beauty of GPL. The ugly part
is.. we've had this there for months. Nobody has contributed a single
update or bugfix or even a performance test as far as I know.

> However, I'm guessing this addon is not something found in 
> common distributions for PowerPC like Debian, Fedora, Gentoo, 
> Ubuntu, ...

Indeed it's a cute feature but we were scared away by the glibc guys
when it came to glibc-ports (perhaps they just considered it not
ready, but we wanted it in there for the first release, which was
the next one). Hence freevec. Konstantinos will get back in a couple
weeks and post some updates.

The more interesting code is the MySQL stuff. All of this has been
developed by finding good examples of apps, profiling them and then
optimizing the top few functions that are most used.

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
