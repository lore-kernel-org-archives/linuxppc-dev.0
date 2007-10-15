Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 47A74DDFAC
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:10:19 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 3/9] add Freescale SerDes PHY support
Date: Mon, 15 Oct 2007 16:10:12 +0200
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<200710121633.49263.arnd@arndb.de>
	<989B956029373F45A0B8AF0297081890019B590F@zch01exm26.fsl.freescale.net>
In-Reply-To: <989B956029373F45A0B8AF0297081890019B590F@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710151610.12800.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 15 October 2007, Li Yang-r58472 wrote:
> I'd like to but of_iomap() couldn't provide the physical address of the
> device used as identification.

It looks like you only use the physical address for a single printk,
so you could change that to print the full-name of the device node
instead, or do a dev_printk of the parent of_device if you can change
it the way I suggested in my second comment.

	Arnd <><
