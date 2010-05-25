Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB36AB7D69
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 16:43:21 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/85xx: Add P1021MDS board support
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1274451372.3003.7.camel@r54964-12.am.freescale.net>
Date: Tue, 25 May 2010 01:43:13 -0500
Message-Id: <A4A14AB4-6A90-45C9-9676-3FC1B86DA184@kernel.crashing.org>
References: <20100415183631.GA25923@oksana.dev.rtsoft.ru>
	<5D3C6BEB-8F69-407B-BE6D-C99D23EB90F4@kernel.crashing.org>
	<1274449867.3003.2.camel@r54964-12.am.freescale.net>
	<1274451372.3003.7.camel@r54964-12.am.freescale.net>
To: Haiying Wang <Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 21, 2010, at 9:16 AM, Haiying Wang wrote:

> P1021 is a dual e500v2 core based SOC with:
> * 3 eTSECs (eTSEC1/3 RGMII, eTSEC2 SGMII on this board)
> * 2 PCIe Controller
> * 1 USB2.0 controller
> * eSDHC, eSPI, I2C, DUART
> * eLBC (NAND, BCSR, PMC0/1)
> * Security Engine (SEC 3.3.2)
> * Quicc Engine (QE)
>=20
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Yu Liu <Yu.Liu@freescale.com>
> ---
> v2: address the comments from Kumar.
> arch/powerpc/boot/dts/p1021mds.dts        |  698 =
+++++++++++++++++++++++++++++
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |  102 ++++-
> 2 files changed, 797 insertions(+), 3 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1021mds.dts

applied to next

- k=
