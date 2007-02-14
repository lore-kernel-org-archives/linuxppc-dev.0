Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22338DDEBE
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:57:37 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1E0vT8Y001811
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 19:57:30 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1E0vTbc299640
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 19:57:29 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1E0vTLb002602
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 19:57:29 -0500
Date: Tue, 13 Feb 2007 19:02:36 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 7/16] Early serial debug support for PPC44x
Message-ID: <20070214010235.GB19430@crusty.rchland.ibm.com>
References: <20070213061024.DA1ABDDD0C@ozlabs.org>
	<1171379087.4003.40.camel@zod.rchland.ibm.com>
	<20070214001622.GB11491@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070214001622.GB11491@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 11:16:22AM +1100, David Gibson wrote:
> >  AS      arch/powerpc/kernel/head_44x.o
> > arch/powerpc/kernel/head_44x.S: Assembler messages:
> > arch/powerpc/kernel/head_44x.S:179: Warning: left operand is a bignum;
> > integer 0 assumed
> > arch/powerpc/kernel/head_44x.S:183: Error: bignum invalid
> > arch/powerpc/kernel/head_44x.S:184: Warning: left operand is a bignum;
> > integer 0 assumed
> > make[1]: *** [arch/powerpc/kernel/head_44x.o] Error 1
> > make: *** [arch/powerpc/kernel] Error 2
> 
> Um... works for me?  What version of the assembler are you using?
> 
> I'm using a 64-bit constant there, but for me at least the assembler
> is able to handle manipulating it in constant expressions.

[jwboyer@zod ~]$ powerpc-440-linux-gnu-as --version
GNU assembler 2.15

This is a crosstool built toolchain with binutils 2.15 and gcc 3.4.1.
Which versions are you using?

josh
