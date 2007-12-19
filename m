Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77957DDE48
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:54:15 +1100 (EST)
Message-Id: <6B8F6F4B-1FD2-4A11-B4F6-A1A0ECD7342B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20071219203817.GD20861@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
Date: Wed, 19 Dec 2007 14:54:09 -0600
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203817.GD20861@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 19, 2007, at 2:38 PM, Anton Vorontsov wrote:

> Also rename "fsl_spi" to "fsl,spi".
>
> Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8313erdb.dts    |    3 +--
> arch/powerpc/boot/dts/mpc832x_mds.dts    |    6 ++----
> arch/powerpc/boot/dts/mpc832x_rdb.dts    |    6 ++----
> arch/powerpc/boot/dts/mpc8349emitx.dts   |    3 +--
> arch/powerpc/boot/dts/mpc8349emitxgp.dts |    3 +--
> arch/powerpc/boot/dts/mpc834x_mds.dts    |    3 +--
> arch/powerpc/boot/dts/mpc836x_mds.dts    |    6 ++----
> arch/powerpc/boot/dts/mpc8568mds.dts     |    6 ++----
> arch/powerpc/sysdev/fsl_soc.c            |    2 +-
> 9 files changed, 13 insertions(+), 25 deletions(-)


can you add cell-index as well.

- k
