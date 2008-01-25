Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7A5BDDF47
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:06 +1100 (EST)
Date: Fri, 25 Jan 2008 15:24:40 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 8/9] powerpc: add the mpc837[789]_rdb dts files
In-Reply-To: <20080124204718.33a30ab5.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0801251524240.20972@blarg.am.freescale.net>
References: <20080124204718.33a30ab5.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Joe D'Abbraccio <ljd015@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Kim Phillips wrote:

> Add the dts files for the MPC838xE Reference Development Board (RDB).
>
> The board is a mini-ITX reference board with 256M DDR2, 8M flash,
> 32M NAND, USB, PCI, gigabit ethernet, SATA, and serial.
>
> the difference among the three files is the 8377 has two, the 8378
> none, and the 8379 has four sata controllers.
>
> partially based on the 8379 mds device trees.
>
> Signed-off-by: Joe D'Abbraccio <ljd015@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8377_rdb.dts |  296 +++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8378_rdb.dts |  282 ++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8379_rdb.dts |  310 +++++++++++++++++++++++++++++++++

applied.  (fixed spi nodes).

- k
