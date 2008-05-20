Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8487DDE193
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 22:10:45 +1000 (EST)
Date: Tue, 20 May 2008 16:10:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/7] [POWERPC] QE: add support for QE USB clocks routing
Message-ID: <20080520121041.GA14573@polina.dev.rtsoft.ru>
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174655.GB28185@polina.dev.rtsoft.ru>
	<20080520140413.5ae74d65.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080520140413.5ae74d65.sfr@canb.auug.org.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 02:04:13PM +1000, Stephen Rothwell wrote:
> Hi Anton,
> 
> On Mon, 19 May 2008 21:46:55 +0400 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +++ b/arch/powerpc/sysdev/qe_lib/usb.c
> 
> > +#include <linux/of.h>
> 
> Nothing in this file requires anything in linux/of.h or asm/of.h ...

Yeah, this is left-over... Thanks for catching this.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
