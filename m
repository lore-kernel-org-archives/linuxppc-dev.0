Message-ID: <20031028163832.17883.qmail@web11603.mail.yahoo.com>
Date: Tue, 28 Oct 2003 08:38:32 -0800 (PST)
From: Shamile Khan <shamile@yahoo.com>
Subject: tlbia instruction crashes for 405
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
