Message-Id: <200006281241.OAA29852@denx.local.net>
To: Steven Hanley <sjh@wibble.net>
cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problem with compressing the kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Jun 2000 21:45:20 +1000."
             <3959E550.3CC61CD@wibble.net>
Date: Wed, 28 Jun 2000 14:41:37 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3959E550.3CC61CD@wibble.net> Steven Hanley wrote:
>
> on other architectures. I still strongly suspect the person asking on a
> ppc list how to compress a kernel for linux on an NT box was somewhat
> confused at least.

No, I don't think so. He probably just wants (or has) to use NT as  a
cross  development environment for building Linux images. It's pretty
normal to do that usinf Linux boxen, but  I  guess  his  employer  is
still preferring NT installations :-(

> well if the hardware is embedded or similarly lacking in space as
> someone suggested I can understand the need, or possible x86. Otherwise
> I would be surprised if the hardware cant handle large images. There is
> a difference between "need" and "common use"

Not all things that "can" be done are practical. I _can_ compile  the
Linux  kernel  on  a  MPC860  system with 16 MB RAM running with root
filesystem over NFS. It takes well over two hours  on  that  board  -
it's  a  good  regression  test,  but it's not practical for software
development.

For some of us, embedded systems are common use.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Deliver yesterday, code today, think tomorrow."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
