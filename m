Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 20384B7054
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:49:44 +1100 (EST)
Subject: Re: [PATCH 2/4] powerpc/85xx: add P1020UTM-PC platform support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
Date: Fri, 16 Mar 2012 10:49:38 -0500
Message-Id: <2F12C5E7-56CC-4B7D-8F7A-D5E56B14C56E@kernel.crashing.org>
References: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
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
> The p1020utm-pc has the similar feature as the p1020rdb.
> Therefore, p1020utm-pc use the same platform file as the p1/p2 rdb =
board.
> Overview of P1020UTM-PC platform:
>        - DDR3 1GB
>        - NOR flash 32MB
>        - I2C EEPROM 256Kb
>        - eTSEC1 (RGMII PHY Atheros AR8021)
>        - eTSEC2 (SGMII PHY Vitesse VSC8221)
>        - eTSEC3 (RGMII PHY Atheros AR8021)
>        - SDHC
>        - 2 USB ports
>        - PCIe (Lane1 to dual SATA controller)
>=20
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   23 =
+++++++++++++++++++++++
> 1 files changed, 23 insertions(+), 0 deletions(-)

applied

- k=
