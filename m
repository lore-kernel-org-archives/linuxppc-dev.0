From: Tomas Carmen <tomas@tcc.com.pe>
To: linuxppc-embedded@lists.linuxppc.org
cc: arsenio@tin.it
Subject: help with Patches for FADS8xx and suggestions
Message-ID: <Pine.LNX.4.10.10008221155330.6840-100000@maestro.tcc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Tue, 22 Aug 2000 13:21:05 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi list:
I get the kernel mpc8xx-2.2.13.tgz from ftp://linuxppc.cs.nmt.edu
and the patches from Damm y Bossek, I'm working on i586 redHat 6.1 and my
own crosscompiler, for the patches I'm getting:
  ls -l /usr/src/
  lrwxrwxrwx             5 Aug 21 19:29 embedded_2.2.13_org-> linux
  drwxr-xr-x          2048 Oct 22  1999 linux
  lrwxrwxrwx             5 Aug 21 18:34 mpc8xx-2.2.13 -> linux

  # gzip -cd patch-2_2_13-mpc8xx-damm_diff.gz | patch -p0
  patching file `embedded_2.2.13_org/arch/ppc/8xx_io/commproc.h'
  Hunk #1 FAILED at 457.
  1 out of 1 hunk FAILED -- saving rejects to
  embedded_2.2.13_org/arch/ppc/8xx_io/commproc.h.rej
  patching file `embedded_2.2.13_org/arch/ppc/8xx_io/enet.c'
  Hunk #1 FAILED at 981.
  Hunk #2 FAILED at 1022.
  2 out of 2 hunks FAILED -- saving rejects to
  embedded_2.2.13_org/arch/ppc/8xx_io/enet.c.rej
  patching file `embedded_2.2.13_org/arch/ppc/8xx_io/uart.c'
  Hunk #1 FAILED at 2417.
  1 out of 1 hunk FAILED -- saving rejects to
  embedded_2.2.13_org/arch/ppc/8xx_io/uart.c.rej
  patching file `embedded_2.2.13_org/arch/ppc/config.in'
  Hunk #1 FAILED at 31.
  1 out of 1 hunk FAILED -- saving rejects to
  embedded_2.2.13_org/arch/ppc/config.in.rej
  patching file `embedded_2.2.13_org/arch/ppc/kernel/irq.c'
  Hunk #1 FAILED at 54.
  1 out of 1 hunk FAILED -- saving rejects to
  embedded_2.2.13_org/arch/ppc/kernel/irq.c.rej
  patching file `embedded_2.2.13_org/arch/ppc/kernel/ppc8xx_pic.c'
  Hunk #1 FAILED at 137.
.....
...
..
  Hunk #1 FAILED at 100.
  1 out of 1 hunk FAILED -- saving rejects to
  embedded_2.2.13_org/arch/ppc/mbxboot/m8xx_tty.c.rej
  patching file `embedded_2.2.13_org/arch/ppc/mm/init.c'
  Hunk #1 FAILED at 51.
  Hunk #2 FAILED at 74.
  Hunk #3 FAILED at 1104.
  3 out of 3 hunks FAILED -- saving rejects to
  embedded_2.2.13_org/arch/ppc/mm/init.c.rej
  patching file `embedded_2.2.13_org/include/asm-ppc/ads.h'
  patching file `embedded_2.2.13_org/include/asm-ppc/fads.h'
  Hunk #1 FAILED at 1.
  Hunk #2 FAILED at 73.
  2 out of 2 hunks FAILED -- saving rejects to
  embedded_2.2.13_org/include/asm-ppc/fads.h.rej
  patching file `embedded_2.2.13_org/include/asm-ppc/mpc8xx.h'
  Hunk #1 FAILED at 12.
  Hunk #2 FAILED at 58.
  2 out of 2 hunks FAILED -- saving rejects to
  embedded_2.2.13_org/include/asm-ppc/mpc8xx.h.rej
  patching file `embedded_2.2.13_org/include/asm-ppc/processor.h'
  Hunk #1 FAILED at 70.
  1 out of 1 hunk FAILED -- saving rejects to
  embedded_2.2.13_org/include/asm-ppc/processor.h.rej


Its the same for Bossek patches

  # gzip -cd patch-2_2_13-mpc8xx-bossek_diff | patch -p0
  patching file `mpc8xx-2.2.13/arch/ppc/8xx_io/commproc.h'
  Hunk #1 FAILED at 459.
  Hunk #2 FAILED at 479.
  2 out of 2 hunks FAILED -- saving rejects to
  mpc8xx-2.2.13/arch/ppc/8xx_io/commproc.h.rej
  patching file `mpc8xx-2.2.13/arch/ppc/8xx_io/enet.c'
  Hunk #1 FAILED at 124.
  Hunk #2 FAILED at 996.
  2 out of 2 hunks FAILED -- saving rejects to
  mpc8xx-2.2.13/arch/ppc/8xx_io/enet.c.rej

What am I missing?

I'm needing this for MPC 860 and then 823.
I want use:
 SCC1 for ethernet
 SMC1 for RS232 (UART)
 SMC2 for RS232 (UART)
 and PCMCIA

Do you have any suggestions for .config? Are there other patches?

Thanks for your help.

---------------
Tomas Carmen R.
TCC S.A.
+511-4428842
Lima - Peru

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
