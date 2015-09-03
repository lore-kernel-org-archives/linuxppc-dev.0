Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id A7F981A2A7D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 22:16:46 +1000 (AEST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: Drop linux,
 pci-probe-only from the Seattle DTS
Date: Thu,  3 Sep 2015 13:16:16 +0100
Message-Id: <1441282576-7304-5-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
References: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The linux,pci-probe-only property mandates an argument to indicate
whether or not to engage the "probe-only" mode, but the Seattle
DTS just provides a naked property, which is illegal.

Also, it turns out that the board is perfectly happy without
probe-only, so let's drop this altogether.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/amd/amd-overdrive.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive.dts b/arch/arm64/boot/dts/amd/amd-overdrive.dts
index 564a3f7..128fa94 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive.dts
@@ -14,7 +14,6 @@
 
 	chosen {
 		stdout-path = &serial0;
-		linux,pci-probe-only;
 	};
 };
 
-- 
2.1.4
