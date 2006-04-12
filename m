Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:29:00 -0500
To: paulus@ozlabs.org
Subject: [10/10]: Quiet oprofile output at boot
Message-ID: <20060412202900.GQ19464@pb15.lixom.net>
References: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412201823.GG19464@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No need to always print out which performance monitoring type is used
on the console at every boot.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6/arch/powerpc/oprofile/common.c
===================================================================
--- 2.6.orig/arch/powerpc/oprofile/common.c
+++ 2.6/arch/powerpc/oprofile/common.c
@@ -162,7 +162,7 @@ int __init oprofile_arch_init(struct opr
 	ops->stop = op_powerpc_stop;
 	ops->backtrace = op_powerpc_backtrace;
 
-	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
+	printk(KERN_DEBUG "oprofile: using %s performance monitoring.\n",
 	       ops->cpu_type);
 
 	return 0;
