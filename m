Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA699DDE28
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 13:50:04 +1000 (EST)
Date: Thu, 4 Sep 2008 20:49:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: 2.6.27-rc5-mm1 mystery trace
Message-Id: <20080904204957.04a420ac.akpm@linux-foundation.org>
In-Reply-To: <1220586164.4879.116.camel@pasglop>
References: <20080904202032.2299c2c8.akpm@linux-foundation.org>
	<1220586164.4879.116.camel@pasglop>
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

On Fri, 05 Sep 2008 13:42:44 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > This is stupid:
> > 
> > g5:/usr/src/25> gdb vmlinux
> > GNU gdb Red Hat Linux (6.3.0.0-1.21rh)
> > Copyright 2004 Free Software Foundation, Inc.
> > GDB is free software, covered by the GNU General Public License, and you are
> > welcome to change it and/or distribute copies of it under certain conditions.
> > Type "show copying" to see the conditions.
> > There is absolutely no warranty for GDB.  Type "show warranty" for details.
> > This GDB was configured as "ppc-yellowdog-linux-gnu"..."/usr/src/25/vmlinux": not in executable format: File format not recognized
> > 
> > probably there's some command line magic to make it work, but there
> > shouldn't be.
> 
> Is this a 64 bits gdb ?
> 

I don't think so - it's whatever ydl4.1 gave me.

A 64-bit binary on a 64-bit machine Should Just Work.  Maybe that's
me being simplistic.
