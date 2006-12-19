Return-Path: <arnd@arndb.de>
Message-Id: <20061219143452.003727000@arndb.de>
References: <20061219143240.705255000@arndb.de>
Date: Tue, 19 Dec 2006 15:32:42 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 2/6] cell: add forward struct declarations to spu.h
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Needed to be able to include spu.h independant from other
headers.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -161,6 +161,7 @@ struct spu_syscall_block {
 extern long spu_sys_callback(struct spu_syscall_block *s);
 
 /* syscalls implemented in spufs */
+struct file;
 extern struct spufs_calls {
 	asmlinkage long (*create_thread)(const char __user *name,
 					unsigned int flags, mode_t mode);
@@ -232,6 +233,7 @@ void spu_remove_sysdev_attr_group(struct
  * to object-id spufs file from user space and the notifer
  * function can assume that spu->ctx is valid.
  */
+struct notifier_block;
 int spu_switch_event_register(struct notifier_block * n);
 int spu_switch_event_unregister(struct notifier_block * n);
 

--
