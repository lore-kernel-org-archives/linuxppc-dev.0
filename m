Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CD28C2C01AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 20:29:44 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] net/phy: Add Cortina CS43xx PHY support
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1394007391-32256-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Wed, 5 Mar 2014 03:29:32 -0600
Message-Id: <CFF70C14-23B1-45B9-AD84-C33E32F0B9A3@kernel.crashing.org>
References: <1394007391-32256-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 YongHua Cao <B43619@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2014, at 2:16 AM, Shengzhou Liu <Shengzhou.Liu@freescale.com> =
wrote:

> Add support for Cortina CS4315/CS4340 10G PHY.
> (Tested with CS4315 on T2080RDB and CS4340 on T4240RDB).
>=20
> Signed-off-by: YongHua Cao <B43619@freescale.com>
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> drivers/net/phy/Kconfig   |  5 +++
> drivers/net/phy/Makefile  |  1 +
> drivers/net/phy/cortina.c | 92 =
+++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 98 insertions(+)
> create mode 100644 drivers/net/phy/cortina.c

This patch really needs to be posted to the netdev list

- k=
