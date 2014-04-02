Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 348EB1400AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 21:09:24 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] ASoC: fsl_sai: Add bus clock and mclks with clock
 controls
Date: Wed, 2 Apr 2014 18:10:18 +0800
Message-ID: <cover.1396432924.git.Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches add clock controls to fsl_sai driver and updates
the vf610.dtsi accordingly.

Changelog
v2:
 * Appended two extra mclks to the driver since SAI actually has three.
 * Renamed clock name to 'bus' and 'mclk' according to the reference manual.

Nicolin Chen (2):
  ASoC: fsl_sai: Add clock controls for SAI
  ARM: dts: Append clock bindings for sai2 on VF610 platform

 .../devicetree/bindings/sound/fsl-sai.txt          |  8 ++--
 arch/arm/boot/dts/vf610.dtsi                       |  6 ++-
 sound/soc/fsl/fsl_sai.c                            | 50 ++++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h                            |  4 ++
 4 files changed, 59 insertions(+), 9 deletions(-)

-- 
1.8.4
