Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C569DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 02:47:33 +1100 (EST)
Message-ID: <45DB180A.5020302@garzik.org>
Date: Tue, 20 Feb 2007 10:47:22 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 3/3] libata: PATA driver	for Celleb
References: <200701260727.l0Q7Rovv019682@toshiba.co.jp>
In-Reply-To: <200701260727.l0Q7Rovv019682@toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jeff@garzik.org, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Akira Iguchi wrote:
> This is the patch for PATA controller of Celleb.
> 
> This driver uses the managed iomap (devres).
> 
> Because this driver needs special taskfile accesses, there is
> a copy of ata_std_softreset(). ata_dev_try_classify() is exported
> so that it can be used in this function.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

applied
