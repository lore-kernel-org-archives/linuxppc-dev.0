Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4AE54B73BF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:49:36 +1100 (EST)
Subject: Re: [PATCH 1/4] powerpc/85xx: add P1020MBG-PC platform support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
Date: Fri, 16 Mar 2012 10:49:30 -0500
Message-Id: <385EA1F8-4E83-40CA-8308-E10DB4C4111F@kernel.crashing.org>
References: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
To: "<Chang-Ming.Huang@freescale.com>" <Chang-Ming.Huang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 14, 2012, at 4:08 AM, <Chang-Ming.Huang@freescale.com> =
<Chang-Ming.Huang@freescale.com> wrote:

> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>=20
> The p1020mbg-pc has the similar feature as the p1020rdb.
> Therefore, p1020mbg-pc use the same platform file as the p1/p2 rdb =
board.
> Overview of P1020MBG-PC platform:
>        - DDR3 2GB
>        - NOR flash 64MB
>        - I2C EEPROM 256Kb
>        - eTSEC1 (RGMII PHY) connected to VSC7385 L2 switch
>        - eTSEC2 (SGMII PHY)
>        - eTSEC3 (RGMII PHY)
>        - SDHC
>        - 2 USB ports
>        - 4 TDM ports
>        - PCIe (Lane1 to dual SATA controller)
>=20
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   23 =
+++++++++++++++++++++++
> 1 files changed, 23 insertions(+), 0 deletions(-)

applied

- k=
