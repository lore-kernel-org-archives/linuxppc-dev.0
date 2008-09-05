Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E557DDFC5
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 14:37:57 +1000 (EST)
Subject: Re: 2.6.27-rc5-mm1 mystery trace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080904210412.2be5d7da.akpm@linux-foundation.org>
References: <20080904202032.2299c2c8.akpm@linux-foundation.org>
	<1220586862.4879.123.camel@pasglop>
	<20080904210412.2be5d7da.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 14:37:19 +1000
Message-Id: <1220589439.4879.127.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-09-04 at 21:04 -0700, Andrew Morton wrote:
> On Fri, 05 Sep 2008 13:54:22 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > > a) someone broke powerpc's kallsyms processing and
> > > 
> > > b) someone screwed up their procfs handling.
> > 
> > I think the proc bug is old, might have to do with /proc/bus/pci... 
> > I have that on my G5 too with 2.6.26, I think I just forgot about it..
> > Care to give that untested patch a try ?
> 
> uh, soon, hopfully.  The wife pinched the monitor.
> 
> I'd be more worried about the kallsyms non-workage?

yes, that's the harder part :-) somebody will have to dig. I don't have
the cycles today but next if if nobody raised a hand, I can have a look.

Ben.
