Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52DA6DDEC9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 12:00:48 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1ED2E9P7782414
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 12:02:14 -0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1E14GZa181000
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 12:04:16 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1E10khX012940
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 12:00:46 +1100
Date: Wed, 14 Feb 2007 12:00:44 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/16] Early serial debug support for PPC44x
Message-ID: <20070214010044.GG11491@localhost.localdomain>
References: <20070213061024.DA1ABDDD0C@ozlabs.org>
	<1171379087.4003.40.camel@zod.rchland.ibm.com>
	<20070214001622.GB11491@localhost.localdomain>
	<20070214010235.GB19430@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070214010235.GB19430@crusty.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 07:02:36PM -0600, Josh Boyer wrote:
> On Wed, Feb 14, 2007 at 11:16:22AM +1100, David Gibson wrote:
> > >  AS      arch/powerpc/kernel/head_44x.o
> > > arch/powerpc/kernel/head_44x.S: Assembler messages:
> > > arch/powerpc/kernel/head_44x.S:179: Warning: left operand is a bignum;
> > > integer 0 assumed
> > > arch/powerpc/kernel/head_44x.S:183: Error: bignum invalid
> > > arch/powerpc/kernel/head_44x.S:184: Warning: left operand is a bignum;
> > > integer 0 assumed
> > > make[1]: *** [arch/powerpc/kernel/head_44x.o] Error 1
> > > make: *** [arch/powerpc/kernel] Error 2
> > 
> > Um... works for me?  What version of the assembler are you using?
> > 
> > I'm using a 64-bit constant there, but for me at least the assembler
> > is able to handle manipulating it in constant expressions.
> 
> [jwboyer@zod ~]$ powerpc-440-linux-gnu-as --version
> GNU assembler 2.15
> 
> This is a crosstool built toolchain with binutils 2.15 and gcc 3.4.1.
> Which versions are you using?

Hmm.. I appear to have binutils-2.17.  That could be it.

It would be nice to support the older binutils too, but I'm not sure
how to get around this without considerable inconvenience.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
