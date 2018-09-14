Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BNpn0b4TzF3V4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 15:09:04 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id x17-v6so3724734pfh.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:09:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] -mno-sched-epilog removal
Date: Fri, 14 Sep 2018 15:08:51 +1000
Message-Id: <20180914050854.6214-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes -mno-sched-epilog on clang and gcc 4.9 and newer. Not
tested with old compilers though.

Nicholas Piggin (3):
  powerpc: remove old GCC version checks
  powerpc: consolidate -mno-sched-epilog into FTRACE flags
  powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer

 arch/powerpc/Makefile                    | 47 ++++++------------------
 arch/powerpc/kernel/Makefile             |  8 ++--
 arch/powerpc/kernel/trace/Makefile       |  2 +-
 arch/powerpc/platforms/powermac/Makefile |  2 +-
 arch/powerpc/xmon/Makefile               |  2 +-
 5 files changed, 19 insertions(+), 42 deletions(-)

-- 
2.18.0
