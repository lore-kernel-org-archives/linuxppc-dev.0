Date: Fri, 6 Jul 2001 01:40:49 +1000
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: unexpected interrupt
Message-ID: <20010706014049.A1308@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

anyone know what this means, on a computer that locks up hard unless I have
ide0=reset ide1=reset in the kernel arguments.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: QUANTUM FIREBALL ST2100A, ATA DISK drive
ide0: reset
hdc: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
ide1: reset
ide0 at 0xc618a000-0xc618a007,0xc618a160 on irq 13
ide1: unexpected interrupt, status=0x00, count=1
ide1 at 0xc618e000-0xc618e007,0xc618e160 on irq 14
hda: Enabling MultiWord DMA 2
hda: 4201344 sectors (2151 MB) w/81KiB Cache, CHS=4168/16/63, (U)DMA

is there some reason this is unxpected and that the kernel wont work without
the reset?

this is 2.4.6-pre3 benh on a powermac 7220/200

        See You
            Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
