From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: MVME5100: kernel hangs in dcache_init
Date: Fri, 16 Feb 2001 12:45:49 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMOENPCOAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everyone,

  I'm trying to run Debian linux 2.2.18 on a MVME5100 board. I've done some
change:
 - changed addresses of UART registers in arch/ppc/boot/ns16550.h
 - changed BAT settings in arch/ppc/mm/init.c to map IO region 0xf0000000 to
0xffffffff
and some other things.
Now the kernel hangs in the dcache_init routine in init/main.c and it seems
to me that the problem is related to memory management, but I'm not sure.
If I comment out the the routine calls from dcache_init to check_bugs(), the
kernel go on a little showing me some infos about PCI devices.

Anyone of you can help me ?

Thanks in advance.
Stefano.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
