Message-ID: <C7FFFEA58B43D311920D0004ACE5333F10E4F2FB@amer25.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Shamile Khan'" <shamile@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: tlbia instruction crashes for 405
Date: Tue, 28 Oct 2003 09:39:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need

 PORT tiec405mmuen = net_vcc

in your .mhs file.

-----Original Message-----
From: Shamile Khan [mailto:shamile@yahoo.com]
Sent: Tuesday, October 28, 2003 9:39 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: tlbia instruction crashes for 405



Hi,

I am trying to get Linux to run on a Memec Virtex II Pro
board which has a Powerpc 405 core. I have 32 megs of
SDRAM. I get till the point below

loaded at:     00400000 004931D0
board data at: 00490128 00490140
relocated to:  00406618 00406630
zimage at:     00406C40 0048F6E4
avail ram:     00494000 02000000

Linux/PPC load: console=ttyS0,9600 mem=32M
Uncompressing Linux...done.
Now booting the kernel

After this the system hangs. Upon single stepping using an
abatron, I found the tlbia instruction to be the culprit.
This is the first instruction in initial_mmu in
arch/ppc/kernel/head_4xx.S. Its supposed to invalidate all
TLB enties. Any pointers as to why this instruction might
be crashing??

Thanks,
Shamile



Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
