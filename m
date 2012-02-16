Return-Path: <danny.kukawka@bisect.de>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
 [IPv6:2a01:488:42::50ed:84c3])
 by ozlabs.org (Postfix) with ESMTP id 1F454B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 01:12:45 +1100 (EST)
From: Danny Kukawka <danny.kukawka@bisect.de>
To: Avi Kivity <avi@redhat.com>
Subject: [PATCH] arch/powerpc/kvm/book3s_hv.c: included linux/sched.h twice
Date: Thu, 16 Feb 2012 14:55:54 +0100
Message-Id: <1329400554-31904-1-git-send-email-danny.kukawka@bisect.de>
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Danny Kukawka <dkukawka@suse.de>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kvm/book3s_hv.c: included 'linux/sched.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/powerpc/kvm/book3s_hv.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 336983d..a726716 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -46,7 +46,6 @@
 #include <asm/page.h>
 #include <asm/hvcall.h>
 #include <linux/gfp.h>
-#include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
 
-- 
1.7.8.3
