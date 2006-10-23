Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61C2967A03
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 07:12:41 +1000 (EST)
Subject: Re: [PATCH 1/5] powerpc: consolidate feature fixup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17724.39959.51600.232589@cargo.ozlabs.ibm.com>
References: <1161308835.10524.108.camel@localhost.localdomain>
	<17724.39959.51600.232589@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 07:12:30 +1000
Message-Id: <1161637950.10524.465.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Index: linux-cell/include/asm-powerpc/cputable.h
> > ===================================================================
> > --- linux-cell.orig/include/asm-powerpc/cputable.h	2006-10-13 16:00:28.000000000 +1000
> > +++ linux-cell/include/asm-powerpc/cputable.h	2006-10-13 16:19:51.000000000 +1000
> > @@ -89,8 +89,7 @@ struct cpu_spec {
> >  
> >  extern struct cpu_spec		*cur_cpu_spec;
> >  
> > -extern void identify_cpu(unsigned long offset, unsigned long cpu);
> > -extern void do_cpu_ftr_fixups(unsigned long offset);
> > +extern struct cpu_spec *identify_cpu(unsigned long offset);
> 
> ... breaks the ARCH=ppc build.

Gack... I though I tested, I must have screwed up. Should be easy enough
to fix though. I'll have a look.

Ben.
