Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Paul Ruhland <pruhland@microwavedata.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: pcmcia-cs-3.1.34 compile problems
Date: Mon, 15 Jul 2002 15:53:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200207151553.27554.pruhland@microwavedata.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been using linux-2.4.4-2001-07-23 with a patched pcmcia-cs-3.1.24...works
great ( MPC850 platform ).

For a new project, I thought I would try the linux-2.4 cvs tree from DENX.
Applied all changes for our board...no problems...works as expected.  Then I
grabbed pcmcia-cs-3.1.34 from sourceforge and added the board specific stuff
and can't get it to compile.

Has anyone else tried/gotten the pcmcia-cs-3.1.34 source to compile for ppc
linux-2.4.x or had similar probems?

Below is the output from the build:

ppc_8xx-gcc -fno-builtin -msoft-float -ffixed-r2  -MD -O2 -Wall
-Wstrict-prototypes -pipe -I../include
-I/home/paulr/projects/nautilus2/src/linux/include  -D__KERNEL__ -DMODULE -c
m8xx_pcmcia.c
m8xx_pcmcia.c: In function `m8xx_shutdown':
m8xx_pcmcia.c:546: warning: implicit declaration of function
`free_irq_Rf20dabd8'
m8xx_pcmcia.c: In function `m8xx_init':
m8xx_pcmcia.c:561: warning: implicit declaration of function
`printk_Rdd132261'
m8xx_pcmcia.c:562: warning: implicit declaration of function
`CardServices_Re4eef0a4'
m8xx_pcmcia.c:573: warning: implicit declaration of function
`request_8xxirq_R814af5f5'
m8xx_pcmcia.c:627: warning: implicit declaration of function
`register_ss_entry_Reda35fe3'
m8xx_pcmcia.c: In function `m8xx_exit':
m8xx_pcmcia.c:641: warning: implicit declaration of function
`unregister_ss_entry_R7f678b5b'
m8xx_pcmcia.c: In function `m8xx_get_speed':
m8xx_pcmcia.c:782: `__res_Rd7dfb463' undeclared (first use in this function)
m8xx_pcmcia.c:782: (Each undeclared identifier is reported only once
m8xx_pcmcia.c:782: for each function it appears in.)
m8xx_pcmcia.c:755: warning: `clocks' might be used uninitialized in this
function
m8xx_pcmcia.c: In function `m8xx_get_status':
m8xx_pcmcia.c:918: warning: implicit declaration of function `socket_get'
m8xx_pcmcia.c: In function `m8xx_set_socket':
m8xx_pcmcia.c:1000: warning: implicit declaration of function
`__save_flags_ptr_R98964d1e'
m8xx_pcmcia.c:1001: warning: implicit declaration of function
`__cli_Re45078fb'
m8xx_pcmcia.c:1115: warning: implicit declaration of function
`__restore_flags_R9a3562fe'
make[1]: *** [m8xx_pcmcia.o] Error 1
make[1]: Leaving directory
`/home/paulr/projects/nautilus2/src/pcmcia-cs-3.1.34/modules'
make: *** [all] Error 2

--
Paul Ruhland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
