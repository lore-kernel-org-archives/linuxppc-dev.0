Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzTZg2NR5zDsP7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 01:04:58 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] PS3: Adjustments for six function implementations
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
Date: Sat, 16 Dec 2017 14:50:07 +0100
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
Date: Sat, 16 Dec 2017 14:42:24 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in five functions

 drivers/ps3/ps3-lpm.c         |  2 --
 drivers/ps3/ps3-sys-manager.c |  9 ++-------
 drivers/ps3/ps3-vuart.c       | 12 +++---------
 3 files changed, 5 insertions(+), 18 deletions(-)

-- 
2.15.1
