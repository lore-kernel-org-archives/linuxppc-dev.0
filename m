Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 738B1DDDCA
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 07:07:49 +1000 (EST)
Date: Thu, 24 May 2007 14:07:41 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Message-ID: <20070524210741.GA32012@mag.az.mvista.com>
References: <4655C7A6.2050606@mvista.com>
	<2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
	<1180035543.3360.25.camel@zod.rchland.ibm.com>
	<200705242221.17790.arnd@arndb.de>
	<1180038295.3360.29.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180038295.3360.29.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 24, 2007 at 03:24:55PM -0500, Josh Boyer wrote:
> On Thu, 2007-05-24 at 22:21 +0200, Arnd Bergmann wrote:
> > On Thursday 24 May 2007, Josh Boyer wrote:

> > The common files really need to be built with -mcpu flags that
> > make the code work on any system if you want to be able
> > to use just a single boot wrapper binary for all.
> 
> Yeah, it's finding those combinations that work for all the existing
> toolchains out there that's the issue.  That, or making the wrapper not
> compile all the platform files...  I don't know which makes more sense.

The number of files in the bootwrapper is bound to grow, there are
so many combinations that will never be used together, and we're
bumping into lots of toolchain issues, that I'm beginning to think
that paring down wrapper.a is the way to go.

Mark
