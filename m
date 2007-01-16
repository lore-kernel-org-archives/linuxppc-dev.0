Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0C17DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 22:57:11 +1100 (EST)
Date: Tue, 16 Jan 2007 12:03:35 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
Message-ID: <20070116120335.59b4491d@localhost.localdomain>
In-Reply-To: <200701161046.l0GAk5Go019691@toshiba.co.jp>
References: <200701161046.l0GAk5Go019691@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jeff@garzik.org, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 Jan 2007 19:46:14 +0900
Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:

> When enabling IRQ, ap->ops->irq_on is checked.
> Because most drivers can use ata_irq_on() as is, this
> patch allows ap->ops->irq_on to be NULL.
> If it is NULL, ata_irq_on() are used.


Acked-by: Alan Cox <alan@redhat.com>


Jeff - at some point we could eliminate a lot of the NULL checks like
these by having the registration code fill in the defaults where
appropriate ?

Alan
