Date: Mon, 7 Feb 2000 07:46:45 -0700 (MST)
From: Dan Burcaw <dburcaw@terraplex.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
In-Reply-To: <Pine.LNX.4.20.0002070025410.29493-100000@mail.turbolinux.com>
Message-ID: <Pine.LNX.4.10.10002070746020.12286-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad,

Take a look at Ani's 2.3.42 patch. I believe it fixes this.

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

Regards,
Dan

Terra Soft Solutions, Inc.
 Yellow Dog Linux
 "The Ultimate Companion for a Dedicated Server"
 http://www.yellowdoglinux.com/

 Black Lab Linux
 Advanced Workstations and Parallel Solutions
 http://www.blacklablinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
