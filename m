To: srinivas pulipati <srinivasp@multitech.co.in>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel panic: Attempted to kill init! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Dec 2001 18:38:44 +0530."
             <3C23345C.1274D300@multitech.co.in>
Date: Wed, 26 Dec 2001 20:39:23 +0100
Message-Id: <20011226193928.E329210E25@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C23345C.1274D300@multitech.co.in> you wrote:
>
> i downloaded pre built ramdisk.image.gz from
> ftp://ftp.denx.de/pub/LinuxPPC/usr/src/simple-ramdisk.image.gz
>
> i put a printk in fs/opennamei () function
> i end up with the following output.
>
> is it crashing because of library missing or something else?

Yes ;-)

Well, I think I should be a bit more helpful: something else is missing.

...
> Kernel panic: Attempted to kill init!

If you check the contents of tha ramdisk image (simply uncompress  it
and mount it using the loopback device) you will see that there is no
"init" included.

Try passing a "init=/bin/sh" argument on the kernel commandline.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The speed of time is one second per second.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
