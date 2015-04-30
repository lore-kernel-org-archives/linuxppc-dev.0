Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x233.google.com (mail-yh0-x233.google.com
 [IPv6:2607:f8b0:4002:c01::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B39B1A0033
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 22:30:19 +1000 (AEST)
Received: by yhcb70 with SMTP id b70so12659892yhc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 05:30:17 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc: tweak the kernel options for CRASH_DUMP and
 RELOCATABLE
Date: Thu, 30 Apr 2015 20:29:55 +0800
Message-Id: <1430396997-14656-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The first patch fixes a build error when CRASH_DUMP=y && ADVANCED_OPTIONS=n
for ppc32. The second does some cleanup for RELOCATABLE option.

Kevin Hao (2):
  powerpc: fix the dependency issue for CRASH_DUMP
  powerpc: merge the RELOCATABLE config entries for ppc32 and ppc64

 arch/powerpc/Kconfig                 | 68 +++++++++++++++---------------------
 arch/powerpc/configs/ppc64_defconfig |  1 +
 2 files changed, 29 insertions(+), 40 deletions(-)

-- 
2.1.0
