Return-Path: <takahiro.akashi@linaro.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C246D2C022C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 20:17:25 +1100 (EST)
Received: by mail-pd0-f172.google.com with SMTP id p10so3095389pdj.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 01:17:22 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: viro@zeniv.linux.org.uk, eparis@redhat.com, rgb@redhat.com, arndb@arndb.de
Subject: [PATCH v2 0/1] audit: Add CONFIG_HAVE_ARCH_AUDITSYSCALL
Date: Tue, 25 Feb 2014 18:16:23 +0900
Message-Id: <1393319784-2758-1-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
Cc: linux-s390@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-ia64@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, x86@kernel.org, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 linux-alpha@vger.kernel.org, dsaxena@linaro.org,
 user-mode-linux-user@lists.sourceforge.net, linux-audit@redhat.com,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently AUDITSYSCALL has a long list of architecture depencency:
       depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML ||
                SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ALPHA)
The purpose of this patch is to replace it with HAVE_ARCH_AUDITSYSCALL
for simplicity.

Changes v1 -> v2:
* rebased to 3.14-rcX, and so added a change on ALPHA

AKASHI Takahiro (1):
  audit: Add CONFIG_HAVE_ARCH_AUDITSYSCALL

 arch/alpha/Kconfig     |    1 +
 arch/arm/Kconfig       |    1 +
 arch/ia64/Kconfig      |    1 +
 arch/parisc/Kconfig    |    1 +
 arch/powerpc/Kconfig   |    1 +
 arch/s390/Kconfig      |    1 +
 arch/sh/Kconfig        |    1 +
 arch/sparc/Kconfig     |    1 +
 arch/um/Kconfig.common |    1 +
 arch/x86/Kconfig       |    1 +
 init/Kconfig           |    5 ++++-
 11 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.7.9.5
