Date: Tue, 13 Jan 2004 10:32:48 +0100 (MET)
Message-Id: <200401130932.i0D9WmBh027467@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: evil@g-house.de
Subject: Re: perfctr-2.6.4 released with PPC32 support
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Jan 2004 00:04:31 +0100, Christian <evil@g-house.de> wrote:
>Mikael Pettersson wrote:
>> Version 2.6.4 of perfctr, the Linux performance
>> monitoring counters driver, is now available at the usual
>> place: http://www.csd.uu.se/~mikpe/linux/perfctr/
>>
>> Three architectures are now supported: x86, AMD64, and PPC32.
>>
>> Since I only have a PPC750, I'm looking for testers with 74xx
>> or 604 processors. Even if you don't intend to use the driver,
>
>kernel patches applied with no fuzz to 2.4.24, but compiling the library
>gives:
>
>[...]
>make[4]: Leaving directory `/usr/local/src/perfctr-2.6.4/examples/perfex'
>make[4]: Entering directory `/usr/local/src/perfctr-2.6.4/examples/signal'
>gcc -O2 -fomit-frame-pointer -Wall -I../../linux/include -I../../usr.lib
>  -c -o ppc.o ppc.c
>ppc.c: In function `mcontext_pc':
>ppc.c:15: error: structure has no member named `regs'
>make[4]: *** [ppc.o] Error 1

Hmm, must be a glibc or kernel headers version problem.
I'm running YDL3.0.1 with glibc-2.3.1.

What version of glibc do you have? How does it define an
mcontext_t (struct sigcontext_struct)?

>evil@sheep:/usr/local/src/perfctr-2.6.4$ cat /proc/cpuinfo
>processor       : 0
>cpu             : 604r
>clock           : ???
>revision        : 49.2 (pvr 0009 3102)
>bogomips        : 299.00
>machine         : PReP Utah (Powerstack II Pro4000)
>l2 cache        : 512KiB, parity disabled SRAM:synchronous, pipelined,
>no parity

Nothing in dmesg?

/Mikael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
