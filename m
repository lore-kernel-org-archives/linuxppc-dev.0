Message-Id: <200010180008.CAA12064@denx.local.net>
To: Yiran Duan <yiranduan@yahoo.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX kernel compile error 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Oct 2000 14:02:29 PDT."
             <20001017210229.5208.qmail@web5201.mail.yahoo.com>
Date: Wed, 18 Oct 2000 02:08:43 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Yiran,

in message <20001017210229.5208.qmail@web5201.mail.yahoo.com> you wrote:
>
> I tried to compile linux kernel for MBX board on
> i686-pc-linux. The package I used to built my
> cross-compiler is:
>
>     binutils-2.10
>     glibc-2.1.3
>     gcc-2.95
>
> The kernel package I used is
>
>     linux-2.2.17
...
> Could anyone give me any idea about where I was wrong?


You better get some working cross tools that are ready configured for
Embedded  PowerPC  systems;  there  are  some  small,  but  necessary
changes.  Check  out the MV tools, or, if you want to build the tools
from scratch, our patches and build scripts at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz
(and see also http://www.denx.de/solutions-en.html ).

Also, get a kernel version for the Embedded PPC - 2.2.17  will  *NOT*
work.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Little known fact about Middle Earth:   The Hobbits had a very sophi-
sticated computer network!   It was a Tolkien Ring...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
