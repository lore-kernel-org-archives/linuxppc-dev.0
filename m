From: "Vladimir Simonov" <sv@asplinux.ru>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: OF access after kernel boot
Date: Tue, 4 Jul 2000 11:39:52 +0400
Message-ID: <NEBBKFDEKEFCPABJIFOMCEAKCPAA.sv@sw.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
I'd like to change some OF (Open Firmware)
parameters after kernel loading. But arch/ppc/prom.c
runs "Because OF may have mapped I/O devices into the area
starting at KENELBASE,....Therefore all OF calls should be
done within prom_init()...".
Is it possible to keep safe interface to OF
after kernel's mapping to KERNELBASE?
If it is not possible for all PPC, perhaps,
a list of mashines where it works and
some hints how to do it will be useful.

Thanks in advance
Vladimir Simonov

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
