Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 02C62DDD08
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 00:04:19 +1000 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [POWERPC] 2.6.23-rc1-mm1 build failure
Date: Sun, 29 Jul 2007 16:04:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200707291604.14202.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

	iMac G3 series.

$ make mrproper && make allmodconfig && make

results in this:

  CC      arch/powerpc/kernel/lparmap.s
  AS      arch/powerpc/kernel/head_64.o
lparmap.c: Assembler messages:
lparmap.c:84: Error: file number 1 already allocated
make[1]: *** [arch/powerpc/kernel/head_64.o] Blad 1
make: *** [arch/powerpc/kernel] Blad 2

Regards,

	Mariusz



$ cat /proc/cpuinfo 
processor       : 0
cpu             : 740/750
temperature     : 46-52 C (uncalibrated)
clock           : 400MHz
revision        : 2.2 (pvr 0008 0202)
bogomips        : 796.67
machine         : PowerMac2,1
motherboard     : PowerMac2,1 MacRISC2 MacRISC Power Macintosh
detected as     : 66 (iMac FireWire)
pmac flags      : 00000005
L2 cache        : 512K unified
memory          : 256MB
pmac-generation : NewWorld


Linux iMac-tux 2.6.8-powerpc #1 Thu Nov 24 00:17:15 UTC 2005 ppc GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
Linux C Library        3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
Modules Loaded         ipv6 af_packet joydev tsdev evdev eth1394 tulip crc32 ohci1394 ieee1394 uninorth_agp agpgart dm_snapshot dm_mirror dm_mod snd_powermac snd_pcm_oss snd_pcm snd_page_alloc snd_mixer_oss snd_seq_oss snd_seq_device snd_seq_midi_event snd_seq snd_timer snd soundcore ide_cd cdrom ext3 jbd mbcache usbhid uhci_hcd ohci_hcd usbcore ide_disk unix
