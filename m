Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Autoboot in U-boot
From: "Mike G." <gohas@actinium.org>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Date: 18 Jul 2003 10:33:02 +0800
Message-Id: <1058495583.1183.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi there,

Can someone help me on this autoboot? I successfully configured the
u-boot-0.4.0 for mpc857 custom board but somehow the bootcommand and
boot arg would not run, it just skip the autoboot and goes to prompt. so
help!!!

this is part of the configuration

....................................................................
#if 0
#define CONFIG_BOOTDELAY	-1	/* autoboot disabled*/
#else
#define CONFIG_BOOTDELAY	3	/* autoboot after 5 sec	*/
#endif

#define CONFIG_BOOTCOMMAND	"bootm 02800000 02880000"
#define CONFIG_BOOTARGS		"root=/dev/ram rw"


#undef	CONFIG_WATCHDOG			/* watchdog disabled*/

#define	CONFIG_SCC2_ENET	1	/* use SCC2 ethernet */
#undef	CONFIG_FEC_ENET			/* disable FEC ethernet  */

/* this must be included AFTER the definition of CONFIG_COMMANDS (if
any) */
#include <cmd_confdefs.h>

/*
 * Miscellaneous configurable options
 */
#undef	CFG_LONGHELP		/* undef to save memory*/
#define	CFG_PROMPT	":>"	/* Monitor CommandPrompt	*/
..................................................................

and this is the output displayed:-

......................................................................
U-Boot 0.4.0 (Jul 18 2003 - 10:17:35)

CPU:   unknown MPC850 (0x07000003) at 48 MHz: 4 kB I-Cache 4 kB D-Cache
FEC pret
         *** Warning: CPU Core has Silicon Bugs -- Check the Errata ***
SDRAM:  16 MB
Top of RAM usable for U-Boot at: 01000000
Reserving 512k for U-Boot at: 00f80000
Reserving 256k for malloc() at: 00f40000
Reserving 60 Bytes for Board Info at: 00f3ffc4
Reserving 52 Bytes for Global Data at: 00f3ff90
Stack Pointer at: 00f3ff78
New Stack Pointer is: 00f3ff78
Now running in RAM - U-Boot at: 00f80000
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
U-Boot relocated to 00f80000
Net:   SCC ETHERNET
:>
:>

...................................................................

So i don't understand... where did the autoboot go??

hmm.... thanks guys


regards,
Mike G.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
