Return-Path: <bethencourt@gmail.com>
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com
 [IPv6:2a00:1450:400c:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14EA81A2C20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 02:40:43 +1000 (AEST)
Received: by wicge5 with SMTP id ge5so37330554wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 09:40:39 -0700 (PDT)
Sender: Luis de Bethencourt <bethencourt@gmail.com>
Date: Tue, 15 Sep 2015 18:40:38 +0200
From: Luis de Bethencourt <luis@debethencourt.com>
To: linux-kernel@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Matt Mackall <mpm@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, Corey Minyard <minyard@acm.org>,
 openipmi-developer@lists.sourceforge.net
Subject: [PATCH 0/2] Fix module autoload for OF platform drivers
Message-ID: <20150915164038.GA5536@goodgumbo.baconseed.org>
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

Hello,

These patches add the missing MODULE_DEVICE_TABLE() for OF to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (2):
  char: hw_random: Fix module autoload for OF platform drivers
  char: ipmi: Fix module autoload for OF platform driver

 drivers/char/hw_random/pasemi-rng.c | 1 +
 drivers/char/hw_random/ppc4xx-rng.c | 1 +
 drivers/char/ipmi/ipmi_si_intf.c    | 1 +
 3 files changed, 3 insertions(+)

-- 
2.4.6
