Message-ID: <3A78C148.F1F2579A@fnc.fujitsu.com>
Date: Wed, 31 Jan 2001 19:52:08 -0600
From: Konstantin Sabodash <konstantin.sabodash@fnc.fujitsu.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: SCC2 as console on 8260
Content-Type: text/plain; charset=iso-8859-7
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have custom 8260 board.
My bootloader  console works on SCC2(hardware configured).
I modified arch/ppc/mbxboot/m8260_tty.c  and I can see this on my SCC2.


loaded at:     00410000 0041B29C
relocated to:  00400000 0040B29C
board data at: 00400190 004001BC
relocated to:  00200100 0020012C
zimage at:     00416000 00486818
avail ram:     00487000 04000000
Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

Next:
I set  in "arch/ppc/8260_io/uart.c"
#define CONFIG_SERIAL_CONSOLE_PORT 2
Is it enough to to make SCC2 main console?
You help is greatly appreciated.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
