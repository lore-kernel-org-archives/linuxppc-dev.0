Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E536E67DD4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:44:20 +1100 (EST)
Date: Wed, 15 Nov 2006 19:44:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 11/16] PATA driver for Celleb
Message-ID: <20061115184416.GE21633@lst.de>
References: <200611150949.kAF9nGUY009229@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611150949.kAF9nGUY009229@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 15, 2006 at 06:49:15PM +0900, Ishizaki Kou wrote:
> This patch adds PATA driver for Celleb platform.

This needs to go to linux-ide for review.  But IIRC new PATA drivers
should use libata these days, not the old ide layer.
