Return-Path: <fl@n621.de>
Received: from nyx.n621.de (nyx.n621.de [176.9.182.227])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKHKl2dpFzDvXP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 21:24:11 +1100 (AEDT)
From: Florian Larysch <fl@n621.de>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 Florian Larysch <fl@n621.de>
Subject: [PATCH v2 0/2] T4240RBD: add device tree entry for W83793
Date: Thu, 17 Nov 2016 11:23:22 +0100
Message-Id: <20161117102324.18319-1-fl@n621.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
 - Ordered DT nodes by address
 - Added an entry for the chip to the trivial-devices list

Florian Larysch (2):
  powerpc/dts: add device tree entry for W83793 on T4240RDB
  DT: i2c: W83793 is a trivial device

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 arch/powerpc/boot/dts/fsl/t4240rdb.dts                    | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.10.2
