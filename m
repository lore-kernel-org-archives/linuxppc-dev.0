Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id DA57B2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 20:55:57 +1000 (EST)
Date: Mon, 13 May 2013 12:57:20 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/1] powerpc: Fix irq_set_affinity() return values
Message-ID: <20130513105720.GA27065@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

This fix is trivial. Just compile-tested it.

Alexander Gordeev (1):
  powerpc: Fix irq_set_affinity() return values

 arch/powerpc/platforms/wsp/ics.c    |    2 +-
 arch/powerpc/sysdev/ehv_pic.c       |    2 +-
 arch/powerpc/sysdev/mpic.c          |    2 +-
 arch/powerpc/sysdev/xics/ics-opal.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.7.6


-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
