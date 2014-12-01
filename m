Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DD9C1A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 21:12:59 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0140.outbound.protection.outlook.com [157.56.111.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8725614017C
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 21:12:57 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/4] powerpc/mpc85xx: Add FSL QorIQ DPAA B/QMan support to
 device tree(s)
Date: Mon, 1 Dec 2014 04:02:11 -0600
Message-ID: <1417428135-12895-1-git-send-email-Emilian.Medve@Freescale.com>
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

v3:	Remove no-map
	Adjust alloc-ranges for the 32-/36-bit SoC(s)

v2:	Remove some reserved-memory properties
	Split the patchset per IP block
	Refined patch assignment

Kumar Gala (4):
  powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA BMan
  powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA QMan
  powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to device tree(s)
  powerpc/mpc85xx: Add FSL QorIQ DPAA QMan support to device tree(s)

 arch/powerpc/boot/dts/b4qds.dtsi                   |  35 +-
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
 arch/powerpc/boot/dts/kmcoge4.dts                  |  33 ++
 arch/powerpc/boot/dts/oca4080.dts                  |  33 ++
 arch/powerpc/boot/dts/p1023rdb.dts                 |  36 +-
 arch/powerpc/boot/dts/p2041rdb.dts                 |  35 +-
 arch/powerpc/boot/dts/p3041ds.dts                  |  35 +-
 arch/powerpc/boot/dts/p4080ds.dts                  |  35 +-
 arch/powerpc/boot/dts/p5020ds.dts                  |  35 +-
 arch/powerpc/boot/dts/p5040ds.dts                  |  35 +-
 arch/powerpc/boot/dts/t104xqds.dtsi                |  35 +-
 arch/powerpc/boot/dts/t104xrdb.dtsi                |  32 ++
 arch/powerpc/boot/dts/t208xqds.dtsi                |  35 +-
 arch/powerpc/boot/dts/t208xrdb.dtsi                |  33 ++
 arch/powerpc/boot/dts/t4240qds.dts                 |  35 +-
 arch/powerpc/boot/dts/t4240rdb.dts                 |  33 ++
 31 files changed, 2134 insertions(+), 22 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi

-- 
2.1.3
