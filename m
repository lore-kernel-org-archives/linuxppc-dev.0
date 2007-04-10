Return-Path: <mita@fixstars.com>
Date: Tue, 10 Apr 2007 20:13:24 +0900
From: Akinobu Mita <mita@fixstars.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 1/3] powerpc: delete -mstring option
Message-ID: <20070410111324.GA2957@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is no reason to force -mstring option.
(Kumar, please see patch 2/3 for FSL_BOOKE temporary fix)

Signed-off-by: Akinobu Mita <mita@fixstars.com>

Index: 2.6-git-ps3/arch/powerpc/Makefile
===================================================================
--- 2.6-git-ps3.orig/arch/powerpc/Makefile
+++ 2.6-git-ps3/arch/powerpc/Makefile
@@ -102,10 +102,6 @@ CFLAGS += $(call cc-option,-mno-altivec)
 # kernel considerably.
 CFLAGS += $(call cc-option,-funit-at-a-time)
 
-ifndef CONFIG_FSL_BOOKE
-CFLAGS		+= -mstring
-endif
-
 ifeq ($(CONFIG_6xx),y)
 CFLAGS		+= -mcpu=powerpc
 endif
