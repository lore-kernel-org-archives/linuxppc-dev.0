Return-Path: <B42378@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 577FF2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 21:57:17 +1000 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <broonie@kernel.org>, <timur@tabi.org>
Subject: [PATCH 0/3] ASoC: Add Freescale i.MX S/PDIF controller driver 
Date: Wed, 31 Jul 2013 20:07:04 +0800
Message-ID: <cover.1375271745.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* This series of patches add i.MX S/PDIF drivers, including CPU DAI, machine.
* It also add two missing sample rates support for spdif dummy codec drivers

Nicolin Chen (3):
  ASoC: codec: spdif: Add S20_3LE and S24_LE support for dummy codec
    drivers
  ASoC: fsl: Add S/PDIF CPU DAI driver
  ASoC: fsl: Add S/PDIF machine driver

 .../devicetree/bindings/sound/fsl,spdif.txt        |   63 +
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +
 sound/soc/codecs/spdif_receiver.c                  |    2 +
 sound/soc/codecs/spdif_transmitter.c               |    5 +-
 sound/soc/fsl/Kconfig                              |   14 +
 sound/soc/fsl/Makefile                             |    4 +
 sound/soc/fsl/fsl_spdif.c                          | 1276 ++++++++++++++++++++
 sound/soc/fsl/fsl_spdif.h                          |  233 ++++
 sound/soc/fsl/imx-spdif.c                          |  134 ++
 9 files changed, 1758 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 sound/soc/fsl/fsl_spdif.c
 create mode 100644 sound/soc/fsl/fsl_spdif.h
 create mode 100644 sound/soc/fsl/imx-spdif.c
