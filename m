Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 12:44:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 3/5] sparc: turn CONFIG_OF into a select
Message-Id: <20100629124450.5e85bafe.sfr@canb.auug.org.au>
In-Reply-To: <20100629123843.5f94d477.sfr@canb.auug.org.au>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
	<20100629123843.5f94d477.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michal Simek <monstr@monstr.eu>, Paul Mackerras <paulus@samba.org>,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@lists.ozlabs.org,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

so that we can make CONFIG_OF global and remove it from
the architecture Kconfig files later.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6f1470b..d02e8ac 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -18,6 +18,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select OF
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
@@ -149,7 +150,7 @@ config ARCH_NO_VIRT_TO_BUS
 	def_bool y
 
 config OF
-	def_bool y
+	bool
 
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y if SPARC64
-- 
1.7.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
