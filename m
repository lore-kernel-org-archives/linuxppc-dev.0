Date: Tue, 13 Jul 2004 14:58:37 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: short followup on apparently obsolete config variables
Message-ID: <Pine.LNX.4.60.0407131448270.13592@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   from what i can tell, the config process under 2.6 doesn't recognize
the option variables (among others):

   CONFIG_SERIAL_CONSOLE_PORT
   CONFIG_CONS_SMC2

yet those variables are explicitly mentioned in kernel source files as
follows:

CONFIG_SERIAL_CONSOLE_PORT:
arch/ppc/8xx_io/uart.c
drivers/serial/68360serial.c

CONFIG_CONS_SMC2:
arch/ppc/8xx_io/uart.c
arch/ppc/configs/TQM823L_defconfig
arch/ppc/configs/TQM860L_defconfig
arch/ppc/configs/mbx_defconfig
arch/ppc/configs/SM850_defconfig
arch/ppc/configs/SPD823TS_defconfig
arch/ppc/configs/SCCS/s.FADS_defconfig
arch/ppc/configs/rpxcllf_defconfig
arch/ppc/configs/bseip_defconfig
arch/ppc/configs/TQM850L_defconfig
arch/ppc/configs/FADS_defconfig

   i'd try to submit some patches but, trust me, you probably don't
want me messing with the code.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
