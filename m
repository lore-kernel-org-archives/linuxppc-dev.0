To: David Updegraff <dave@cray.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: abatron and kernel modules. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 25 Jul 2002 12:13:37 CDT."
             <200207251713.MAA00232@mint.mw.cray.com>
Date: Thu, 25 Jul 2002 21:53:16 +0200
Message-Id: <20020725195321.3A96410875@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <200207251713.MAA00232@mint.mw.cray.com> you wrote:
>
> We've been very happily using BDI2000 for kernel debugging on our 405GP
> on a 2.4.2 kernel with builtin abatron MMU support (via PTBASE at 0xf0).

There have been some changes in the way how the Linux kernel and  the
BDI2000  exchange  information  about the MMU state; I'd recommend to
use a more recent kernel (linuxppc_2_4_devel) with the latest version
of the Abatron firmware (afaik 1.08 for 4xx)

> But I have not figured out how to get it deal with the address space of
> a loaded kernel module: it claims that the region is missing from the
> page tables.  Kernel addresses are in 0xC00xxxxx ranges, and when we load
> the module, 'module_list' now points to 0xC340xxxx ranges.  BDI can
> dump the physical addresses of my module, but cant talk to the virual
> kernel address space of the loaded module.

We have a bit of documentation about this at
http://www.denx.de/doc/TQM8xxL/debugging.html#DEBUGGING-LINUX-KERNEL

Hope it helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A person who is more than casually interested in computers should  be
well  schooled in machine language, since it is a fundamental part of
a computer.                                           -- Donald Knuth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
