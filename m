Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp9.wanadoo.fr (smtp9.wanadoo.fr [193.252.22.22])
	by ozlabs.org (Postfix) with ESMTP id 3520E2BF0E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2005 08:40:31 +1100 (EST)
Date: Thu, 6 Jan 2005 22:49:27 +0100
To: Christian <evilninja@gmx.net>
Message-ID: <20050106214927.GA10588@pegasos>
References: <1104850036.6164.25.camel@weizen.left.earth>
	<200501051233.25622.marvin24@gmx.de>
	<20050105154753.GA26760@pegasos> <41DC1F7E.5030003@gmx.net>
	<20050105173908.GC29131@pegasos> <41DD60A3.3020203@gmx.net>
	<20050106162711.GA32598@pegasos>
	<21643.195.126.66.126.1105043230.squirrel@housecafe.dyndns.org>
	<20050106210742.GA8598@pegasos>
	<39090.195.126.66.126.1105046464.squirrel@housecafe.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <39090.195.126.66.126.1105046464.squirrel@housecafe.dyndns.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 06, 2005 at 10:21:04PM +0100, Christian wrote:
> On Thu, January 6, 2005 22:07, Sven Luther said:
> >>
> >> no disks attached, but i will do some more tests on this tonight...
> >
> > Ah, no wonder you don't see a disk then ...
> 
> ;-)
> 
> > I wonder if d-i is upto installing a NFS-root system, i don't think so.
> 
> yes, i can see that. nfsroot is my only way to go here. (will probably get
> a proper scsi-cable soon)

If your NFS server is also powerpc, you could just debootstrap the partition
there :) I guess pure NFS support will have to wait for sarge+1. Now that d-i
is branched, patches are welcome though.

> > See :
> >   http://svn.debian.org/wsvn/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches/powerpc-prep-powerstack-irq.dpatch?op=file&rev=0&sc=0
> 
> ah, ok. will try.

I just moved it to 2.6.9, but these kernel-source are not yet released, and
probably won't be until this WE or something, at which point the official
powerpc kernels will include it. With a bit of luck we will have real prep
support in d-i two weeks from now, depending how i am able to fix the
partman-prep horror story. (Added bunch of logs -> it worked, removed them ->
don't work anymore, altough it works on power4 chrp hardware :/)

Friendly,

Sven Luther
