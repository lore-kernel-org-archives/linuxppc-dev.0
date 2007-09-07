Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFB62DDF21
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 00:28:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l87ESeM4031013
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 10:28:40 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l87ESdko266214
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 08:28:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l87EScWi022905
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 08:28:39 -0600
Date: Fri, 7 Sep 2007 09:28:37 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Document and implement an improved flash device binding for
	powerpc (v5)
Message-ID: <20070907092837.66553767@weaponx.rchland.ibm.com>
In-Reply-To: <2fcd14e175d5a215cd8d602ac74fce21@kernel.crashing.org>
References: <20070907032353.GA3082@localhost.localdomain>
	<2fcd14e175d5a215cd8d602ac74fce21@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 7 Sep 2007 16:25:10 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > This patch replaces the binding for flash chips in
> > booting-without-of.txt with an clarified and improved version.  It
> > also makes drivers/mtd/maps/physmap_of.c recognize this new binding.
> > Finally it revises the Ebony device tree source to use the new binding
> > as an example.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
> 
> Thanks for doing this work David!

Indeed.  This looks good to me as well.  Once it gets in a tree
somewhere I'll get Walnut switched over.

josh
