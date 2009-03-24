Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 959F9DE0FB
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 00:33:47 +1100 (EST)
Message-Id: <934B5643-F668-4950-8FBA-8D1E989373E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090319180151.GD6114@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 4/4] powerpc/86xx: Move gianfar mdio nodes under the
	ethernet nodes
Date: Tue, 24 Mar 2009 08:33:39 -0500
References: <20090319180055.GA3155@oksana.dev.rtsoft.ru>
	<20090319180151.GD6114@oksana.dev.rtsoft.ru>
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
> arch/powerpc/boot/dts/gef_ppc9a.dts        |   39 ++++---
> arch/powerpc/boot/dts/gef_sbc310.dts       |   39 ++++---
> arch/powerpc/boot/dts/gef_sbc610.dts       |   39 ++++---
> arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  157 ++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/sbc8641d.dts         |  156 ++++++++++++++ 
> +-------------
> arch/powerpc/platforms/86xx/gef_ppc9a.c    |    1 +
> arch/powerpc/platforms/86xx/gef_sbc310.c   |    1 +
> arch/powerpc/platforms/86xx/gef_sbc610.c   |    1 +
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 +
> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
> arch/powerpc/platforms/86xx/sbc8641d.c     |    1 +
> 11 files changed, 237 insertions(+), 199 deletions(-)


applied to next

- k
