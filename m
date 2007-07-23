Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 29929DDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 01:17:42 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6NFHdTF003530
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 11:17:39 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6NFHant199278
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 09:17:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6NFHZRN008588
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 09:17:36 -0600
Subject: Re: Someone broke my allmodconfig build
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40707230807k450ff82dv11201ca3a4ce4c9b@mail.gmail.com>
References: <20070722001212.5007001d.sfr@canb.auug.org.au>
	<18082.42674.651685.720737@cargo.ozlabs.ibm.com>
	<20070722115354.0c28d704.sfr@canb.auug.org.au>
	<46A4A9DC.6010602@freescale.com>
	<fa686aa40707230807k450ff82dv11201ca3a4ce4c9b@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 23 Jul 2007 10:17:31 -0500
Message-Id: <1185203851.4268.7.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	Timur Tabi <timur@freescale.com>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-23 at 09:07 -0600, Grant Likely wrote:
> On 7/23/07, Timur Tabi <timur@freescale.com> wrote:
> > Stephen Rothwell wrote:
> >
> > >> Hmmm, we should be shipping .dtb files with the tree, so people don't
> > >> have to have dtc installed.
> > >
> > > Unless, of course, we ship dtc ...
> >
> > I like that idea.
> >
> > I don't know much about the kernel build process, but is it normal to ship C files and have kbuild build them and then use the executables to build the rest of the kernel?
> 
> That's how Kconfig is built.

And mktree.

josh
