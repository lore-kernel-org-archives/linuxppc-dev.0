Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48A162C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 16:59:22 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/pci: remove the stale comments of
 pci_process_bridge_OF_ranges
Date: Fri, 17 May 2013 14:58:41 +0800
Message-ID: <1368773922-19754-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368773922-19754-1-git-send-email-haokexin@gmail.com>
References: <1368773922-19754-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These comments already don't apply to the current code. So just remove
them.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/pci-common.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 6053f03..8245d51 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -657,15 +657,6 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
  *     ranges. However, some machines (thanks Apple !) tend to split their
  *     space into lots of small contiguous ranges. So we have to coalesce.
  *
- *   - We can only cope with all memory ranges having the same offset
- *     between CPU addresses and PCI addresses. Unfortunately, some bridges
- *     are setup for a large 1:1 mapping along with a small "window" which
- *     maps PCI address 0 to some arbitrary high address of the CPU space in
- *     order to give access to the ISA memory hole.
- *     The way out of here that I've chosen for now is to always set the
- *     offset based on the first resource found, then override it if we
- *     have a different offset and the previous was set by an ISA hole.
- *
  *   - Some busses have IO space not starting at 0, which causes trouble with
  *     the way we do our IO resource renumbering. The code somewhat deals with
  *     it for 64 bits but I would expect problems on 32 bits.
-- 
1.8.1.4
