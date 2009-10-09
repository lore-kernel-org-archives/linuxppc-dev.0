Return-Path: <ron.mercer@qlogic.com>
Received: from avexch1.qlogic.com (avexch1.qlogic.com [198.70.193.115])
	by ozlabs.org (Postfix) with ESMTP id 98D19B7B77
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Oct 2009 05:07:38 +1100 (EST)
Date: Fri, 9 Oct 2009 10:49:33 -0700
From: Ron Mercer <ron.mercer@qlogic.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Linux net-2.6 build error for PPC
Message-ID: <20091009174933.GA6797@linux-ox1b.qlogic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: ron.mercer@qlogic.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I recently grabbed the latest net-2.6 kernel for a powerpc test box and
got this compile error.

  CC      arch/powerpc/kernel/cputable.o
    CC      arch/powerpc/kernel/ptrace.o
      CC      arch/powerpc/kernel/syscalls.o
        CC      arch/powerpc/kernel/irq.o
	   CC      arch/powerpc/kernel/align.o
	     CC      arch/powerpc/kernel/signal_32.o
	       CC      arch/powerpc/kernel/pmc.o
		  CC      arch/powerpc/kernel/vdso.o
		    cc1: warnings being treated as errors
		      arch/powerpc/kernel/vdso.c:78: warning: alignment of
		        âso_data_storeâs greater than maximum object file
			   alignment.  Using 32768
			     make[1]: *** [arch/powerpc/kernel/vdso.o]
			     Error 1
			       make: *** [arch/powerpc/kernel] Error 2
				  [root@localhost linux-2.6-net.git]#



				    Any suggestions would be appreciated.
