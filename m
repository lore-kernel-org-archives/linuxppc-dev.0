Date: Mon, 7 Feb 2000 00:29:02 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: Chas Williams <chas@cmf.nrl.navy.mil>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
In-Reply-To: <200002052004.PAA03426@fermi.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.20.0002070025410.29493-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


you guys are having great luck. i haven't been able to get past

In file included from init/main.c:33:
/usr/src/linux/include/linux/pci.h:318: parse error before `dma_addr_t'
/usr/src/linux/include/linux/pci.h:318: warning: no semicolon at end of struct or union
/usr/src/linux/include/linux/pci.h:346: parse error before `}'

this is the plain common_config on an rs/6000. using gcc 2.95.2, glibc
2.1.3-0j.

Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
