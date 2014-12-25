Return-Path: <yamada.m@jp.panasonic.com>
Received: from smtp.mei.co.jp (smtp.mei.co.jp [133.183.100.20])
 by lists.ozlabs.org (Postfix) with ESMTP id BE3A01A0C61
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Dec 2014 16:40:54 +1100 (AEDT)
From: Masahiro Yamada <yamada.m@jp.panasonic.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 0/6] kbuild: refactor Makefiles related with cc-version
Date: Thu, 25 Dec 2014 14:31:22 +0900
Message-Id: <1419485488-22336-1-git-send-email-yamada.m@jp.panasonic.com>
Cc: Michal Marek <mmarek@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
 Andi Kleen <ak@linux.intel.com>, Robert Richter <rrichter@cavium.com>,
 linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Masahiro Yamada <yamada.m@jp.panasonic.com>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>




Masahiro Yamada (6):
  kbuild: fix cc-ifversion macro
  kbuild: do not add $(call ...) to invoke cc-version or cc-fullversion
  kbuild,gcov: remove unnecessary workaround
  kbuild,gcov: simplify kernel/gcov/Makefile
  kbuild: allow cc-ifversion to have the argument for false condition
  kbuild,gcov: simplify kernel/gcov/Makefile more

 Documentation/kbuild/makefiles.txt |  9 +++++----
 arch/parisc/Makefile               |  2 +-
 arch/powerpc/Makefile              |  6 +++---
 arch/x86/Makefile.um               |  2 +-
 kernel/gcov/Makefile               | 36 +++++-------------------------------
 scripts/Kbuild.include             |  7 ++-----
 6 files changed, 17 insertions(+), 45 deletions(-)

-- 
1.9.1
