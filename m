From: Miles Lane <miles.lane@comcast.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.0-test2-bk2 (Linus' tree) -- arch/ppc/kernel/setup.c:587: error: invalid use of undefined type `struct cpu'
Date: Sun, 3 Aug 2003 10:53:16 -0700
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308031020.20592.miles.lane@comcast.net> <1059931739.3524.145.camel@gaston>
In-Reply-To: <1059931739.3524.145.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308031053.16110.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun August 3 2003 10:29 am, Benjamin Herrenschmidt wrote:
> On Sun, 2003-08-03 at 19:20, Miles Lane wrote:
> >   CC      arch/ppc/kernel/setup.o
> > arch/ppc/kernel/setup.c: In function `ppc_init':
> > arch/ppc/kernel/setup.c:587: warning: implicit declaration of function
> > `register_cpu'
> > arch/ppc/kernel/setup.c:587: error: invalid use of undefined type `struct
> > cpu' include/asm/pmac_feature.h: At top level:
> > arch/ppc/kernel/setup.c:575: error: storage size of `cpu_devices' isn't
> > known make[1]: *** [arch/ppc/kernel/setup.o] Error 1
>
> Check if it's missing #include <linux/cpu.h>

Yep, it is.  I am recompiling now, with it included.

Thanks!
	Miles


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
