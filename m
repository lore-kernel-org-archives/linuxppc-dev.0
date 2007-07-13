Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40F91DDDE4
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 23:26:06 +1000 (EST)
Date: Fri, 13 Jul 2007 15:25:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bob Nelson <rrnelson@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] Enable SPU switch notification to detect currently
	active SPU tasks.
Message-ID: <20070713132538.GA30312@lst.de>
References: <1184283940.16584.5.camel@bnelson60.rchland.ibm.com>
	<20070713101233.GA12426@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070713101233.GA12426@lst.de>
Cc: linuxppc <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linuxfoundation.org>,
	oprofile <oprofile-list@lists.sourceforge.net>,
	Philippe Elie <phil.el@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2007 at 12:12:33PM +0200, Christoph Hellwig wrote:
> > -static inline int spu_stopped(struct spu_context *ctx, u32 * stat)
> > +static inline int spu_stopped(struct spu_context *ctx, u32 *stat)
> 
> useless (and wrong) reformatting, please remove.

Sorry, this looked like going the wrong way to me.  I'm still not
sure the reformatting belongs into this patch, but if it makes it easier
for you we can keep it.
