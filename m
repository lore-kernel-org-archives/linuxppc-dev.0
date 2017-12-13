Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxkLJ6RDVzDqhq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 04:33:11 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] SoC/FSL/QE: Adjustments for three function implementations
Message-ID: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
Date: Wed, 13 Dec 2017 18:32:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 13 Dec 2017 18:28:38 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in three functions
  Improve a size determination in two functions
  Use common error handling code in ucc_fast_init()

 drivers/soc/fsl/qe/gpio.c     |  4 +---
 drivers/soc/fsl/qe/ucc_fast.c | 39 ++++++++++++++++++---------------------
 drivers/soc/fsl/qe/ucc_slow.c |  7 ++-----
 3 files changed, 21 insertions(+), 29 deletions(-)

-- 
2.15.1
