Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51A2BDDDDB
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 11:33:12 +1100 (EST)
Message-ID: <45C91E3E.2030402@garzik.org>
Date: Tue, 06 Feb 2007 19:33:02 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 1/3] libata: add another IRQ calls (core and headers)
References: <200701260727.l0Q7R4Fs005076@toshiba.co.jp>
In-Reply-To: <200701260727.l0Q7R4Fs005076@toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Akira Iguchi wrote:
> This patch is against the libata core and headers.
> 
> Two IRQ calls are added in ata_port_operations.
> - irq_on() is used to enable interrupts. 
> - irq_ack() is used to acknowledge a device interrupt.
> 
> In most drivers, ata_irq_on() and ata_irq_ack() are used for
> irq_on and irq_ack respectively. 
> 
> In some drivers (ex: ahci, sata_sil24) which cannot use them
> as is, ata_dummy_irq_on() and ata_dummy_irq_ack() are used.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

applied
