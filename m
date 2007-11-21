Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3A6CDDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 09:49:26 +1100 (EST)
Date: Wed, 21 Nov 2007 23:49:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: annoying prinkts during vmemmap initialization
Message-ID: <20071121224908.GA14893@lst.de>
References: <20071121153526.GA23589@lst.de>
	<20071122094145.e79e1084.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122094145.e79e1084.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 22, 2007 at 09:41:45AM +1100, Stephen Rothwell wrote:
> > Any reason to keep this?  And if yes can we please make it conditional
> > on some kind of vmemmap_debug boot option?
> 
> These have been changed to pr_debug() in 2.6.24-rc3 kernel.

Ah, sorry for not checking.  Looks like the spufs tree lags a little
behind.
