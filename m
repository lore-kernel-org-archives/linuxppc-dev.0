Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97ACDDDE9F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 00:39:44 +1000 (EST)
Date: Mon, 21 May 2007 16:39:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] remove geometry support from ps3 storage driver
Message-ID: <20070521143938.GA20321@lst.de>
References: <20070521125311.GA27626@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070521125311.GA27626@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 21, 2007 at 02:53:11PM +0200, Olaf Hering wrote:
> 
> The old ps3_storage driver did not support DOS geometry, so there is no
> point to start adding code for it.

That's not quite true.  sd applies some heuristics  and has a default
geometry if there is no ->bios_param method.  Then again this whole
gemetry thing really only makes sense on x86.
