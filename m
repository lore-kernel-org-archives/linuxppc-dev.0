Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.tip.net.au [IPv6:2402:b800:7003:1::44])
	by ozlabs.org (Postfix) with ESMTP id 25AA2B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 11:40:17 +1000 (EST)
Date: Tue, 23 Aug 2011 11:40:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Subject: Re: linux-next: boot test failure (net tree)
Message-Id: <20110823114011.a059aea0138b75bfa7eed1ce@canb.auug.org.au>
In-Reply-To: <20110822113032.15087c2e190e2b0c3ee7dfb8@canb.auug.org.au>
References: <20110816.171525.639251389938336183.davem@davemloft.net>
	<20110817105002.efebf85d08460ad99b14be8e@canb.auug.org.au>
	<20110818152214.661858a61496993aaef2c704@canb.auug.org.au>
	<20110817.225356.1790362313048139752.davem@davemloft.net>
	<20110822113032.15087c2e190e2b0c3ee7dfb8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mikey@neuling.org, netdev@vger.kernel.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, jeffrey.t.kirsher@intel.com,
	akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

On Mon, 22 Aug 2011 11:30:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Here's what I am applying as a merge fixup to the net tree today so that
> my ppc64_defconfig builds actually build more or less the same set of
> drivers as before this rearrangement.

And this today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 23 Aug 2011 11:23:40 +1000
Subject: [PATCH] sparc: update sparc32_defconfig for net device movement

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/configs/sparc32_defconfig |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index fb23fd6..9bc241a 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -2,9 +2,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -42,9 +40,10 @@ CONFIG_SCSI_QLOGICPTI=m
 CONFIG_SCSI_SUNESP=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=m
+CONFIG_NET_VENDOR_AMD=y
 CONFIG_SUNLANCE=y
+CONFIG_NET_VENDOR_SUN=y
 CONFIG_HAPPYMEAL=m
 CONFIG_SUNBMAC=m
 CONFIG_SUNQE=m
@@ -64,26 +63,22 @@ CONFIG_SERIAL_SUNSU=y
 CONFIG_SERIAL_SUNSU_CONSOLE=y
 CONFIG_SPI=y
 CONFIG_SPI_XILINX=m
-CONFIG_SPI_XILINX_PLTFM=m
 CONFIG_SUN_OPENPROMIO=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_ROMFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_NLS=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_KGDB=y
 CONFIG_KGDB_TESTS=y
 CONFIG_CRYPTO_NULL=m
-- 
1.7.5.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
