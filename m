Date: Tue, 4 Jul 2000 10:51:05 -0400
From: Simon Piette <spiette@generation.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: OF access after kernel boot
Message-ID: <20000704105105.E18342@xim.bellglobal.com>
Reply-To: spiette@generation.net
References: <NEBBKFDEKEFCPABJIFOMCEAKCPAA.sv@sw.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NEBBKFDEKEFCPABJIFOMCEAKCPAA.sv@sw.mipt.ru>; from sv@asplinux.ru on Tue, Jul 04, 2000 at 11:39:52AM +0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

* Vladimir Simonov (sv@asplinux.ru) [000704 03:40]:
>
> Hi all,
> I'd like to change some OF (Open Firmware)
> parameters after kernel loading. But arch/ppc/prom.c
> runs "Because OF may have mapped I/O devices into the area
> starting at KENELBASE,....Therefore all OF calls should be
> done within prom_init()...".
> Is it possible to keep safe interface to OF
> after kernel's mapping to KERNELBASE?
> If it is not possible for all PPC, perhaps,
> a list of mashines where it works and
> some hints how to do it will be useful.
>

man nvsetenv

Without parameters, nvsetenv will give you the values of nvram
registers.

Cheers,

Simon

--
PGP key ID: 1024D/99290743 	Simon Piette <spiette@generation.net>
PGP Key fingerprint: 9AF9 33F9 A900 E153 9DF3  0625 8928 CB52 9929 0743

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
