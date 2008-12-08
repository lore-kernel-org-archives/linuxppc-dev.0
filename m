Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21B1ADDECF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 03:39:27 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mB8GdHvZ009609
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 09:39:24 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id mB8GdGCZ001338
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 10:39:16 -0600 (CST)
Date: Mon, 8 Dec 2008 10:39:16 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jason Jin <Jason.jin@freescale.com>
Subject: Re: [PATCH] Set the fsl elbc ECCM according the settings in
	bootloader.
Message-ID: <20081208163916.GF19650@ld0162-tx32.am.freescale.net>
References: <1228707663-26995-1-git-send-email-Jason.jin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228707663-26995-1-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 08, 2008 at 11:41:03AM +0800, Jason Jin wrote:
> The ECCM maybe set in bootloader, Get ECCM settings from the bootloader,
> can avoid the image written by bootloader cannot read out by kernel.
> 
> But the limitation of doing it this way is that, it could break large page
> NAND if it is written with NAND disabled in u-boot and read with NAND
> enabled, or vice versa.
> 
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>

Acked-by: Scott Wood <scottwood@freescale.com>

Please send to David Woodhouse and the linux-mtd list.

-Scott
