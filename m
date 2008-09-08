Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 968ECDE1D4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 07:56:22 +1000 (EST)
Date: Mon, 8 Sep 2008 23:56:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 0/4] POWERPC: 32/64-bit DMA code merge and cleanup
Message-ID: <20080908215608.GA1175@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 08, 2008 at 02:09:51PM -0500, Becky Bruce wrote:
> I have tested this code on 8641 and 8572 platforms using the popular
> kernel build as well as full runs of LTP.  I have built 64-bit
> platforms, but have no means to test there, so I would greatly
> appreciate any feedback you can provide on possible issues. 

I'll give it a spin on Cell.
