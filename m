MIME-Version: 1.0
Subject: compiling error when compile kgdb on ppc 74XX
Content-Type: text/plain
Date: Fri, 30 May 2003 09:34:07 +0800
Message-ID: <7A7A7A38134E244784EDAC428C538AE90C6FC0@mail.ndsc.com.cn>
From: =?gb2312?B?vNa377j5?= <jfg@ndsc.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


     Hello, everyone:
     I am a novice in Linux. I am trying to build kernel 2.4.17 for ppc on i386 using ppc_74xx-gcc cross compiler.  And the version of GCC is 2.96. The configuration compiles fine when I exclude kernel hacking options. Once kgdb option of the kernel hacking options is included, kernel compilation fails with the following:
     arch/ppc/kernel/kernel.o: In function `getpacket':
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:352: undefined reference to `getDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:352: relocation truncated to fit: R_PPC_REL24 getDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:361: undefined reference to `getDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:361: relocation truncated to fit: R_PPC_REL24 getDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:375: undefined reference to `getDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:375: relocation truncated to fit: R_PPC_REL24 getDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:376: undefined reference to `getDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:376: relocation truncated to fit: R_PPC_REL24 getDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:378: undefined reference to `putDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:378: relocation truncated to fit: R_PPC_REL24 putDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:380: undefined reference to `putDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:380: relocation truncated to fit: R_PPC_REL24 putDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:383: undefined reference to `putDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:383: relocation truncated to fit: R_PPC_REL24 putDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:384: undefined reference to `putDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:384: relocation truncated to fit: R_PPC_REL24 putDebugChar
     arch/ppc/kernel/kernel.o: In function `putpacket':
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:404: undefined reference to `putDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:404: relocation truncated to fit: R_PPC_REL24 putDebugChar
     arch/ppc/kernel/kernel.o:/home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:409: more undefined references to `putDebugChar' follow
     arch/ppc/kernel/kernel.o: In function `putpacket':
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:409: relocation truncated to fit: R_PPC_REL24 putDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:414: relocation truncated to fit: R_PPC_REL24 putDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:415: relocation truncated to fit: R_PPC_REL24 putDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:416: relocation truncated to fit: R_PPC_REL24 putDebugChar
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:417: undefined reference to `getDebugChar'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:417: relocation truncated to fit: R_PPC_REL24 getDebugChar
     arch/ppc/kernel/kernel.o: In function `handle_exception':
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:602: undefined reference to `kgdb_interruptible'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:602: relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:794: undefined reference to `kgdb_interruptible'
     /home/my_work_directory/mykernel/kernel/arch/ppc/kernel/ppc-stub.c:794: relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
     make: *** [vmlinux] Error 1

     Any suggestions?
     Thanks and regards.
                                                          Jiafenggen
                                                               2003-5-28

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
