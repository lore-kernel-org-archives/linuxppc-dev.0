Message-Id: <200112052037.fB5KbG623486@mailout6-0.nyroc.rr.com>
Content-Type: text/plain;
  charset="utf-8"
From: Armando Di Cianno <armando@nycap.rr.com>
Reply-To: diciaa@rpi.edu
To: <linuxppc-dev@lists.linuxppc.org>
Subject: kernel pcmcia drivers/ide-cs stopped working in ben's tree at >= 2.4.16
Date: Wed, 5 Dec 2001 15:37:15 -0500
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

Every time I post a problem I always remeber to thank the Linux PowerPC devs
for all their hard work; so a big thanks to all. ;-)

At some point, kernel pcmcia drivers/ide-cs stopped working.  I've never been
able to get the pcmcia-package drivers working, and have always used the
kernel drivers, with the utils from the pcmcia-package.  (The symptoms I will
describe happen in both pcmcia package 3.1.29 and 3.1.30).  I tend to rely
grealty on these drivers as they have always made it easier to get images off
my digital cameras' media.

I'm running my own distro (mostly LFS style), and using ben's sources.
Hardware is a 400Mhz G4 TiBook.

In 2.4.14-ben0, and 2.4.15-pre6-ben0, after pcmcia services are started,
dmesg reports the same happy information (these examples done with a 340Mb
IBM microdrive, but the symptoms happen for my 8 and 32Mb CF cards, with the
same pcmcia adaptor):
cs: memory probe 0x80000000-0x80ffffff: excluding 0x80000000-0x800fffff
hde: IBM-DMDM-10340, ATA DISK drive
ide2 at 0x100-0x107,0x10e on irq 58
ide-floppy driver 0.97.sv
hde: 700560 sectors (359 MB) w/96KiB Cache, CHS=695/16/63
 /dev/ide/host2/bus0/target0/lun0: p1
ide_cs: hde: Vcc = 3.3, Vpp = 0.0

In 2.4.16-ben0, this is what dmesg reports:
cs: memory probe 0x80000000-0x80ffffff: excluding 0x80000000-0x80ffffff
cs: unable to map card memory!
cs: unable to map card memory!

In 2.4.17-pre2-ben0, in console mode, the laptop immeadiately shuts down; in
X, the laptop freezes.

I'm 99.9% sure my /etc/pcmcia/* info is correct (as it still works for older
kernels, with all of the pcmcia-package version's I've tried).  If these
symptoms can help any of the ppc kernel hackers solve this problem, I'd be so
very happy.

Again, thanks for making Linux viable on powerpc.

__Armando Di Cianno
diciaa@rpi.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
