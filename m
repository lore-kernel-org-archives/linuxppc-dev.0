Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 0AF31DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 03:29:03 +1000 (EST)
Date: Fri, 13 Jul 2007 10:31:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] Kconfig cleanup revisited
Message-ID: <20070713173128.GA1714@mag.az.mvista.com>
References: <20070712210156.973038514@arndb.de>
	<20070713013953.GC29074@mag.az.mvista.com>
	<200707131154.34800.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707131154.34800.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2007 at 11:54:34AM +0200, Arnd Bergmann wrote:
> On Friday 13 July 2007, Mark A. Greer wrote:
> > I really like what you've done here, thanks.
> > 
> > The patches don't apply straight up so what other patches do these go
> > on top of?
> 
> They are meant to apply on top of powerpc.git.

Yep, me too.

> I found now that
> the first patch has a trivial reject against the for-2.6.23 branch,
> but works fine for the master branch.

Hrm, I'm on master and it doesn't apply but its minor so NBD.

> Should I resend?

Not for me but Paul might appreciate it. :)

Mark
