Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 2CC1568593
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Nov 2005 01:50:28 +1100 (EST)
Date: Fri, 4 Nov 2005 07:50:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Message-ID: <20051104145027.GQ3839@smtp.west.cox.net>
References: <20051103183256.GJ3839@smtp.west.cox.net>
	<20051104042524.GD8515@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051104042524.GD8515@pb15.lixom.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14] ppc32: Allow for bigger compressed kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 03, 2005 at 08:25:24PM -0800, Olof Johansson wrote:
> On Thu, Nov 03, 2005 at 11:32:56AM -0700, Tom Rini wrote:
> 
> > --- a/arch/ppc/boot/simple/misc.c
> > +++ b/arch/ppc/boot/simple/misc.c
> > @@ -7,10 +7,10 @@
> >   * your serial console.  If a machine meets these requirements, it can quite
> >   * likely use this code during boot.
> >   *
> > - * Author: Matt Porter <mporter@mvista.com>
> > + * Author: Tom Rini <trini@mvista.com>
> >   * Derived from arch/ppc/boot/prep/misc.c
> 
> I understand adding authors to a file when code is added, but why should
> author credit be removed?

It wasn't Matt's code really.  I know he did the 44x EMAC fixes, but
other than that it was my code, heavily cribbed from all of the old
per-board bootwrappers, that were cribbed from the prep one.

-- 
Tom Rini
http://gate.crashing.org/~trini/
