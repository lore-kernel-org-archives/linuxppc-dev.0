Message-ID: <389E9032.A657C1F4@wanadoo.fr>
Date: Mon, 07 Feb 2000 10:28:18 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Brad Midgley <brad@turbolinux.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
References: <Pine.LNX.4.20.0002070025410.29493-100000@mail.turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley wrote:
>
> you guys are having great luck. i haven't been able to get past
>
> In file included from init/main.c:33:
> /usr/src/linux/include/linux/pci.h:318: parse error before `dma_addr_t'
> /usr/src/linux/include/linux/pci.h:318: warning: no semicolon at end of struct or union
> /usr/src/linux/include/linux/pci.h:346: parse error before `}'
>
> this is the plain common_config on an rs/6000. using gcc 2.95.2, glibc
> 2.1.3-0j.

But you *did* apply AJoshi's patch which includes the line
typedef u32 dma_addr_t;
into /include/asm-ppc/types.h and several #include <linux/types.h> at
various places, didn't you?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
