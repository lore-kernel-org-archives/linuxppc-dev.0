Message-ID: <3A0C69A5.F734B825@collins.rockwell.com>
Date: Fri, 10 Nov 2000 15:33:25 -0600
From: John Hagen <jlhagen@collins.rockwell.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: can't compile 2.4.0-testx kernels on G4 YDL C.S. 1.2.1 // partial
 solved.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Setting CONFIG_NVRAM=y solved my undefined references to
pmac_nvram_update but why am I getting undefined references to
'debugger' 'debugger_bpt' etc... ???

CONFIG_ALL_PPC=y
arch/ppc/kernel/Makefile has OX_OBJS := ppc_ksyms.o

and

arch/ppc/kernel/ppc_ksyms.c
EXPORT_SYMBOL(debugger);
EXPORT_SYMBOL(debugger_bpt);
EXPORT_SYMBOL(debugger_sstep);
EXPORT_SYMBOL(debugger_iabr_match);
EXPORT_SYMBOL(debugger_dabr_match);
EXPORT_SYMBOL(debugger_fault_handler);

should these symbols be defined???

Thanks,
John

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
