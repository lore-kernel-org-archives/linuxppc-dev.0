Message-ID: <3A65FAA9.1BDA54EE@mvista.com>
Date: Wed, 17 Jan 2001 12:03:53 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Hua Ji <hji@netscreen.com>
CC: "'frowand@mvista.com'" <frowand@mvista.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: About monta-vista linux for ppc 405gp
References: <A33AEFDC2EC0D411851900D0B73EBEF7063E4D@NAPA>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hua Ji wrote:
>
> Thanks Frank.
>
> I already loaded the linux package. A quick question.
> From makefile, I didn't see support for 405GP, but I do see the support for
> 403.

-mcpu=403 is correct for the 405.  That may eventually change with a newer compiler.


> Also, for 4xx, the kernel init codes is started from head_4xx.S. Am I right?

Yes, that is correct.


> Thanks -Hua
>
> --------------------
> ifdef CONFIG_4xx
> CFLAGS := $(CFLAGS) -mcpu=403
> endif
>
> ifdef CONFIG_8xx
> CFLAGS := $(CFLAGS) -mcpu=860 -I../8xx_io
> endif
>
> ifdef CONFIG_PPC64BRIDGE
> CFLAGS := $(CFLAGS) -Wa,-mppc64bridge
> endif
>
> ifdef CONFIG_4xx
>   HEAD := arch/ppc/kernel/head_4xx.o
> else
> -----------------------

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
