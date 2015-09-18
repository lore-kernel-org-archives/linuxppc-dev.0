Return-Path: <bethencourt@gmail.com>
Received: from mail-wi0-x234.google.com (mail-wi0-x234.google.com
 [IPv6:2a00:1450:400c:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A2771A2C31
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 07:04:24 +1000 (AEST)
Received: by wiclk2 with SMTP id lk2so79292014wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 14:04:20 -0700 (PDT)
Sender: Luis de Bethencourt <bethencourt@gmail.com>
Date: Fri, 18 Sep 2015 23:04:18 +0200
From: Luis de Bethencourt <luis@debethencourt.com>
To: linux-kernel@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc: Fix module autoload for OF platform drivers
Message-ID: <20150918210418.GA6673@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

These patches add the missing MODULE_DEVICE_TABLE() for OF to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (2):
  powerpc: platforms: mpc52xx_lpbfifo: Fix module autoload for OF
    platform driver
  powerpc: axonram: Fix module autoload for OF platform driver

 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | 1 +
 arch/powerpc/sysdev/axonram.c                 | 1 +
 2 files changed, 2 insertions(+)

-- 
2.4.6
