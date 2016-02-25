Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 6C6531A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 21:57:15 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>,
	Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [RFC PATCH v1 1/2] powerpc/86xx: Move dts files to fsl directory
Date: Thu, 25 Feb 2016 11:57:04 +0100
Message-Id: <1456397825-1786-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/dts/{ => fsl}/gef_ppc9a.dts        | 0
 arch/powerpc/boot/dts/{ => fsl}/gef_sbc310.dts       | 0
 arch/powerpc/boot/dts/{ => fsl}/gef_sbc610.dts       | 0
 arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn.dts     | 0
 arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn_36b.dts | 0
 arch/powerpc/boot/dts/{ => fsl}/sbc8641d.dts         | 0
 6 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/powerpc/boot/dts/{ => fsl}/gef_ppc9a.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/gef_sbc310.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/gef_sbc610.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn_36b.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/sbc8641d.dts (100%)

diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
similarity index 100%
rename from arch/powerpc/boot/dts/gef_ppc9a.dts
rename to arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
similarity index 100%
rename from arch/powerpc/boot/dts/gef_sbc310.dts
rename to arch/powerpc/boot/dts/fsl/gef_sbc310.dts
diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
similarity index 100%
rename from arch/powerpc/boot/dts/gef_sbc610.dts
rename to arch/powerpc/boot/dts/fsl/gef_sbc610.dts
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
similarity index 100%
rename from arch/powerpc/boot/dts/mpc8641_hpcn.dts
rename to arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
similarity index 100%
rename from arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
rename to arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
similarity index 100%
rename from arch/powerpc/boot/dts/sbc8641d.dts
rename to arch/powerpc/boot/dts/fsl/sbc8641d.dts
-- 
2.7.1
