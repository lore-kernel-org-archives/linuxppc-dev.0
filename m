Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56B99DDEDE
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:20:39 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7D1N7Mf5157060
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:23:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7D1KZfP2310398
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:20:35 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7D1KZB6029820
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:20:35 +1000
Date: Sun, 12 Aug 2007 19:25:59 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070812092558.GA6803@localhost.localdomain>
References: <20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
	<20070727013331.GB1561@localhost.localdomain>
	<20070806084813.5432ba91@weaponx.rchland.ibm.com>
	<20070810013001.GF17370@localhost.localdomain>
	<20070809203754.2e9192c5@zod.rchland.ibm.com>
	<20070810025944.GI17370@localhost.localdomain>
	<18109.2103.507694.281225@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18109.2103.507694.281225@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 11, 2007 at 10:52:07AM +1000, Paul Mackerras wrote:
> David Gibson writes:
> 
> > We decided that since a formal dtc release was imminent, it would be
> > simpler to make dtc a new kernel build requirement, rather than
> > integrate the substantial blob of dtc code into the kernel tree and
> > then have to deal with the maintenance / synchronization issues
> > between the in-kernel and upstream versions.
> 
> Um, what I thought we decided was to ship a pre-built .dtb for ps3
> (once its dts settles down), and make dtc a kernel build requirement
> only for embedded platforms.

Oh, yes, sorry forgot that detail.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
