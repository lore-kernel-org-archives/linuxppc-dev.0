Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 205F4DDF85
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 17:56:24 +1000 (EST)
Date: Fri, 14 Sep 2007 09:43:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 19/25] spufs: Internal __spufs_get_foo() routines should
	take a spu_context *
Message-ID: <20070914074313.GB18011@lst.de>
References: <1189751574.98527.127994196313.1.gpush@pokey>
	<1189751574.109563.102927754470.19.gpush@pokey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189751574.109563.102927754470.19.gpush@pokey>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 04:32:54PM +1000, Jeremy Kerr wrote:
> From: Michael Ellerman <michael@ellerman.id.au>
> 
> The SPUFS attribute get routines take a void * because the generic attribute
> code doesn't know what sort of data it's passing around.
> 
> However our internal __spufs_get_foo() routines can take a spu_context *
> directly, which saves plonking it in and out of a void * again.

Looks good.
