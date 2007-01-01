Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10B6CDDEB8
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 08:24:35 +1100 (EST)
Date: Mon, 1 Jan 2007 21:34:44 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
Message-ID: <20070101213444.2794563b@localhost.localdomain>
In-Reply-To: <1167686134.18169.3.camel@shinybook.infradead.org>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<20070101212236.34526225@localhost.localdomain>
	<1167686134.18169.3.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Er, that would be pci_get_legacy_ide_irq(), which is what I _have_ used.

Ok un-NAK that, I didn't realise there was a wrapper to those methods too.

> As I said, the Maple board is the _only_ user, across all architectures
> and all PowerPC platforms, of pci_get_legacy_ide_irq(). And the AMD74xx

The Motorola's also used to use funny IRQ numbers for IDE legacy - or are
they no longer supported

> driver is the only driver which calls it -- for Maple. Hence the
> suggestion that perhaps there's a better way to do it.

IRQ routing is platform not driver. Let's keep it that way.
