Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22b.google.com (mail-pg0-x22b.google.com
 [IPv6:2607:f8b0:400e:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNyRB73mBzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:57:10 +1000 (AEST)
Received: by mail-pg0-x22b.google.com with SMTP id 64so16661938pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:57:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/5] Register save/restore function build improvements
Date: Fri, 12 May 2017 01:56:47 +1000
Message-Id: <20170511155652.8287-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are some minor improvements I came up when investigating
"orphan" sections (.sfpr currently is). For 4.13.

Nicholas Piggin (5):
  powerpc/64: place sfpr section explicitly with the linker script
  powerpc/64: do not link crtsavres.o in vmlinux
  powerpc/64: do not link crtsaveres.o in boot
  powerpc/64: do not create new section for save/restore functions
  powerpc/64: Linker on-demand save/restore functions for modules

 arch/powerpc/Makefile             | 10 ++++++++++
 arch/powerpc/boot/Makefile        |  3 ++-
 arch/powerpc/boot/crtsavres.S     |  8 ++++----
 arch/powerpc/kernel/vmlinux.lds.S |  8 ++++++++
 arch/powerpc/lib/Makefile         | 13 ++++++++++---
 arch/powerpc/lib/crtsavres.S      |  6 ++----
 6 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.11.0
