Message-ID: <001401bffcf8$1a391220$e573a7ca@saigonnet.vn>
From: "Phuc Le" <lmphuc@yahoo.com>
To: "Embedded Linux" <linuxppc-embedded@lists.linuxppc.org>
Subject: Installing PCMCIA hard disk on DVK MPC823
Date: Thu, 3 Aug 2000 10:06:44 +0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi There,

My name's Phuc Le. I am new on this field. I just installed
PCMCIA HDD on the the DVK MPC823 but it failed. Following
is step by step of the installing.

1. Install the embedded linux and cross-platform development
kit from Montavista in the pc-linux
2. Install the pcmcia package in there
3. Install the kernel patch supporting pcmcia
4. Install the pcmcia patch
5. Modify something belong to the document attached along with
the pcmcia package
6. Build and install the embedded kernel and also the pcmcia
7. Boot the DVK via tftp
8. Load pcmcia modules such as 'pcmcia_core.o', 'm8xx_pcmcia.o'
and 'ds.o'
9. Run the cardmgr

At this point everything really seemed to be OK.

10. Flug the pcmcia hard disk

The result was the cardmgr detects the flugged pcmcia device to be
ATA/IDE and it tried to load the 'ide_cs.o' module. But it failed. The error
message were displayed as below:

... ide_cs.o: unresolved symbol 'ide_register'
... ide_cs.o: unresolved symbol 'ide_unregister'

I tried to rebuilt the kernel with turn-on some IDE features in the
configuration phase and recompile the pcmcia based on the new kernel.

The result was still failed with the kernel to be panic status.

Have someone done this task? please tell me how to fix that.

Thanks in advances,
LMP
----------------------------------------------------------------
Phuc My LE
lmphuc@saigonnet.vn


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
