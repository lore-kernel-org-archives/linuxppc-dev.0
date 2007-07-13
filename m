Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D659FDDE3D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 20:14:04 +1000 (EST)
Date: Fri, 13 Jul 2007 12:13:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bob Nelson <rrnelson@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] Enable SPU switch notification to detect currently
	active SPU tasks.
Message-ID: <20070713101343.GB12426@lst.de>
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
> On Thu, Jul 12, 2007 at 06:45:40PM -0500, Bob Nelson wrote:
> > We would like this patch included in -mm and in 2.6.23.
> 
> Do you plan to submit oprofile support aswell?  In that case it's fine
> otherwise please send it together with the actual oprofile support.

I just saw the oprofile patch is next, so this is okay.
