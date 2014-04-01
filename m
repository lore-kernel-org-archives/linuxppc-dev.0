Return-Path: <guangyu.chen@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39AEB1400E6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 22:53:06 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <shawn.guo@linaro.org>
Subject: [PATCH 0/2] Add ipg clock control to sai driver
Date: Tue, 1 Apr 2014 19:52:51 +0800
Message-ID: <cover.1396352401.git.Guangyu.Chen@freescale.com>
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

This series of patches add ipg clock control to fsl_sai driver and updates
the vf610.dtsi accordingly.

@Shawn
I'm not sure if VF610 currently does full works with SAI audio function.
The PATCH-2 is based on broonie/for-next.

Nicolin Chen (2):
  ASoC: fsl_sai: Add clock control for SAI
  ARM: dts: Add ipg clock for sai2 on VF610 platform

 .../devicetree/bindings/sound/fsl-sai.txt          |  7 ++--
 arch/arm/boot/dts/vf610.dtsi                       |  4 +--
 sound/soc/fsl/fsl_sai.c                            | 37 ++++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h                            |  2 ++
 4 files changed, 43 insertions(+), 7 deletions(-)

-- 
1.8.4
