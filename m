Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 9 Jun 2014 18:19:17 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: [patch] powerpc/spufs: remove duplicate SPUFS_CNTL_MAP_SIZE define
Message-ID: <20140609151917.GM9600@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cbe-oss-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SPUFS_CNTL_MAP_SIZE define is cut and pasted twice so we can delete
the second instance.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 0ba3c95..bcfd6f0 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -35,7 +35,6 @@
 #define SPUFS_PS_MAP_SIZE	0x20000
 #define SPUFS_MFC_MAP_SIZE	0x1000
 #define SPUFS_CNTL_MAP_SIZE	0x1000
-#define SPUFS_CNTL_MAP_SIZE	0x1000
 #define SPUFS_SIGNAL_MAP_SIZE	PAGE_SIZE
 #define SPUFS_MSS_MAP_SIZE	0x1000
 
