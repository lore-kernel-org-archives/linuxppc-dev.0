To: "Stephen Williams" <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: rpm for embedded system 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 07 Jul 2004 15:08:06 PDT."
             <20685-04823@sneakemail.com>
Date: Thu, 08 Jul 2004 00:53:15 +0200
Message-Id: <20040707225320.7E22EC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20685-04823@sneakemail.com> you wrote:
>
> Indeed, I really only want 3 or 4 rpms (glibc, e2fsprogs, maybe
> a few others) and a few rpms of my own.
>
> It would be ideal to be able to do something like:
>
>     rpm --root=/mnt/flash --initdb
>     rpm --root=/mnt/flash -ivh glibc-common-X.ppc.rpm
>     rpm --root=/mnt/flash -ivh e2fsprogs-X.ppc.rpm
>     rpm --root=/mnt/flash -ivh my-jse-initscripts-X.ppc.rpm

You don't really want to do that. The standard RPM's include a lot of
stuff that are just a waste of resources on  the  embedded  system  -
things  like  man  pages, info pages, debug and profiling versions of
the system libraries etc. You will just waste tens and tens of  mega-
bytes in your root filesystem.

If you need package management on the target,  the  RPM  is  not  the
right  tool.  And if you really want to use RPM, then you must create
customized RPMs first.

> and so on. (As an aside, I may be wanting to allow for
> running rpm on the target device itself to update in the
> field. Getting fancy, eh?)

I think there are leaner and better ways to do this than  using  RPM.
While  technically  possible,  it  is  most  probably not the optimal
solution for your problem.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A supercomputer is a machine that runs an endless loop in 2 seconds.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
