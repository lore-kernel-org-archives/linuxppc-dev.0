Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04F09DE042
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 00:33:32 +1100 (EST)
Message-Id: <37D339B7-E64D-40D6-A6ED-92BCA7AEF88A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090319180145.GB6114@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/4] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
Date: Tue, 24 Mar 2009 08:33:22 -0500
References: <20090319180055.GA3155@oksana.dev.rtsoft.ru>
	<20090319180145.GB6114@oksana.dev.rtsoft.ru>
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
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/asp834x-redboot.dts |   82 ++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8315erdb.dts     |   80 ++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8349emitx.dts    |   69 ++++++++++++ 
> +-----------
> arch/powerpc/boot/dts/mpc8349emitxgp.dts  |   42 ++++++++-------
> arch/powerpc/boot/dts/mpc834x_mds.dts     |   81 ++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8377_mds.dts     |   80 ++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8377_rdb.dts     |   67 ++++++++++++ 
> +-----------
> arch/powerpc/boot/dts/mpc8378_mds.dts     |   80 ++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8378_rdb.dts     |   69 +++++++++++++ 
> +-----------
> arch/powerpc/boot/dts/mpc8379_mds.dts     |   79 ++++++++++++++ 
> +------------
> arch/powerpc/boot/dts/mpc8379_rdb.dts     |   66 ++++++++++++ 
> +----------
> arch/powerpc/boot/dts/sbc8349.dts         |   80 ++++++++++++++ 
> +-------------
> arch/powerpc/platforms/83xx/asp834x.c     |    1 +
> arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
> arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/sbc834x.c     |    1 +
> 18 files changed, 488 insertions(+), 393 deletions(-)


applied to next

- k
