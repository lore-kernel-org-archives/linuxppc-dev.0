Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7397CDDED2
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 00:22:52 +1000 (EST)
Date: Wed, 18 Jul 2007 10:20:50 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PPC:  Prevent direct inclusion of <asm/rwsem.h>.
In-Reply-To: <C5BB127A-BE08-41D9-A516-2F309A1E2E52@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0707181018270.23545@localhost.localdomain>
References: <Pine.LNX.4.64.0707180934550.20961@localhost.localdomain>
	<C5BB127A-BE08-41D9-A516-2F309A1E2E52@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Jul 2007, Kumar Gala wrote:

>
> On Jul 18, 2007, at 8:36 AM, Robert P. J. Day wrote:
>
> >
> > Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
>
> Can you provide some commit description as to why we are doing this?
>
> - k
>
> >
> > ---
> >
> >   not compile-tested, so if there's a flaw here somewhere, feel free
> > to tweak it.
> >
> >  arch/ppc/syslib/ocp.c       |    2 +-
> >  include/asm-powerpc/rwsem.h |    4 ++++
> >  include/asm-ppc/ocp.h       |    2 +-
> >  3 files changed, 6 insertions(+), 2 deletions(-)

based on the pattern across all architectures, it would seem that
asm/rwsem.h is not *meant* to be included directly, but only via
linux/rwsem.h.  i'm not sure if that's the kind of rationale you're
looking for, or if you want a more technical description.

at the moment, ppc is the only architecture that is doing the above,
but it may be that there's a good reason for that that i'm just not
aware of.

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
