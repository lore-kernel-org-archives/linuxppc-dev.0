Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDB30DDED8
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:50:08 +1100 (EST)
Message-Id: <54B86BEF-B0C1-452D-B990-E9B99B708CA9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090205190459.GC3348@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 3/3] powerpc/83xx: Add FSL eSDHC support for MPC837x-RDB
	boards
Date: Fri, 6 Feb 2009 10:50:01 -0600
References: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
	<20090205190459.GC3348@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2009, at 1:04 PM, Anton Vorontsov wrote:

> Simply add appropriate sdhci nodes.
>
> Note that U-Boot should configure pin multiplexing for eSDHC prior
> to Linux could use it. U-Boot should also fill-in the clock-frequency
> property (eSDHC clock depends on board-specific SCCR[ESDHCCM] bits).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_rdb.dts |    9 +++++++++
> arch/powerpc/boot/dts/mpc8378_rdb.dts |    9 +++++++++
> arch/powerpc/boot/dts/mpc8379_rdb.dts |    9 +++++++++
> 3 files changed, 27 insertions(+), 0 deletions(-)


applied to next

- k
