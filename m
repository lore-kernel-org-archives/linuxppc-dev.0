To: jim <jduey@ccc-dcs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Physical memory size 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Sep 2002 12:33:02 -0000."
             <3D6E4A4A00001297@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com)
Date: Thu, 12 Sep 2002 20:53:09 +0200
Message-Id: <20020912185314.608ACFA8D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D6E4A4A00001297@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com) you wrote:
>
> Is there any way to get the kernel to report the size of physical memory that
> was passed to it from PPCBoot?

I can think of several easy ways, depending on when you want to print
this information:

* in PPCboot: use the "bdinfo" command
* In early kernel startup: add a printk() in arch/ppc/kernel/setup.c
* In the shell, enter "free", or "cat /proc/meminfo", etc.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are things that are so serious that you can  only  joke  about
them"                                                    - Heisenberg

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
