Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65FD9DDEC4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 11:38:12 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7A1c6Jk025160
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 21:38:06 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7A1c6Fw532124
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 21:38:06 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7A1c50Q028054
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 21:38:06 -0400
Date: Thu, 9 Aug 2007 20:37:54 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070809203754.2e9192c5@zod.rchland.ibm.com>
In-Reply-To: <20070810013001.GF17370@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
	<20070727013331.GB1561@localhost.localdomain>
	<20070806084813.5432ba91@weaponx.rchland.ibm.com>
	<20070810013001.GF17370@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 10 Aug 2007 11:30:01 +1000
David Gibson <dwg@au1.ibm.com> wrote:

> > Except didn't you say you were going to work with Stephen to get DTC
> > into the kernel source itself?  Keeping things similar to Kbuild might
> > help in that effort.
> 
> Actually, after discussions with Stephen and Paulus, we decided not to
> take this route.  In any case having Kbuild like versioning wouldn't
> actually help us any in integrating into a full Kbuild system.

Can you elaborate why you decided not to?  I'm just curious.

> > > Have a look at the patch I posted.  I haven't sufficiently tested it
> > > yet, but it should be able to generated version info for a tarball too
> > > (provided the .git-manifest file is included, and I'm intending that
> > > will be build by a make dist target).  It will give both the
> > > git-derived based version, and a file content derived hash so we can
> > > robustly tell different builds apart, all with less code than the
> > > current system.
> > 
> > That may be.  But I don't see the current approach being too much of a
> > problem either.  Especially given that it's already there and it
> > works.  Oh, and you sent out your patch saying it wasn't ready for
> > merge and with no sign off.  Small but important issues to fix I'd
> > think.
> 
> Yeah, it lacks a make dist target, and needs a bit more work to
> support that properly.  Never mind, I'll revisit this post the 1.0
> release.

Ok.

josh
