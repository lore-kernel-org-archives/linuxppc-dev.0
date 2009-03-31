Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 738A1DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 10:53:35 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2VNoeP9016655
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 17:50:40 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2VNrUXk211450
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 17:53:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2VNrUTW013135
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 17:53:30 -0600
Date: Tue, 31 Mar 2009 19:52:48 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Add hvc_console to MAINTAINERS
Message-ID: <20090331235248.GC563@zod.rchland.ibm.com>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
	<20090330205553.GA19278@yoda.jdub.homelinux.org>
	<20090330141852.59baaeda.akpm@linux-foundation.org>
	<20090331132944.GB2332@yoda.jdub.homelinux.org>
	<1238533823.9715.292.camel@localhost>
	<20090331142252.3bf74fe1.akpm@linux-foundation.org>
	<1238535658.9715.321.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238535658.9715.321.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	roel.kluin@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 02:40:58PM -0700, Joe Perches wrote:
>On Tue, 2009-03-31 at 14:22 -0700, Andrew Morton wrote:
>> On Tue, 31 Mar 2009 14:10:23 -0700
>> Joe Perches <joe@perches.com> wrote:
>> > On Tue, 2009-03-31 at 09:29 -0400, Josh Boyer wrote:
>> > > Add a MAINTAINERS entry for the hypervisor virtual console support
>> > > used on IBM POWER servers.
>> > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > index c5f4e9d..387ad45 100644
>> > > --- a/MAINTAINERS
>> > > +++ b/MAINTAINERS
>> > > @@ -2176,6 +2176,11 @@ W:       http://www.ia64-linux.org/
>> > >  T:     git kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
>> > >  S:     Maintained
>> > >  
>> > > +IBM HYPERVISOR VIRTUAL CONSOLE
>> > > +P:     Several
>> > > +L:     linuxppc-dev@ozlabs.org
>> > > +S:     Maintained
>> > > +
>> > >  IBM MCA SCSI SUBSYSTEM DRIVER
>> > >  P:     Michael Lang
>> > >  M:     langa2@kph.uni-mainz.de
>> > 
>> > I think this sort of entry should not be acceptable.
>> > Maintainers should have individual names and contact addresses.
>> 
>> There isn't a maintainer.
>> 
>> But people send patches to the wrong list, so the ppc guys (who use
>> this driver) don't get to see them.
>> 
>> That's a practical, real-world problem.  We should have a fix for it.
>> 
>> > An exploder entry should be OK though.
>> > For instance, the DVB subsystem:
>> > 
>> > 	DVB SUBSYSTEM AND DRIVERS
>> > 	P:	LinuxTV.org Project
>> > 	M:	linux-media@vger.kernel.org
>> > 
>> > A list entry could be something like:
>> > 
>> > 	P:	Linux PCMCIA Team
>> > 	L:	linux-pcmcia@lists.infradead.org
>> > 
>> 
>> I'm unclear on what the difference is here..
>
>I have no problem with the "L: list" entry.
>I think that's good.  Along with some file
>matching pattern as well of course...
>
>I think the "P: Several" entry is not good.
>
>"Several" doesn't give any idea as to who
>actually does the work.

I copied that from something else in MAINTAINERS.  I believe it
was the KERNEL JANITORS entry.  I guess I should have known better
than to copy from that...

>If the "P:" entry is there at all, it should
>be the list name.
>
>Maybe "P: Linux PPC Development Team" or
>something similar.

Except that isn't right for the reasons Michael specified.

josh
