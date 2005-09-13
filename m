Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 796F568266
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Sep 2005 20:35:54 +1000 (EST)
Date: Tue, 13 Sep 2005 12:35:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas DET <nd@bplan-gmbh.de>
Message-ID: <20050913103539.GA17855@lst.de>
References: <20050830181119.E3A491C000B2@mwinf1203.wanadoo.fr>
	<20050913094045.301A31C00087@mwinf1104.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050913094045.301A31C00087@mwinf1104.wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 13, 2005 at 11:35:31AM +0100, Nicolas DET wrote:
> Using kmap/kunmap instead of page_address (which is the right way do to, as
> far as I understood), is a bit more complex.
> Indeed, kunmap() can't be called from an interrupt.

kmap_atomic/kunmap_atomic can.

anywya, I think the patch discussion is rather offtopic here.  Network
driver patches are discussed and reviewed at netdev@oss.sgi.com
