Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 835F11A050C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 12:30:39 +1100 (AEDT)
From: Kees Cook <keescook@chromium.org>
To: akpm@linux-foundation.org
Subject: [PATCH v3 0/8] switch to using asm-generic for seccomp.h
Date: Wed,  4 Mar 2015 17:27:00 -0800
Message-Id: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>,
 James Hogan <james.hogan@imgtec.com>, Laura Abbott <lauraa@codeaurora.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Daniel Borkmann <dborkman@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most architectures don't need to do much special for the strict-mode
seccomp syscall entries. Remove the redundant headers and reduce the
others.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- split patch series by architecture
- fix up architectures that need sigreturn overrides (ingo)
v2:
- use Kbuild "generic-y" instead of explicit #include lines (sfr)
