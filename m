Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lOho030120@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:54 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 39/43] ppc64: compile nls_cp437 and nls_iso8859_1 into the
	kernel in defconfig
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

compile nls_cp437 and nls_iso8859_1 into the kernel in defconfig.  This is
already enabled in pSeries_defconfig.

Reason: if one just boots the new shiny zImage and the root filesystem is
on a filesystem not readable by yaboot (like jfs, raid or lvm) upgrading
the bootloader will fail because the FAT bootpartition can not be mounted.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/defconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/ppc64/defconfig~ppc64-compile-nls_cp437-and-nls_iso8859_1-into-the-kernel-in-defconfig arch/ppc64/defconfig
--- devel/arch/ppc64/defconfig~ppc64-compile-nls_cp437-and-nls_iso8859_1-into-the-kernel-in-defconfig	2005-10-28 17:44:05.000000000 -0700
+++ devel-akpm/arch/ppc64/defconfig	2005-10-28 17:44:05.000000000 -0700
@@ -1318,7 +1318,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
 CONFIG_NLS_CODEPAGE_850=m
@@ -1342,7 +1342,7 @@ CONFIG_NLS_ISO8859_8=m
 CONFIG_NLS_CODEPAGE_1250=m
 CONFIG_NLS_CODEPAGE_1251=m
 CONFIG_NLS_ASCII=m
-CONFIG_NLS_ISO8859_1=m
+CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=m
 CONFIG_NLS_ISO8859_3=m
 CONFIG_NLS_ISO8859_4=m
_
