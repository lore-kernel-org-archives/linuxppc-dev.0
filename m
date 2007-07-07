Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA312DE11B
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 05:56:32 +1000 (EST)
Date: Sat, 7 Jul 2007 21:02:34 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Message-ID: <20070707210234.6aed88bb@the-village.bc.nu>
In-Reply-To: <200707071419.52650.arnd@arndb.de>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<200707071419.52650.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> You could also make it an of_platform_driver at the same time
> instead of adding more cruft to fsl_soc.c. Since we're already
> about to add the electra_ide.c driver in 2.6.23, I guess there
> should really be _one_ driver that is able to handle all
> of_device based ATA hosts.

and do so using libata. Preferably ata_platform but it does look like
ata_of would make sense as a companion.

Alan
