Return-Path: <B42378@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40C432C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 15:59:20 +1000 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <broonie@kernel.org>, <lars@metafoo.de>
Subject: [PATCH v2 0/2] Add freescale S/PDIF CPU DAI and machine drivers
Date: Mon, 5 Aug 2013 14:09:23 +0800
Message-ID: <1375682965-3116-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changelog:
v1->v2:
 * Dropped one applied patch for spdif dummy codec drivers.
 * Use generic DMA DT binding.
 * Let spdif controller driver calculate the clock div.
 * Added one optional clock source for spdif tx.
 * Reivsed documentation accordingly.

Nicolin Chen (2):
  ASoC: fsl: Add S/PDIF CPU DAI driver
  ASoC: fsl: Add S/PDIF machine driver

 .../devicetree/bindings/sound/fsl,spdif.txt        |   62 +
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +
 sound/soc/fsl/Kconfig                              |   14 +
 sound/soc/fsl/Makefile                             |    4 +
 sound/soc/fsl/fsl_spdif.c                          | 1311 ++++++++++++++++++++
 sound/soc/fsl/fsl_spdif.h                          |  227 ++++
 sound/soc/fsl/imx-spdif.c                          |  134 ++
 7 files changed, 1781 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 sound/soc/fsl/fsl_spdif.c
 create mode 100644 sound/soc/fsl/fsl_spdif.h
 create mode 100644 sound/soc/fsl/imx-spdif.c
