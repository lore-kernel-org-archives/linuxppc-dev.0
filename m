Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D3952C02C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 01:08:42 +1000 (EST)
Subject: Re: [PATCH] powerpc/sgmii: Add phy nodes in SGMII mode
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342085776-13289-1-git-send-email-B38951@freescale.com>
Date: Thu, 12 Jul 2012 10:08:35 -0500
Message-Id: <07103950-917A-409B-9C7F-9D10AC8FC996@kernel.crashing.org>
References: <1342085776-13289-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 12, 2012, at 4:36 AM, Jia Hongtao wrote:

> In SGMII riser card different PHY chip are used with different external
> IRQ from eTSEC. To support PHY link state auto detect in SGMII mode we
> should add another group of PHY nodes for SGMII mode.
> 
> For MPC8572DS IRQ6 is used for PHY0~PHY1, IRQ7 is used for PHY2~PHY3.
> For MPC8544DS and MPC8536DS IRQ6 is used for PHY0~PHY1.
> For P2020DS IRQ5 is used for PHY1~PHY2.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8536ds.dtsi |    8 ++++++++
> arch/powerpc/boot/dts/mpc8544ds.dtsi |    9 +++++++++
> arch/powerpc/boot/dts/mpc8572ds.dtsi |   17 +++++++++++++++++
> arch/powerpc/boot/dts/p2020ds.dtsi   |   10 ++++++++++
> 4 files changed, 44 insertions(+), 0 deletions(-)

applied to next

- k
