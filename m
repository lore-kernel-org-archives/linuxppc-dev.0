Message-ID: <394507C7.48668A0B@noos.fr>
Date: Mon, 12 Jun 2000 17:54:46 +0200
From: Guillaume Laurhs <guillaume.laures@noos.fr>
Reply-To: guillaume.laures@noos.fr
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: SMP
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello 2 All,

I recently bought a Daystar nPower card to bless an old 9500/132 (it's
now a bi-180). I successfully compiled on it an smp kernel.org 2.2.16
kernel on it, and it works flawlessly... but with only one cpu...

pm9500:~# cat /proc/version
Linux version 2.2.16 (root@pm9500) (gcc version 2.95.2 20000313 (Debian
GNU/Linux)) #2 SMP Mon Jun 12 16:59:05 CEST 2000

pm9500:~# cat /proc/cpuinfo
processor       : 0
cpu             : 604e
clock           : 180MHz
revision        : 2.2
bogomips        : 358.81

total bogomips  : 358.81
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/145 (0%)
machine         : Power Macintosh
motherboard     : AAPL,9500 MacRISC
L2 cache        : 512K unified
memory          : 64MB

I know that smp in an unsupported feature, but would somebody help
me/provide me links or people to activate it ??

Thanks,

GoM

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
