Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5CC1DDED2
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:39:34 +1100 (EST)
Message-Id: <DCE813B1-89CE-41BA-8D8C-86A9C122212F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/2] powerpc/83xx: Fix TSEC0 workability on MPC8313E-RDB
	boards
Date: Fri, 6 Feb 2009 10:39:26 -0600
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2009, at 2:10 PM, Anton Vorontsov wrote:

> TSEC0 is connected to Vitesse 7385 5-port switch. The switch
> isn't connected to any mdio bus, the link to the switch is fixed
> to Full-duplex 1000 Mb/s (no pause).
>
> This patch fixes following failure during bootup:
>
> mdio@24520:01 not found
> eth0: Could not attach to PHY
> IP-Config: Failed to open eth0
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8313erdb.dts           |    9 ++-------
> arch/powerpc/configs/83xx/mpc8313_rdb_defconfig |    2 +-
> 2 files changed, 3 insertions(+), 8 deletions(-)


applied to merge

- k
