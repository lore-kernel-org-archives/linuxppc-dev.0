Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 610FEB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 13:18:50 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/85xx: enable caam crypto driver by default
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110722154808.a9cabea2.kim.phillips@freescale.com>
Date: Tue, 30 Aug 2011 22:18:49 -0500
Message-Id: <0B4586B7-0ED8-4256-8FF5-206E07D4B8BF@kernel.crashing.org>
References: <20110605173958.1073f245.kim.phillips@freescale.com>
	<20110722154808.a9cabea2.kim.phillips@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2011, at 3:48 PM, Kim Phillips wrote:

> corenet based SoCs have SEC4 h/w, so enable the SEC4 driver,
> caam, and the algorithms it supports, and disable the
> SEC2/3 driver, talitos.
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> v2: rebase from old e55xx_smp_defconfig file to new corenet & p1023
> defconfigs
> 
> arch/powerpc/configs/85xx/p1023rds_defconfig |    1 +
> arch/powerpc/configs/corenet32_smp_defconfig |    1 +
> arch/powerpc/configs/corenet64_smp_defconfig |    5 ++++-
> 3 files changed, 6 insertions(+), 1 deletions(-)

applied to merge

- k
