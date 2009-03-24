Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7956DE0AB
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 00:33:42 +1100 (EST)
Message-Id: <B38F1ED6-6681-4FA6-88DA-65600055B1B1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090319180148.GC6114@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 3/4] powerpc/85xx: Move gianfar mdio nodes under the
	ethernet nodes
Date: Tue, 24 Mar 2009 08:33:32 -0500
References: <20090319180055.GA3155@oksana.dev.rtsoft.ru>
	<20090319180148.GC6114@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 19, 2009, at 1:01 PM, Anton Vorontsov wrote:

> Currently it doesn't matter where the mdio nodes are placed, but with
> power management support (i.e. when sleep = <> properties will take
> effect), mdio nodes placement will become important: mdio controller
> is a part of the ethernet block, so the mdio nodes should be placed
> correctly. Otherwise we may wrongly assume that MDIO controllers are
> available during sleep.
>
> Suggested-by: Scott Wood <scottwood@freescale.com>
> Suggested-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/ksi8560.dts              |   79 ++++++-----
> arch/powerpc/boot/dts/mpc8536ds.dts            |   78 ++++++-----
> arch/powerpc/boot/dts/mpc8540ads.dts           |  117 ++++++++ 
> +--------
> arch/powerpc/boot/dts/mpc8541cds.dts           |   78 ++++++-----
> arch/powerpc/boot/dts/mpc8544ds.dts            |   81 ++++++------
> arch/powerpc/boot/dts/mpc8548cds.dts           |  156 +++++++++++ 
> +----------
> arch/powerpc/boot/dts/mpc8555cds.dts           |   78 ++++++-----
> arch/powerpc/boot/dts/mpc8560ads.dts           |  102 ++++++++-------
> arch/powerpc/boot/dts/mpc8568mds.dts           |  102 ++++++++-------
> arch/powerpc/boot/dts/mpc8572ds.dts            |  150 +++++++++++ 
> +----------
> arch/powerpc/boot/dts/mpc8572ds_36b.dts        |  150 +++++++++++ 
> +----------
> arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |   39 +++---
> arch/powerpc/boot/dts/sbc8548.dts              |   78 ++++++-----
> arch/powerpc/boot/dts/sbc8560.dts              |  100 ++++++++-------
> arch/powerpc/boot/dts/stx_gp3_8560.dts         |   78 ++++++-----
> arch/powerpc/boot/dts/tqm8540.dts              |  117 ++++++++ 
> +--------
> arch/powerpc/boot/dts/tqm8541.dts              |   90 +++++++------
> arch/powerpc/boot/dts/tqm8548-bigflash.dts     |  168 ++++++++++++ 
> +-----------
> arch/powerpc/boot/dts/tqm8548.dts              |  168 ++++++++++++ 
> +-----------
> arch/powerpc/boot/dts/tqm8555.dts              |   90 +++++++------
> arch/powerpc/boot/dts/tqm8560.dts              |   90 +++++++------
> arch/powerpc/platforms/85xx/ksi8560.c          |    1 +
> arch/powerpc/platforms/85xx/mpc8536_ds.c       |    1 +
> arch/powerpc/platforms/85xx/mpc85xx_ads.c      |    1 +
> arch/powerpc/platforms/85xx/mpc85xx_cds.c      |    1 +
> arch/powerpc/platforms/85xx/mpc85xx_ds.c       |    1 +
> arch/powerpc/platforms/85xx/mpc85xx_mds.c      |    1 +
> arch/powerpc/platforms/85xx/sbc8548.c          |    1 +
> arch/powerpc/platforms/85xx/sbc8560.c          |    1 +
> arch/powerpc/platforms/85xx/stx_gp3.c          |    1 +
> arch/powerpc/platforms/85xx/tqm85xx.c          |    1 +
> 31 files changed, 1183 insertions(+), 1016 deletions(-)


applied to next

- k
