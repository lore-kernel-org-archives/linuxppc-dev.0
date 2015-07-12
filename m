Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com
 [IPv6:2607:f8b0:4001:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E244F1A02BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 08:01:52 +1000 (AEST)
Received: by ietj16 with SMTP id j16so51100373iet.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2015 15:01:49 -0700 (PDT)
Subject: [PATCH 0/3] IRQ trivial clarifications
To: Thomas Gleixner <tglx@linutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-am33-list@redhat.com, linux-ia64@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Sun, 12 Jul 2015 17:01:45 -0500
Message-ID: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These don't fix anything at all.  But they might make code understanding
and debugging slightly easier.

---

Bjorn Helgaas (3):
      x86, irq: Rename VECTOR_UNDEFINED and VECTOR_RETRIGGERED to IRQ_*
      x86, irq: Clarify "No irq handler" message
      IRQ: Print "unexpected IRQ" messages consistently across architectures


 arch/alpha/kernel/irq.c            |    2 +-
 arch/blackfin/kernel/irqchip.c     |    2 +-
 arch/c6x/kernel/irq.c              |    2 +-
 arch/ia64/kernel/irq.c             |    2 +-
 arch/m68k/include/asm/hardirq.h    |    2 +-
 arch/mips/kernel/irq.c             |    2 +-
 arch/mn10300/kernel/irq.c          |    2 +-
 arch/parisc/include/asm/hardirq.h  |    2 +-
 arch/powerpc/include/asm/hardirq.h |    2 +-
 arch/s390/include/asm/hardirq.h    |    2 +-
 arch/sh/kernel/irq.c               |    2 +-
 arch/tile/kernel/irq.c             |    2 +-
 arch/x86/include/asm/hw_irq.h      |    4 ++--
 arch/x86/kernel/apic/vector.c      |   14 +++++++-------
 arch/x86/kernel/irq.c              |   19 +++++++++----------
 arch/x86/kernel/irqinit.c          |    4 ++--
 include/asm-generic/hardirq.h      |    2 +-
 17 files changed, 33 insertions(+), 34 deletions(-)
