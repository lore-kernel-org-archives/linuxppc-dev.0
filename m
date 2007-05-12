Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 353C1DDE1D
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 09:54:13 +1000 (EST)
Date: Sun, 13 May 2007 00:58:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Message-ID: <20070513005830.38ba8e3b@the-village.bc.nu>
In-Reply-To: <200705130111.03153.arnd@arndb.de>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Why not provide a proper pata_of.c driver based on ata_generic? That
> will help the next person that has a builtin ata controller and wants
> to get it running as an of_device.

Easier to use pata_platform I would think ? Just create the OF device and
bind it to pata_platform.

Alan
