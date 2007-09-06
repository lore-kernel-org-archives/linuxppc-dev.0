Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E84F0DDEB7
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 03:24:24 +1000 (EST)
Date: Thu, 6 Sep 2007 12:24:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
Message-ID: <20070906172415.GA18226@ld0162-tx32.am.freescale.net>
References: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
	<20070906165535.GA11420@iram.es>
	<20070906170123.GA17990@ld0162-tx32.am.freescale.net>
	<20070906170547.GA12432@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906170547.GA12432@iram.es>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 07:05:47PM +0200, Gabriel Paubert wrote:
> On Thu, Sep 06, 2007 at 12:01:23PM -0500, Scott Wood wrote:
> > On Thu, Sep 06, 2007 at 06:55:35PM +0200, Gabriel Paubert wrote:
> > > So who will be in charge of updating the RTC now? The update 
> > > every 11 min is there to stay on x86(-64) it seems.
> > 
> > Put something in crontab to run hwclock periodically.
> 
> I have many machines on which cron is not even installed.

OK, so use something else that waits in a loop and periodically updates
the clock.  It shouldn't be the kernel's responsibility.

-Scott
