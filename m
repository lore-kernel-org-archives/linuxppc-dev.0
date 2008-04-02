Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD6A5DDE05
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 13:36:19 +1100 (EST)
Message-Id: <D9513606-E9BC-4D20-BB2E-7CCD3D9CEDAA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0803311156160.4549@blarg.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Please pull from 'for-2.6.25' branch
Date: Tue, 1 Apr 2008 21:36:08 -0500
References: <Pine.LNX.4.64.0803311156160.4549@blarg.am.freescale.net>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>, Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 31, 2008, at 11:57 AM, Kumar Gala wrote:
> Please pull from 'for-2.6.25' branch of
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
> for-2.6.25
>
> I'd like to get these minor fixes into 2.6.25.  They aren't critical  
> but
> extremely convenient at this point.

Paul, any comments on sending this onto linus.  I was hoping to avoid  
2.6.25 coming up not support the proper device bindings for DMA and  
SATA.

- k

>
>
> to receive the following updates:
>
> arch/powerpc/boot/dts/mpc8377_mds.dts       |    4 ++--
> arch/powerpc/boot/dts/mpc8377_rdb.dts       |    3 +--
> arch/powerpc/boot/dts/mpc8378_rdb.dts       |    3 +--
> arch/powerpc/boot/dts/mpc8379_mds.dts       |    8 ++++----
> arch/powerpc/boot/dts/mpc8379_rdb.dts       |    3 +--
> arch/powerpc/configs/mpc832x_mds_defconfig  |   11 +++--------
> arch/powerpc/configs/mpc834x_mds_defconfig  |   11 +++--------
> arch/powerpc/configs/mpc836x_mds_defconfig  |   11 +++--------
> arch/powerpc/configs/mpc837x_rdb_defconfig  |   24 ++++++++++++++++++ 
> +++++-
> arch/powerpc/configs/mpc83xx_defconfig      |   24 ++++++++++++++++++ 
> +++++-
> arch/powerpc/configs/mpc8544_ds_defconfig   |   11 +++--------
> arch/powerpc/configs/mpc8568mds_defconfig   |   11 +++--------
> arch/powerpc/configs/mpc8572_ds_defconfig   |   11 +++--------
> arch/powerpc/configs/mpc85xx_defconfig      |   11 +++--------
> arch/powerpc/configs/mpc8641_hpcn_defconfig |   11 +++--------
> arch/powerpc/configs/prpmc2800_defconfig    |   11 +++--------
> arch/powerpc/configs/storcenter_defconfig   |   11 +++--------
> drivers/ata/sata_fsl.c                      |    5 +----
> drivers/dma/fsldma.c                        |    8 ++++----
> 19 files changed, 90 insertions(+), 102 deletions(-)
>
> Anton Vorontsov (1):
>      [POWERPC] 83xx: Fix wrong USB phy type in mpc837xrdb dts
>
> Kim Phillips (2):
>      [POWERPC] 83xx: enable usb in 837x rdb and 83xx defconfigs
>      [POWERPC] sata_fsl: reduce compatibility to fsl,pq-sata
>
> Kumar Gala (2):
>      [POWERPC] fsldma: Use compatiable binding as spec
>      [POWERPC] Fix defconfigs so we dont set both GENRTC and RTCLIB
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
