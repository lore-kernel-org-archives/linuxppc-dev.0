Message-ID: <20040522072520.67684.qmail@web15206.mail.bjs.yahoo.com>
Date: Sat, 22 May 2004 15:25:20 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Module Compiling Problem
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OF833FB15C.A4B24E5E-ON85256E9A.0066AC69-85256E9C.00054851@nanometrics.ca>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

A error happened when I compiled a module.Could any
warmhearted person figure it out for me?

[root@sam ic]# make
ppc_8xx-gcc -D__KERNEL__ -D_REENTRANT
-I/workspace/keep/dmt201-test/kernel/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common
-g -I/workspace/keep/dmt201-test/kernel/arch/ppc
-fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -DMODULE
-DKBUILD_BASENAME=ic -c ic.c
In file included from ic.c:57:
/workspace/keep/dmt201-test/kernel/include/linux/tty_flip.h:
In function `tty_schedule_flip':
/workspace/keep/dmt201-test/kernel/include/linux/tty_flip.h:22:
`tq_timer_Rfa3e9acc' undeclared (first use in this
function)
/workspace/keep/dmt201-test/kernel/include/linux/tty_flip.h:22:
(Each undeclared identifier is reported only once
/workspace/keep/dmt201-test/kernel/include/linux/tty_flip.h:22:
for each function it appears in.)
ic.c: In function `service_timer':
ic.c:851: `tq_immediate_R0da0dcd1' undeclared (first
use in this function)
ic.c: In function `timer_do_tasklet':
ic.c:944: warning: implicit declaration of function
`__wake_up_Rf0f2f792'
ic.c: In function `m8xx_timer_setup':
ic.c:1032: `__res_Rd7dfb463' undeclared (first use in
this function)
ic.c: In function `initicdata':
ic.c:1360: warning: implicit declaration of function
`kmalloc_R93d4cfe6'
ic.c:1360: warning: assignment makes pointer from
integer without a cast
ic.c:1363: warning: assignment makes pointer from
integer without a cast
ic.c: In function `icread':
ic.c:1389: warning: implicit declaration of function
`printk_Rdd132261'
ic.c: In function `init_ic':
ic.c:1659: warning: implicit declaration of function
`register_chrdev_R6c9c715e'
ic.c: In function `remove_ic':
ic.c:1724: warning: implicit declaration of function
`unregister_chrdev_Rc192d491'
make: *** [ic.o] Error 1

Thanks a lot for any input!

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
