Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40pXc35qZMzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 16:50:41 +1000 (AEST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] don't check number of I2C messages in drivers
Date: Sun, 20 May 2018 08:50:32 +0200
Message-Id: <20180520065035.7920-1-wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The core does it now, we can simplify drivers.

Wolfram Sang (2):
  i2c: ibm_iic: don't check number of messages in the driver
  i2c: opal: don't check number of messages in the driver

 drivers/i2c/busses/i2c-ibm_iic.c | 3 ---
 drivers/i2c/busses/i2c-opal.c    | 4 ----
 2 files changed, 7 deletions(-)

-- 
2.11.0
