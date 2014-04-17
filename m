Return-Path: <leif.lindholm@linaro.org>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8EB7F140096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 03:43:06 +1000 (EST)
Received: by mail-wg0-f43.google.com with SMTP id x13so727639wgg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 10:43:00 -0700 (PDT)
From: Leif Lindholm <leif.lindholm@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] of: dts: enable memory@0 quirk for PPC32 only
Date: Thu, 17 Apr 2014 18:41:58 +0100
Message-Id: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Leif Lindholm <leif.lindholm@linaro.org>,
 patches@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

drivers/of/fdt.c contains a workaround for a missing memory type
entry on longtrail firmware. Make that quirk PPC32 only, and while
at it - fix up the .dts files in the tree currently working only
because of that quirk.

Cc: devicetree@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>

Leif Lindholm (3):
  arm: dts: add device_type="memory" for ste-ccu8540
  mips: dts: add device_type="memory" where missing
  of: Handle memory@0 node on PPC32 only

 arch/arm/boot/dts/ste-ccu8540.dts     |    1 +
 arch/mips/lantiq/dts/easy50712.dts    |    1 +
 arch/mips/ralink/dts/mt7620a_eval.dts |    1 +
 arch/mips/ralink/dts/rt2880_eval.dts  |    1 +
 arch/mips/ralink/dts/rt3052_eval.dts  |    1 +
 arch/mips/ralink/dts/rt3883_eval.dts  |    1 +
 drivers/of/fdt.c                      |    7 ++++++-
 7 files changed, 12 insertions(+), 1 deletion(-)

-- 
1.7.10.4
