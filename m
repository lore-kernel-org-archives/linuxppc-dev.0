Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9483B67A79
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 19:08:51 +1000 (EST)
Date: Tue, 28 Jun 2005 10:57:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050628085701.GA31218@lst.de>
References: <1119847159.5133.106.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1119847159.5133.106.camel@gaston>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 27, 2005 at 02:39:16PM +1000, Benjamin Herrenschmidt wrote:
> This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> powerbooks have, CONFIG_PM for power management related code, and just
> left out of any CONFIG_* option for some generally useful stuff that can
> be used on non-laptops as well.

Can you clarify the CONFIG_PMAC_MEDIABAY for which powerbooks this
is needed exactly?  AFAIK up to one of the G3 models, but you probably
know better :)
