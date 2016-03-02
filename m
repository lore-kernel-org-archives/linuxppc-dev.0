Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id DDBE21A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 23:16:55 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>,
	Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [RFC PATCH v3 1/3] powerpc/86xx: Move dts files to fsl directory
Date: Wed,  2 Mar 2016 13:16:37 +0100
Message-Id: <1456920999-30282-1-git-send-email-alessio.bogani@elettra.eu>
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
v2 -> v3
    Use appropriate git format-patch flag "-M" to detect renames

v1 -> v2
    Address suggestion made by Scott Wood
          Split the second patch in two
          Don't remove "fsl,mpic" which it is required for 4-cell
            interrupt specifiers
          Remove pointless compatible in the dtsi
          Use the right value for pcie clock-frequency (100 Mhz)

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
2.7.2
