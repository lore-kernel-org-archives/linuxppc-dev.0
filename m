Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79452DDEE1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 08:50:37 +1000 (EST)
Message-Id: <22DFF71A-6394-46F1-964E-E5FD09DFE74A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080729152924.65a02311.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc/fsl: proliferate simple-bus compatibility to soc
	nodes
Date: Tue, 29 Jul 2008 17:50:26 -0500
References: <20080729152924.65a02311.kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mr.scada@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 29, 2008, at 3:29 PM, Kim Phillips wrote:

> add simple-bus compatible property to soc nodes for 83xx/85xx  
> platforms
> that were missing them.  Add same to platform probe code.
>
> This fixes SoC device drivers (such as talitos) to succeed in matching
> devices present in the soc node.
>
> also update mpc836x_rdk dts to new SEC bindings (overlooked in commit
> 3fd4473: powerpc/fsl: update crypto node definition and device tree
> instances).
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc832x_mds.dts     |    1 +
> arch/powerpc/boot/dts/mpc832x_rdb.dts     |    1 +
> arch/powerpc/boot/dts/mpc8349emitx.dts    |    1 +
> arch/powerpc/boot/dts/mpc8349emitxgp.dts  |    1 +
> arch/powerpc/boot/dts/mpc834x_mds.dts     |    1 +
> arch/powerpc/boot/dts/mpc836x_mds.dts     |    1 +
> arch/powerpc/boot/dts/mpc836x_rdk.dts     |   16 ++++++----------
> arch/powerpc/boot/dts/mpc8377_mds.dts     |    1 +
> arch/powerpc/boot/dts/mpc8378_mds.dts     |    1 +
> arch/powerpc/boot/dts/mpc8379_mds.dts     |    1 +
> arch/powerpc/boot/dts/mpc8536ds.dts       |    1 +
> arch/powerpc/boot/dts/mpc8540ads.dts      |    1 +
> arch/powerpc/boot/dts/mpc8541cds.dts      |    1 +
> arch/powerpc/boot/dts/mpc8544ds.dts       |    1 +
> arch/powerpc/boot/dts/mpc8548cds.dts      |    1 +
> arch/powerpc/boot/dts/mpc8555cds.dts      |    1 +
> arch/powerpc/boot/dts/mpc8560ads.dts      |    1 +
> arch/powerpc/boot/dts/mpc8568mds.dts      |    1 +
> arch/powerpc/boot/dts/mpc8572ds.dts       |    1 +
> arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
> arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc836x_mds.c |    1 +
> arch/powerpc/platforms/83xx/sbc834x.c     |    1 +
> arch/powerpc/platforms/85xx/ksi8560.c     |    1 +
> arch/powerpc/platforms/85xx/mpc8536_ds.c  |    1 +
> arch/powerpc/platforms/85xx/mpc85xx_ads.c |    1 +
> arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    1 +
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
> arch/powerpc/platforms/85xx/sbc8560.c     |    1 +
> 31 files changed, 36 insertions(+), 10 deletions(-)

applied.

- k
