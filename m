Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71E78DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:45:53 +1100 (EST)
Date: Fri, 25 Jan 2008 15:22:12 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 3/9] powerpc: Add the MPC8315E RDB dts
In-Reply-To: <20080124204606.53bd2a1b.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0801251521590.20972@blarg.am.freescale.net>
References: <20080124204606.53bd2a1b.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Kim Phillips wrote:

> Add the dts for the MPC8315E Reference Development Board (RDB).
>
> The board is a mini-ITX reference board with 128M DDR2, 8M flash,
> 32M NAND, USB, PCI, gigabit ethernet, SATA, and serial.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8315erdb.dts |  287 +++++++++++++++++++++++++++++++++
>  1 files changed, 287 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc8315erdb.dts
>

applied.  fixed up spi node

- k
