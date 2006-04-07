Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 370B067B2D
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 21:54:41 +1000 (EST)
Date: Fri, 7 Apr 2006 13:54:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: arndb@arndb.de
Subject: Re: [PATCH] spufs: fix compile
Message-ID: <20060407115431.GA28381@lst.de>
References: <20060406134810.GB8552@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060406134810.GB8552@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 06, 2006 at 03:48:10PM +0200, Christoph Hellwig wrote:
> The current tree isn't exctly sure about the arguments to
> alloc_spu_context, let it agree on the no-arguments version.

Please ignore all these patches, I had a messed up tree.
