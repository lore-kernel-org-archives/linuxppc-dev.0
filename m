Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE1D9DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 18:16:00 +1000 (EST)
Date: Tue, 19 Jun 2007 10:15:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
Message-ID: <20070619081546.GA25336@lst.de>
References: <1181947242.3600.8.camel@mulgrave.il.steeleye.com>
	<20070615.160858.26276547.davem@davemloft.net>
	<20070619055629.GE18542@lst.de>
	<20070618.230731.11645150.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070618.230731.11645150.davem@davemloft.net>
Cc: James.Bottomley@SteelEye.com, axboe@kernel.dk, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Geert.Uytterhoeven@sonycom.com,
	dwmw2@infradead.org, hch@lst.de, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2007 at 11:07:31PM -0700, David Miller wrote:
> The main disk I/O block read and write is done using descriptors
> sent to the disk server.  SCSI pass-through is provided (optionally)
> so that disk analysis tools can do things like MODE_SENSE on the
> disk.

SG_IO can easily be implemented for block devices.  See cciss in
current mainline for an example.
