Return-Path: <dedekind1@gmail.com>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51028B6EF4
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 19:28:49 +1100 (EST)
Subject: Re: [PATCH v4 04/11] mtd: Add MPC5121 NAND Flash Controller driver
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
In-Reply-To: <1266255305-29224-1-git-send-email-agust@denx.de>
References: <1265377377-29327-5-git-send-email-agust@denx.de>
	<1266255305-29224-1-git-send-email-agust@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Feb 2010 10:11:08 +0200
Message-ID: <1266307868.11659.177.camel@localhost>
Mime-Version: 1.0
Cc: Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-02-15 at 18:35 +0100, Anatolij Gustschin wrote:
> Adds NAND Flash Controller driver for MPC5121 Revision 2.
> All device features, except hardware ECC and power management,
> are supported.
> 
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: <linux-mtd@lists.infradead.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> Changes since v3:
>  - include 'asm/mpc5121.h' header instead of 'asm/mpc5xxx.h'.
>    This change is needed because arch patch adding reset
>    module definition was reworked and doesn't add mpc5121
>    specific definitions to common header for mpc52xx/mpc5121.
> 
> Changes since v2:
>  - move the arch bits into separate patch
>    (it is the next patch in this series now)
>  - use __devinit/__devexit/__devexit_p and __devinitdata
> 
> Changes since v1:
>  - add logfile with changes since previous version 
> 
> Changes since the patch version submitted in May 2009:
> 
>  - move mpc5121_nfc.h to the driver .c as there is only one user
>  - remove DRV_VERSION macro
>  - replace printk() by dev_*()
>  - drop unnecessary .suspend and .resume initializations
>  - remove duplicate .name/.owner settings
>  - fix mpc5121_nfc_init() to "return of_register_platform_driver(&mpc5121_nfc_driver);"
>  - move module_init() to just below the init function
>  - remove MODULE_VERSION
>  - use "mtd: Add MPC5121 NAND Flash Controller driver" as the subject,
>    previously it was "mpc5121: Added NAND Flash Controller driver.
> 
>  drivers/mtd/nand/Kconfig       |    7 +
>  drivers/mtd/nand/Makefile      |    1 +
>  drivers/mtd/nand/mpc5121_nfc.c |  916 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 924 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/nand/mpc5121_nfc.c

Pushed to my l2-mtd-2.6.git / dunno.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
