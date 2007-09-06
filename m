Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 21909DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 03:05:56 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 6 Sep 2007 19:05:47 +0200
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
Message-ID: <20070906170547.GA12432@iram.es>
References: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
	<20070906165535.GA11420@iram.es>
	<20070906170123.GA17990@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906170123.GA17990@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 12:01:23PM -0500, Scott Wood wrote:
> On Thu, Sep 06, 2007 at 06:55:35PM +0200, Gabriel Paubert wrote:
> > On Fri, Sep 07, 2007 at 12:41:38AM +1000, Paul Mackerras wrote:
> > > This changes PowerPC to use the generic time infrastructure for
> > > gettimeofday et al.  We register a clocksource which uses the timebase
> > > register, or the RTC on the 601.
> > > 
> > > It also gets rid of the RTC update stuff.  IIRC we discussed removing
> > > this some time ago but never actually did it.
> > 
> > So who will be in charge of updating the RTC now? The update 
> > every 11 min is there to stay on x86(-64) it seems.
> 
> Put something in crontab to run hwclock periodically.
> 

I have many machines on which cron is not even installed.

	Gabriel
