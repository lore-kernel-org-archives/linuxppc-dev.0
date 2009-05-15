Return-Path: <vijay.t.nikam@gmail.com>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id C599FDE098
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 21:51:23 +1000 (EST)
Received: by gxk20 with SMTP id 20so3624158gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 04:51:22 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 May 2009 17:21:21 +0530
Message-ID: <f234e2140905150451r734dc0b4hb6771060c495aca3@mail.gmail.com>
Subject: kernel module compilation error
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=windows-1252
Cc: Scott Wood <scottwood@freescale.com>, Ron Madrid <ron_madrid@sbcglobal.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,

I upgraded the Linux kernel version from 2.6.20 to 2.6.23 on eval
board mpc8313erdb. Then I wrote a simple hello_world kernel module for
testing but when I do make it gives following compilation error.
Whereas I did not had this problem with kernel 2.6.20 !!!

It says; 'include/asm/current.h:35: error: invalid register name for =91cur=
rent=92'

Following is complete error log

################################
make -C /usr/local/mpc8313/linux-2.6.23 M=3D/opt/test/module/hello_world mo=
dules
make[1]: Entering directory `/usr/local/mpc8313/linux-2.6.23'
CC [M] /opt/test/module/hello_world/hello.o
In file included from include/linux/capability.h:48,
from include/linux/sched.h:50,
from include/asm/elf.h:6,
from include/linux/elf.h:8,
from include/linux/module.h:15,
from /opt/test/module/hello_world/hello.c:5:
include/asm/current.h:35: error: invalid register name for =91current=92
make[2]: *** [/opt/test/module/hello_world/hello.o] Error 1
make[1]: *** [_module_/opt/test/module/hello_world] Error 2
make[1]: Leaving directory `/usr/local/mpc8313/linux-2.6.23'
make: *** [all] Error 2
############################################

Could anyone please let me know the way to proceed or a way to think
to resolve this issue ? ? ?

Kindly please acknowledge ... thank you.

Kind Regards,
Vijay Nikam
