Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <6D4DC8B4AD16D6118E8200D0B76FE262023191B9@ONT06EXM01>
From: "D'Abbraccio Joe-ljd015" <Joe.D'abbraccio@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems building the kernel using the ELDK
Date: Thu, 10 Oct 2002 17:22:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When I build the kernel using the ELDK I get the following failure:
>>>>>
ppc_82xx-gcc -D__KERNEL__ -I/usr/opt/kernels/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/opt/kernels/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -iwithprefix include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
In file included from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/wait.h:13,
                 from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/fs.h:12,
                 from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/capability.h:17,
                 from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/binfmts.h:5,
                 from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/sched.h:9,
                 from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/mm.h:4,
                 from sched.c:23:
/usr/opt/kernels/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h: No such file or directory
<<<<<

Where is stdarg.h expected to come from if not from stdinc (i.e. -nostdinc).  I don't believe there is one in kernel distribution.

Thanks in advance,
Joe


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
