To: "yah" <hay8888@21cn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: not found init 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Sep 2001 15:41:09 +0800."
             <ZD989095845890.21633@webmail1.inner-21cn.com>
Date: Tue, 04 Sep 2001 10:21:03 +0200
Message-Id: <20010904082108.6AD4610CC2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <ZD989095845890.21633@webmail1.inner-21cn.com> you wrote:
>
> Hi. I use linuxppc_2_4 from penguinppc.org. I rebuild the
> kernel,and use it to boot my board(mcp750).It said 'Kernel panic: No
> init found. Try passing init= option to kernel'.I didn't find the
> item about CONFIG_SASH and CONFIG_SASH_PATH. /dev/console and

These are no config options of the standard  Linux  kernel;  you  can
find these extensions in the source trees on our FTP server, but they
were  never  generally  accepted  because you can do more or less the
same by specitying an "init=" boot option.

> /bin/init exist. and I didn't cut out the lib. I use 'root=/dev/ram0'
> in kernel command line. What's wrong? Could you give me some advice?

Not with the little information you provide. Try running a statically
linked shell instead of init. For instance,  add  /bin/sash  to  your
ramdisk  image,  and  pass  "init=/bin/sash"  as boot argument to the
Linux kernel.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When the bosses talk about improving  productivity,  they  are  never
talking about themselves.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
