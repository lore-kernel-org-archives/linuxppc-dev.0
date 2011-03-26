Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A413BB6F8C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Mar 2011 06:58:04 +1100 (EST)
Date: Sat, 26 Mar 2011 20:57:51 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: restore some misc devices to our configs
Message-ID: <20110326195751.GA30481@pengutronix.de>
References: <20110326181129.2b578a57.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20110326181129.2b578a57.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Sat, Mar 26, 2011 at 06:11:29PM +1100, Stephen Rothwell wrote:
> Uwe Kleine-König reported:
> 
> 	while working on an defconfig (arm/mx27) I noticed that just updating
> 	it[1] results in removing CONFIG_EEPROM_AT24=y.  The reason is that
> 	since commit
> 
> 		v2.6.36-5965-g5f2365d (misc devices: do not enable by default)
> 
> 	MISC_DEVICES isn't enabled anymore by default.  So all defconfigs that
> 	have CONFIG_SOME_SYMBOL=y (or =m) (with SOME_SYMBOL depending on
> 	MISC_DEVICES) but not CONFIG_MISC_DEVICES=y suffer from the same
> 	problem.
> 
> This restores those misc devices to the powerpc defconfigs.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de
> ---
>  arch/powerpc/configs/44x/warp_defconfig          |    1 +
>  arch/powerpc/configs/52xx/motionpro_defconfig    |    1 +
>  arch/powerpc/configs/86xx/gef_ppc9a_defconfig    |    1 +
>  arch/powerpc/configs/86xx/gef_sbc310_defconfig   |    1 +
>  arch/powerpc/configs/86xx/gef_sbc610_defconfig   |    1 +
>  arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig |    1 +
>  arch/powerpc/configs/e55xx_smp_defconfig         |    1 +
>  arch/powerpc/configs/linkstation_defconfig       |    1 +
>  arch/powerpc/configs/mpc512x_defconfig           |    1 +
>  arch/powerpc/configs/mpc5200_defconfig           |    1 +
>  arch/powerpc/configs/mpc85xx_defconfig           |    1 +
>  arch/powerpc/configs/mpc85xx_smp_defconfig       |    1 +
>  arch/powerpc/configs/mpc86xx_defconfig           |    1 +
>  arch/powerpc/configs/pasemi_defconfig            |    1 +
>  arch/powerpc/configs/ppc6xx_defconfig            |    1 +
>  15 files changed, 15 insertions(+), 0 deletions(-)
These are exactly the files I reported for powerpc, so

Acked-by: Uwe Kleine-König

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
