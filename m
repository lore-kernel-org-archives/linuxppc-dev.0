Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D40D0DE042
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 14:04:48 +1000 (EST)
Date: Thu, 4 Sep 2008 21:04:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: 2.6.27-rc5-mm1 mystery trace
Message-Id: <20080904210412.2be5d7da.akpm@linux-foundation.org>
In-Reply-To: <1220586862.4879.123.camel@pasglop>
References: <20080904202032.2299c2c8.akpm@linux-foundation.org>
	<1220586862.4879.123.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 05 Sep 2008 13:54:22 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > a) someone broke powerpc's kallsyms processing and
> > 
> > b) someone screwed up their procfs handling.
> 
> I think the proc bug is old, might have to do with /proc/bus/pci... 
> I have that on my G5 too with 2.6.26, I think I just forgot about it..
> Care to give that untested patch a try ?

uh, soon, hopfully.  The wife pinched the monitor.

I'd be more worried about the kallsyms non-workage?
