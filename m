Return-Path: <SRS0+bd07b3adcb1b6d908396+1498+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E572ADDEA3
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 09:06:07 +1000 (EST)
Date: Mon, 1 Oct 2007 00:05:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/6] Sysace: Use the established platform bus api
Message-ID: <20070930230557.GA17654@infradead.org>
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
	<20070930225707.2476.24080.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070930225707.2476.24080.stgit@trillian.cg.shawcable.net>
Cc: axboe@kernel.dk, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 30, 2007 at 04:57:09PM -0600, Grant Likely wrote:
> +	if ((rc = platform_driver_register(&ace_platform_driver)) != 0)
> +		goto err_plat;

	rc = platform_driver_register(&ace_platform_driver);
	if (rc)
		 goto err_plat;

please.

> +      err_plat:
> +	unregister_blkdev(ace_major, "xsysace");
> +      err_blk:

labels should be indented zero or one space, but not more.
