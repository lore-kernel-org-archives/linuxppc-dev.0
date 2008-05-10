Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
	by ozlabs.org (Postfix) with ESMTP id E0340DDE17
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 22:16:10 +1000 (EST)
Date: Sat, 10 May 2008 14:51:27 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: ppc compile failure (__flush_icache_range etc undeclared)
Message-ID: <Pine.SOC.4.64.0805101448580.8450@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tried 2.6.26-rc1+git on ppc (arch/ppc, PReP subarch) and got this:

arch/ppc/kernel/ppc_ksyms.c: At top level:
arch/ppc/kernel/ppc_ksyms.c:152: error: '__flush_icache_range' undeclared here (not in a function)
arch/ppc/kernel/ppc_ksyms.c:152: warning: type defaults to 'int' in declaration of '__flush_icache_range'
arch/ppc/kernel/ppc_ksyms.c:153: error: 'flush_dcache_range' undeclared here (not in a function)
arch/ppc/kernel/ppc_ksyms.c:153: warning: type defaults to 'int' in declaration of 'flush_dcache_range'
arch/ppc/kernel/ppc_ksyms.c:154: error: 'flush_icache_user_range' undeclared here (not in a function)
arch/ppc/kernel/ppc_ksyms.c:154: warning: type defaults to 'int' in declaration of 'flush_icache_user_range'
arch/ppc/kernel/ppc_ksyms.c:155: error: 'flush_dcache_page' undeclared here (not in a function)
arch/ppc/kernel/ppc_ksyms.c:155: warning: type defaults to 'int' in declaration of 'flush_dcache_page'
make[1]: *** [arch/ppc/kernel/ppc_ksyms.o] Error 1


-- 
Meelis Roos (mroos@linux.ee)
