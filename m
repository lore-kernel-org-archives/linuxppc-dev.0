Subject: Re: 2.6.0-test2-bk2 (Linus' tree) -- arch/ppc/kernel/setup.c:587:
	error: invalid use of undefined type `struct cpu'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308031020.20592.miles.lane@comcast.net>
References: <200308031020.20592.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1059931739.3524.145.camel@gaston>
Mime-Version: 1.0
Date: 03 Aug 2003 19:29:00 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-03 at 19:20, Miles Lane wrote:
>   CC      arch/ppc/kernel/setup.o
> arch/ppc/kernel/setup.c: In function `ppc_init':
> arch/ppc/kernel/setup.c:587: warning: implicit declaration of function
> `register_cpu'
> arch/ppc/kernel/setup.c:587: error: invalid use of undefined type `struct cpu'
> include/asm/pmac_feature.h: At top level:
> arch/ppc/kernel/setup.c:575: error: storage size of `cpu_devices' isn't known
> make[1]: *** [arch/ppc/kernel/setup.o] Error 1

Check if it's missing #include <linux/cpu.h>

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
