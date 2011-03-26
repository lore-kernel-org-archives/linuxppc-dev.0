Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C085B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Mar 2011 00:14:58 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2QD89m5001466
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2011 07:08:09 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2QDEmcl123890
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2011 07:14:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p2QDElv0021834
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2011 07:14:47 -0600
Date: Sat, 26 Mar 2011 09:15:02 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: restore some misc devices to our configs
Message-ID: <20110326131501.GD2591@zod.rchland.ibm.com>
References: <20110326181129.2b578a57.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20110326181129.2b578a57.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	=?iso-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <u.kleine-koenig@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 26, 2011 at 06:11:29PM +1100, Stephen Rothwell wrote:
>Uwe Kleine-König reported:
>
>	while working on an defconfig (arm/mx27) I noticed that just updating
>	it[1] results in removing CONFIG_EEPROM_AT24=y.  The reason is that
>	since commit
>
>		v2.6.36-5965-g5f2365d (misc devices: do not enable by default)
>
>	MISC_DEVICES isn't enabled anymore by default.  So all defconfigs that
>	have CONFIG_SOME_SYMBOL=y (or =m) (with SOME_SYMBOL depending on
>	MISC_DEVICES) but not CONFIG_MISC_DEVICES=y suffer from the same
>	problem.
>
>This restores those misc devices to the powerpc defconfigs.
>
>Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de
>---
> arch/powerpc/configs/44x/warp_defconfig          |    1 +

For the warp change:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
