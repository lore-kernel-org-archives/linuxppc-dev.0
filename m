Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28F8DDE061
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:57:47 +1100 (EST)
Date: Fri, 26 Jan 2007 03:57:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 1/14] ps3: repository misc fixes
Message-ID: <20070126025741.GD18537@lst.de>
References: <45B81869.6070305@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45B81869.6070305@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 06:39:37PM -0800, Geoff Levand wrote:
> +EXPORT_SYMBOL_GPL(ps3_repository_read_bus_id);

> +EXPORT_SYMBOL_GPL(ps3_repository_read_bus_type);

> +EXPORT_SYMBOL_GPL(ps3_repository_read_bus_num_dev);

> +EXPORT_SYMBOL_GPL(ps3_repository_read_dev_id);

> +EXPORT_SYMBOL_GPL(ps3_repository_read_dev_type);

> +EXPORT_SYMBOL_GPL(ps3_repository_read_dev_intr);

> +EXPORT_SYMBOL_GPL(ps3_repository_find_device);

> +EXPORT_SYMBOL_GPL(ps3_repository_read_stor_dev_info);

> +EXPORT_SYMBOL_GPL(ps3_repository_read_stor_dev_region);


Exporting all these as procedural interfaces is very wrong.  Please
implement a proper bustype for your hypervisor devices where all this
information is an attribute of the hv1_device object.
