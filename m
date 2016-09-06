Return-Path: <afleming@gmail.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTGS802p7zDrp5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 05:12:07 +1000 (AEST)
Received: by mail-oi0-x22b.google.com with SMTP id y2so88977101oie.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 12:12:07 -0700 (PDT)
From: Andy Fleming <afleming@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
Cc: aperez@alexperez.com
Subject: [PATCH 0/3] corenet: Add power/reset support to Cyrus
Date: Tue,  6 Sep 2016 14:11:56 -0500
Message-Id: <1473189119-29458-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cyrus has gpio pins for power and reset, so we should support them

Andy Fleming (3):
  cyrus: Add poweroff/reset support
  corenet: Support gpio power/reset for corenet
  Cyrus: create a defconfig

 arch/powerpc/Makefile                         |  5 +++++
 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts     | 11 +++++++++++
 arch/powerpc/configs/cyrus_basic_defconfig    |  9 +++++++++
 arch/powerpc/platforms/85xx/corenet_generic.c | 18 ++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 arch/powerpc/configs/cyrus_basic_defconfig

-- 
1.9.1
