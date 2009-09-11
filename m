Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 577EBB70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 15:25:50 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Fri, 11 Sep 2009 07:25:36 +0200
References: <1251926572.10090.17.camel@Adam> <200909110712.11858.sr@denx.de>
	<1252646270.8566.64.camel@pasglop>
In-Reply-To: <1252646270.8566.64.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909110725.36208.sr@denx.de>
Cc: Andrea Zypchen <azypchen@intldata.ca>, Pravin Bathija <pbathija@amcc.com>,
	lebon@lebon.org.ua, Prodyut Hazarika <phazarika@amcc.com>,
	tburns@datacast.com, azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 11 September 2009 07:17:50 Benjamin Herrenschmidt wrote:
> On Fri, 2009-09-11 at 07:12 +0200, Stefan Roese wrote:
> > It's already there. See commit:
> >
> > 5ce4b59653b2c2053cd9a011918ac1e4747f24cc
> >
> > powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata
> 
> Ok, that's another way to do it. Will catch nasty drivers who
> try to write directly rather than clear pci_cache_line_size I suppose...

Correct. IIRC, some PATA driver as Pravin already mentioned.
 
Cheers,
Stefan
