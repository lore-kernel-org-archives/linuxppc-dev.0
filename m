Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5DB4DDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 17:56:16 +1000 (EST)
Date: Fri, 14 Sep 2007 09:42:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 01/25] spufs: staticify file-internal functions & variables
Message-ID: <20070914074252.GA18011@lst.de>
References: <1189751574.98527.127994196313.1.gpush@pokey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189751574.98527.127994196313.1.gpush@pokey>
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
> From: Sebastian Siewior <cbe-oss-dev@ml.breakpoint.cc>
> 
> There are a few symbols used only in one file within spufs; this change
> makes them static where suitable.
> 
> Signed-off-by: Sebastian Siewior <sebastian@breakpoint.cc>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Looks good.

> +static asmlinkage long do_spu_create(const char __user *pathname,
> +		unsigned int flags, mode_t mode, struct file *neighbor)

please drop the unessecary asmlinkage here, though.
