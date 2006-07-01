Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72B8E67A62
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 20:26:17 +1000 (EST)
Date: Sat, 1 Jul 2006 12:25:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
Message-ID: <20060701102557.GA14013@lst.de>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	<1151709194.27137.2.camel@localhost.localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B07B36E@ismail.innsys.innovsys.com>
	<a0bc9bf80606302335p7ba227afwf69dc42e2eada64b@mail.gmail.com>
	<1151738466.27137.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1151738466.27137.24.camel@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 01, 2006 at 05:21:06PM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2006-07-01 at 14:35 +0800, Linux powerpc wrote:
> > Yes, it was used for allocating dual port RAM for CPM.  And now we are
> > adding QE support to powerpc arch which need to use rheap(QE is next
> > generation for CPM).  Please see the patches I <leoli@freescale.com>
> > just posted for 8360epb support.  Moreover, previous CPM support is
> > adding to powerpc arch too. 
> 
> Ok, well, I don't have anything specifically against that code, I was
> just wondering if it may not duplicate something we already have (yet
> another space allocator basically)... 

Yepp.  Without looking at the rheap allocator in deatail, any reason
it can't use lib/genalloc.c?
