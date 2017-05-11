Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wP0ky3zDNzDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 03:40:57 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id m17so17206778pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 10:40:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3] more build time checks
Date: Fri, 12 May 2017 03:40:37 +1000
Message-Id: <20170511174040.19728-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Nicholas Piggin (3):
  powerpc/64s: tool to flag direct branches from unrelocated interrupt
    vectors
  powerpc/64: tool to check head sections location sanity
  powerpc: link warning for orphan sections

 arch/powerpc/Makefile                    |  1 +
 arch/powerpc/Makefile.postlink           | 17 +++++++-
 arch/powerpc/include/asm/head-64.h       |  4 +-
 arch/powerpc/kernel/vmlinux.lds.S        | 38 +++++++----------
 arch/powerpc/tools/head_check.sh         | 70 ++++++++++++++++++++++++++++++++
 arch/powerpc/tools/unrel_branch_check.sh | 57 ++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h        | 12 ++++++
 7 files changed, 171 insertions(+), 28 deletions(-)
 create mode 100755 arch/powerpc/tools/head_check.sh
 create mode 100755 arch/powerpc/tools/unrel_branch_check.sh

-- 
2.11.0
