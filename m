Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "yhxing" <xyuhua_telecom@hotmail.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA problem help!
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 21 Apr 2004 17:04:16 +0800
Message-ID: <Sea1-DAV39b0zrAXBir0002037c@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

  When I use PC card on mpc823, there is some trouble, the card
initialization would always run and can not stop. Here are the printed
messages at the start:

  Linux PCMCIA Card Services 3.2.1
  kernel build: 2.4.4-rthal5 #959 Fri Feb 6 12:46:59 CST 2004
  options:  none
m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
m8xx_pcmcia: TQM8xxL using SLOT_B with IRQ 13.
m8xx_pcmcia: Socket 0: MemWin 0: Base 0xe0000000.
m8xx_pcmcia: Socket 0: MemWin 1: Base 0xe4000000.
m8xx_pcmcia: Socket 0: MemWin 2: Base 0xe8000000.
m8xx_pcmcia: Socket 0: MemWin 3: Base 0xec000000.
m8xx_pcmcia: Socket 0: MemWin 4: Base 0xf0000000.
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, Vcc=0.0, Vpp=0.0
m8xx_pcmcia: Disable PCMCIA buffers and assert RESET
m8xx_pcmcia: PCMCIA power OFF
m8xx_pcmcia: PIPR: 0xff00ff00 --> only 5 V
m8xx_pcmcia: PCMCIA powered down
m8xx_pcmcia: Enable PCMCIA buffers and stop RESET
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, DONE
m8xx_pcmcia: hardware_enable: TQM8xxL Slot B
m8xx_pcmcia: Disable PCMCIA buffers and assert RESET
m8xx_pcmcia: [621] hardware_enable: PIPR(fff000f0)=0xff000200
m8xx_pcmcia: PIPR: 0xff000200 ==> VS1=off, VS2=off
m8xx_pcmcia:  3.3V card found: m8xx_pcmcia: Enable PCMCIA buffers and stop RESET
m8xx_pcmcia: # hardware_enable done
m8xx_pcmcia: Service(0, 4, 0xc021980c)
m8xx_pcmcia: SetSocket(0, flags 0x000, Vcc 0, Vpp 0, io_irq 0, csc_mask 0x80)
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, Vcc=0.0, Vpp=0.0
m8xx_pcmcia: Disable PCMCIA buffers and assert RESET
m8xx_pcmcia: PCMCIA power OFF
m8xx_pcmcia: PIPR: 0xff000200 --> can do 3.3V
m8xx_pcmcia: PCMCIA powered down
m8xx_pcmcia: Enable PCMCIA buffers and stop RESET
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, DONE
m8xx_pcmcia: Service(0, 6, 0xc0647e58)
PCMCIA_IO_WIN_BASE = 80000000
m8xx_pcmcia: SetIOMap(0, 0, 0x00, 0 ns, 0x0000-0x0001)
m8xx_pcmcia: Service(0, 6, 0xc0647e58)
PCMCIA_IO_WIN_BASE = 80000000
m8xx_pcmcia: SetIOMap(0, 1, 0x00, 0 ns, 0x0000-0x0001)
m8xx_pcmcia: Service(0, 8, 0xc0647e48)
m8xx_pcmcia: SetMemMap(0, 0, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8028a84.
m8xx_pcmcia: SetMemMap(0, 0, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Service(0, 8, 0xc0647e48)
m8xx_pcmcia: SetMemMap(0, 1, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 1 at 0xe4000000, OR = 0xb8028a84.
m8xx_pcmcia: SetMemMap(0, 1, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Service(0, 8, 0xc0647e48)
m8xx_pcmcia: SetMemMap(0, 2, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 2 at 0xe8000000, OR = 0xb8028a84.
m8xx_pcmcia: SetMemMap(0, 2, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Service(0, 8, 0xc0647e48)
m8xx_pcmcia: SetMemMap(0, 3, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 3 at 0xec000000, OR = 0xb8028a84.
m8xx_pcmcia: SetMemMap(0, 3, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Service(0, 8, 0xc0647e48)
m8xx_pcmcia: SetMemMap(0, 4, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 4 at 0xf0000000, OR = 0xb8028a84.
m8xx_pcmcia: SetMemMap(0, 4, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Service(0, 1, 0xc0219818)
m8xx_pcmcia: Service(0, 11, 0xc02fd320)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
ip_conntrack (128 buckets, 1024 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
m8xx_pcmcia: Service(0, 0, 0xc0647e58)
m8xx_pcmcia: Service(0, 2, 0xc0647e60)
m8xx_pcmcia: GetStatus(0) = 0x90
m8xx_pcmcia: Service(0, 2, 0xc0647dd8)
m8xx_pcmcia: GetStatus(0) = 0x90
m8xx_pcmcia: Service(0, 4, 0xc021980c)
m8xx_pcmcia: SetSocket(0, flags 0x000, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, Vcc=5.0, Vpp=5.0
m8xx_pcmcia: Disable PCMCIA buffers and assert RESET
m8xx_pcmcia: PCMCIA power OFF
m8xx_pcmcia: PIPR: 0xff000200 --> can do 3.3V
m8xx_pcmcia: PCMCIA powered at 5.0V
m8xx_pcmcia: Enable PCMCIA buffers and stop RESET
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, DONE
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 64k init
m8xx_pcmcia: Service(0, 4, 0xc021980c)
m8xx_pcmcia: SetSocket(0, flags 0x240, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, Vcc=5.0, Vpp=5.0
m8xx_pcmcia: Disable PCMCIA buffers and assert RESET
m8xx_pcmcia: PCMCIA power OFF
m8xx_pcmcia: PIPR: 0xff000200 --> can do 3.3V
m8xx_pcmcia: PCMCIA powered at 5.0V
m8xx_pcmcia: Enable PCMCIA buffers and stop RESET
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, DONE
m8xx_pcmcia: Service(0, 4, 0xc021980c)
m8xx_pcmcia: SetSocket(0, flags 0x200, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, Vcc=5.0, Vpp=5.0
m8xx_pcmcia: Disable PCMCIA buffers and assert RESET
m8xx_pcmcia: PCMCIA power OFF
m8xx_pcmcia: PIPR: 0xff000200 --> can do 3.3V
m8xx_pcmcia: PCMCIA powered at 5.0V
m8xx_pcmcia: Enable PCMCIA buffers and stop RESET
m8xx_pcmcia: voltage_set: TQM8xxL Slot B, DONE
m8xx_pcmcia: Service(0, 2, 0xc015ee48)
m8xx_pcmcia: GetStatus(0) = 0x190
init started:  BusyBox v0.60.2 (2002.02.02-02:29+0000) multi-call m8xx_pcmcia: S
ervice(0, 2, 0xc06d3908)
m8xx_pcmcia: GetStatus(0) = 0x190
m8xx_pcmcia: Service(0, 2, 0xc0695df8)
m8xx_pcmcia: GetStatus(0) = 0x190
m8xx_pcmcia: Service(0, 2, 0xc0695df8)
m8xx_pcmcia: GetStatus(0) = 0x190
Using /lib/modules/2.4.4-rthal5/net/hostap_crypt.o
hostap_crypto_init
hcrypt:c02028e0
1
alg=c02023a0
3
4
hostap_crypt: registered algorithm '}i|NÄ =`®§9k°‰H}i|NÄ =`®§'
m8xx_pcmcia: Service(0, 2, 0xc0695818)
m8xx_pcmcia: GetStatus(0) = 0x190
Using /lib/modules/2.4.4-rthal5/net/hostap.o
m8xx_pcmcia: Service(0, 2, 0xc0695c98)
m8xx_pcmcia: GetStatus(0) = 0x190
m8xx_pcmcia: Service(0, 2, 0xc0695c28)
m8xx_pcmcia: GetStatus(0) = 0x190
Using /lib/modules/2.4.4-rthal5/pcmcia/hostap_cs.o
m8xx_pcmcia: Service(0, 2, 0xc0695df8)
m8xx_pcmcia: GetStatus(0) = 0x190
hostap_cs:
hostap_cs: (c) Jouni Malinen <jkmaline@cc.hut.fi>
m8xx_pcmcia: Service(0, 2, 0xc0695ae8)
m8xx_pcmcia: GetStatus(0) = 0x190
Using /lib/modules/2.4.4-rthal5/net/hostap_crypt_wep.o
hcrypt:c02028e0
1
alg=c0202380
3
4
hostap_crypt: registered algorithm 'WEP'
m8xx_pcmcia: Service(0, 2, 0xc0695bd8)
m8xx_pcmcia: GetStatus(0) = 0x190
do_bind fd=3 driver=hostap_cs
resource adj ret=0
prism2_attach
PDEBUG
m8xx_pcmcia: Service(0, 8, 0xc0219870)
m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0x00000-0x00000, 0x00000)
m8xx_pcmcia: Service(0, 2, 0xc06956e8)
m8xx_pcmcia: GetStatus(0) = 0x190
m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8028a95.
m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
m8xx_pcmcia: Service(0, 2, 0xc06956e8)
m8xx_pcmcia: GetStatus(0) = 0x190
m8xx_pcmcia: Service(0, 8, 0xc0219870)
m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8028a95.
m8xx_pcmcia: Service(0, 2, 0xc06956e8)
m8xx_pcmcia: GetStatus(0) = 0x190
m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
m8xx_pcmcia: Service(0, 8, 0xc0219870)
........
-------------------------------------------------------------------------------

  This  "m8xx_pcmcia" process will continue and cannot stop.

  What is the matter with it?

Regards,
Yuhua Xing

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
