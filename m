Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/85xx: Add P1024rdb board support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1337850508-31827-2-git-send-email-b29983@freescale.com>
Date: Fri, 29 Jun 2012 15:03:45 -0500
Message-Id: <8BE1E993-90F1-40B5-A438-92EBEE0294FE@kernel.crashing.org>
References: <1337850508-31827-1-git-send-email-b29983@freescale.com>
 <1337850508-31827-2-git-send-email-b29983@freescale.com>
To: "<b29983@freescale.com>" <b29983@freescale.com>
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 24, 2012, at 4:08 AM, <b29983@freescale.com> =
<b29983@freescale.com> wrote:

> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>=20
> The p1024rdb has the similar feature as the p1020rdb. Therefore, =
p1024rdb use
> the same platform file as the p1/p2 rdb board.
> Overview of P2020RDB platform
> 	- DDR3 1G
> 	- NOR flash 16M
> 	- 3 Ethernet interfaces
> 	- NAND Flash 32M
> 	- SPI EEPROM 16M
> 	- SD/MMC
> 	- 2 USB ports
> 	- 4 TDM ports
>=20
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   22 =
++++++++++++++++++++++
> 1 files changed, 22 insertions(+), 0 deletions(-)

applied

- k=
