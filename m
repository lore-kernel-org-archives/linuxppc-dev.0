Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp9.wanadoo.fr (smtp9.wanadoo.fr [193.252.22.22])
	by ozlabs.org (Postfix) with ESMTP id 6C4D568621
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 16:29:51 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0909.wanadoo.fr (SMTP Server) with ESMTP id A5EE02400119
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 08:29:48 +0200 (CEST)
Date: Sat, 29 Oct 2005 08:27:24 +0200
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051029062724.GA1893@localhost.localdomain>
References: <200510290047.j9T0lNNJ030117@shell0.pdx.osdl.net>
	<17251.2983.358202.164993@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17251.2983.358202.164993@cargo.ozlabs.ibm.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, luther@debian.org,
	linuxppc64-dev@ozlabs.org
Subject: Re: [patch 38/43] Various powerpc 32bit ppc64 build fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 29, 2005 at 03:41:59PM +1000, Paul Mackerras wrote:
> Sven Luther writes:
> 
> > +ifeq ($(CONFIG_6xx),y)
> >  obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
> >  					pmac_feature.o pmac_pci.o pmac_sleep.o \
> >  					pmac_low_i2c.o pmac_cache.o
> > +else
> > +obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
> > +					pmac_feature.o pmac_pci.o pmac_sleep.o \
> > +					pmac_low_i2c.o
> > +endif
> 
> This is a bit gross.  How about:

Well, i sent to linuxppc-dev for comments too :)

> pmac-$(CONFIG_6xx)		:= pmac_cache.o
> obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
> 					pmac_feature.o pmac_pci.o pmac_sleep.o \
> 					pmac_low_i2c.o $(pmac-y)
> 
> Care to send a revised patch?

Sure, i will do so early next week.

Friendly,

Sven Luther
