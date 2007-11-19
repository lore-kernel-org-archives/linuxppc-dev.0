Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65739DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 21:42:00 +1100 (EST)
Date: Mon, 19 Nov 2007 11:32:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/9] powerpc: Make isa_mem_base common to 32 and 64
	bits
Message-ID: <20071119103254.GA19708@lst.de>
References: <1195460700.350036.781662541765.qpush@grosgo>
	<20071119082547.E1455DDE03@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071119082547.E1455DDE03@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2007 at 07:25:00PM +1100, Benjamin Herrenschmidt wrote:
> +/* ISA Memory physical address (or 0 if none) */
> +resource_size_t isa_mem_base    = 0;

No need to initialize this.
