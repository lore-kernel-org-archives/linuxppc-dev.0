Return-Path: <roland@redhat.com>
Received: from QMTA02.emeryville.ca.mail.comcast.net
	(qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
	by ozlabs.org (Postfix) with ESMTP id DE598DDFC6
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 16:53:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc: tracehook: CONFIG_HAVE_ARCH_TRACEHOOK
In-Reply-To: Roland McGrath's message of  Saturday, 26 July 2008 23:48:59 -0700
	<20080727064859.69692154280@magilla.localdomain>
References: <20080727064859.69692154280@magilla.localdomain>
Message-Id: <20080727065320.972D9154280@magilla.localdomain>
Date: Sat, 26 Jul 2008 23:53:20 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc arch code has all the prerequisites, so set HAVE_ARCH_TRACEHOOK.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fe88418..587da5e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -117,6 +117,7 @@ config PPC
 	select HAVE_KPROBES
 	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
+	select HAVE_ARCH_TRACEHOOK
 	select HAVE_LMB
 	select HAVE_DMA_ATTRS if PPC64
 	select USE_GENERIC_SMP_HELPERS if SMP
