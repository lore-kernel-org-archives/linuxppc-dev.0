Message-ID: <400327FF.1080403@g-house.de>
Date: Tue, 13 Jan 2004 00:04:31 +0100
From: Christian <evil@g-house.de>
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: perfctr-2.6.4 released with PPC32 support
References: <200401121724.i0CHONeP023816@harpo.it.uu.se>
In-Reply-To: <200401121724.i0CHONeP023816@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mikael Pettersson wrote:
> Version 2.6.4 of perfctr, the Linux performance
> monitoring counters driver, is now available at the usual
> place: http://www.csd.uu.se/~mikpe/linux/perfctr/
>
> Three architectures are now supported: x86, AMD64, and PPC32.
>
> Since I only have a PPC750, I'm looking for testers with 74xx
> or 604 processors. Even if you don't intend to use the driver,

kernel patches applied with no fuzz to 2.4.24, but compiling the library
gives:

[...]
make[4]: Leaving directory `/usr/local/src/perfctr-2.6.4/examples/perfex'
make[4]: Entering directory `/usr/local/src/perfctr-2.6.4/examples/signal'
gcc -O2 -fomit-frame-pointer -Wall -I../../linux/include -I../../usr.lib
  -c -o ppc.o ppc.c
ppc.c: In function `mcontext_pc':
ppc.c:15: error: structure has no member named `regs'
make[4]: *** [ppc.o] Error 1
make[4]: Leaving directory `/usr/local/src/perfctr-2.6.4/examples/signal'
make[3]: Leaving directory `/usr/local/src/perfctr-2.6.4/examples'
make[2]: Leaving directory `/usr/local/src/perfctr-2.6.4/examples'
make[1]: Leaving directory `/usr/local/src/perfctr-2.6.4'
evil@sheep:/usr/local/src/perfctr-2.6.4$

evil@sheep:/usr/local/src/perfctr-2.6.4$ gcc --version | head -n1
gcc (GCC) 3.3.3 20031229 (prerelease) (Debian)

evil@sheep:/usr/local/src/perfctr-2.6.4$ cat /proc/cpuinfo
processor       : 0
cpu             : 604r
clock           : ???
revision        : 49.2 (pvr 0009 3102)
bogomips        : 299.00
machine         : PReP Utah (Powerstack II Pro4000)
l2 cache        : 512KiB, parity disabled SRAM:synchronous, pipelined,
no parity

Christian.
--
BOFH excuse #123:

user to computer ratio too high.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
