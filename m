Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6408B1A0216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 22:17:41 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0138.outbound.protection.outlook.com [207.46.100.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AAA79140100
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2014 22:17:40 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/4] powerpc/mpc85xx: Add FSL QorIQ DPAA B/QMan support to
 device tree(s)
Date: Mon, 24 Nov 2014 05:07:19 -0600
Message-ID: <1416827243-16396-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:	Remove some reserved-memory properties
	Split the patchset per IP block
	Refined patch assignment

Kumar Gala (4):
  powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA BMan
  powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA QMan
  powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to device tree(s)
  powerpc/mpc85xx: Add FSL QorIQ DPAA QMan support to device tree(s)

 arch/powerpc/boot/dts/b4qds.dtsi                   |  38 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        | 129 ++++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           | 180 ++++++-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |  61 ++-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   9 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   9 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   9 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   9 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   9 +-
 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi |  90 ++++
 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi         |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi | 101 ++++
 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi         |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi         |  41 ++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        | 128 ++++-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        | 216 +++++++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        | 568 ++++++++++++++++++++-
 arch/powerpc/boot/dts/kmcoge4.dts                  |  36 ++
 arch/powerpc/boot/dts/oca4080.dts                  |  36 ++
 arch/powerpc/boot/dts/p1023rdb.dts                 |  39 +-
 arch/powerpc/boot/dts/p2041rdb.dts                 |  38 +-
 arch/powerpc/boot/dts/p3041ds.dts                  |  38 +-
 arch/powerpc/boot/dts/p4080ds.dts                  |  38 +-
 arch/powerpc/boot/dts/p5020ds.dts                  |  38 +-
 arch/powerpc/boot/dts/p5040ds.dts                  |  38 +-
 arch/powerpc/boot/dts/t104xqds.dtsi                |  38 +-
 arch/powerpc/boot/dts/t104xrdb.dtsi                |  36 ++
 arch/powerpc/boot/dts/t208xqds.dtsi                |  38 +-
 arch/powerpc/boot/dts/t208xrdb.dtsi                |  36 ++
 arch/powerpc/boot/dts/t4240qds.dts                 |  38 +-
 arch/powerpc/boot/dts/t4240rdb.dts                 |  36 ++
 31 files changed, 2180 insertions(+), 22 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi

-- 
2.1.3
