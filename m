Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FA1367B5F
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:52:15 +1100 (EST)
Date: Fri, 17 Nov 2006 07:52:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/16] add base support for Celleb platform
Message-ID: <20061117065210.GC15013@lst.de>
References: <200611150931.kAF9VciJ023243@toshiba.co.jp>
	<20061115183621.GB21633@lst.de>
	<1163633498.5940.272.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163633498.5940.272.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2006 at 10:31:37AM +1100, Benjamin Herrenschmidt wrote:
> I'm ok with separate platform directories for different HVs like Toshiba
> and Sony. I'm not sure we need to keep ibmcell only in the first dir
> tho, could be cellnative for all native cell (non-HV) implementations.

I'm not sure cellnativ is the right name, once we get wildly diverging
hardware platforms.  What would be a nice platform name for the current
CELL BE + spider hardware as in all the existing ibm, sony and toshiba
products?
