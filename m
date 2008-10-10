Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BDA3DE423
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 05:46:02 +1100 (EST)
Message-Id: <6459528F-DE4C-4517-AFE1-0D8CE1F0097E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1223652950-11791-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: disable CHRP and PMAC support in various
	defconfigs
Date: Fri, 10 Oct 2008 13:45:52 -0500
References: <1223652950-11791-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 10, 2008, at 10:35 AM, Timur Tabi wrote:

> Because CHRP and PMAC are by default enabled, several non-CHRP and  
> non-PMAC
> PowerPC defconfigs will have these Kconfig options set erroneously.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/configs/83xx/asp8347_defconfig       |    2 ++
> arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |    2 ++
> arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |    2 ++
> arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |    2 ++
> arch/powerpc/configs/83xx/sbc834x_defconfig       |    2 ++
> arch/powerpc/configs/86xx/gef_sbc610_defconfig    |    5 ++++-
> arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |    2 ++
> arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |    2 ++
> arch/powerpc/configs/86xx/sbc8641d_defconfig      |    2 ++
> arch/powerpc/configs/ep8248e_defconfig            |    2 ++
> arch/powerpc/configs/mpc8272_ads_defconfig        |    2 ++
> arch/powerpc/configs/mpc83xx_defconfig            |    2 ++
> arch/powerpc/configs/pq2fads_defconfig            |    2 ++
> 21 files changed, 44 insertions(+), 1 deletions(-)

applied

- k
