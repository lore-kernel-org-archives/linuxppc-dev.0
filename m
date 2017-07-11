Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6GxP0kl0zDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 19:29:13 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id d193so16127937pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 02:29:12 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, paulus@samba.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] constify pci attribute_group structures.
Date: Tue, 11 Jul 2017 14:58:43 +0530
Message-Id: <1499765324-617-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

Arvind Yadav (3):
  [PATCH 1/3] PCI: pci-sysfs: constify attribute_group structures.
  [PATCH 2/3] PCI: pci-label: constify attribute_group structures.
  [PATCH 3/3] PCI: hotplug: constify attribute_group structures.

 drivers/pci/hotplug/rpadlpar_sysfs.c |  2 +-
 drivers/pci/pci-label.c              |  4 ++--
 drivers/pci/pci-sysfs.c              | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.9.1
