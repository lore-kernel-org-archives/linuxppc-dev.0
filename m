Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CFE10DDD09
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 11:49:08 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6N2CS1w173540
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 12:12:28 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6N1pPUZ151754
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 11:51:25 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6N1lqSX015858
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 11:47:52 +1000
Date: Mon, 23 Jul 2007 11:43:37 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Someone broke my allmodconfig build
Message-ID: <20070723014337.GC3272@localhost.localdomain>
References: <20070722001212.5007001d.sfr@canb.auug.org.au>
	<18082.42674.651685.720737@cargo.ozlabs.ibm.com>
	<20070722020412.GQ3925@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070722020412.GQ3925@crusty.rchland.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 21, 2007 at 09:04:13PM -0500, Josh Boyer wrote:
> On Sun, Jul 22, 2007 at 10:37:06AM +1000, Paul Mackerras wrote:
> > Stephen Rothwell writes:
> > 
> > >   WRAP    arch/powerpc/boot/zImage.ps3
> > > /home/sfr/kernels/linus/arch/powerpc/boot/wrapper: line 113: dtc: command not found
> > > make[2]: *** [arch/powerpc/boot/zImage.ps3] Error 1
> > 
> > Hmmm, we should be shipping .dtb files with the tree, so people don't
> > have to have dtc installed.
> 
> Really?  I don't think we're quite ready for that.  Particularly for the
> embedded boards.  Those DTS files still get lots of churn, and having to
> update both the .dts and .dtb at the same time seems a bit fragile.

I sort of prefer this option in theory, but it's basically
impossible.  People updating dts files by patch would also have to
update the dtb, which can't be done in a normal patch, since they're
binary.

I'm working with sfr now on importing dtc into the kernel tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
