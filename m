Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF7063E4D@NAPA>
From: Hua Ji <hji@netscreen.com>
To: "'frowand@mvista.com'" <frowand@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: About monta-vista linux for ppc 405gp
Date: Tue, 16 Jan 2001 20:22:46 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Frank.

I already loaded the linux package. A quick question.
>From makefile, I didn't see support for 405GP, but I do see the support for
403.
Also, for 4xx, the kernel init codes is started from head_4xx.S. Am I right?

Thanks -Hua

--------------------
ifdef CONFIG_4xx
CFLAGS := $(CFLAGS) -mcpu=403
endif

ifdef CONFIG_8xx
CFLAGS := $(CFLAGS) -mcpu=860 -I../8xx_io
endif

ifdef CONFIG_PPC64BRIDGE
CFLAGS := $(CFLAGS) -Wa,-mppc64bridge
endif

ifdef CONFIG_4xx
  HEAD := arch/ppc/kernel/head_4xx.o
else
-----------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
