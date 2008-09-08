Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 846A2DDFEA
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 07:58:40 +1000 (EST)
Date: Mon, 8 Sep 2008 23:58:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: git apply vs. renamed files index mismatch (was: Re: [PATCH 1/4]
	POWERPC: Rename dma_64.c to dma.c)
Message-ID: <20080908215833.GC1175@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080908212717.GA21338@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	git@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 01:27:17AM +0400, Anton Vorontsov wrote:
> I always thought that posting "-M" patches to the public lists is
> discouraged since it is quite difficult to apply them via patch(1).
> Also think of non-git users...

Yes, it's a horrible idea.
