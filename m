From: oliver.amft@ch.abb.com
To: Mark Hatle <fray@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Message-ID: <41256927.0038C99E.00@mail1.ch.abb.com>
Date: Tue, 25 Jul 2000 11:23:14 +0200
Subject: Re: GLibC cross compile for ppc-linux
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mark, hi all,

sorry for the delay!
In between i've managed to get arround this: "isomac" checks the header files
and can't find an #include <{asm,linux}/errno.h> within the errno.h it is
checking. So, two links to the linux include dir (asm,linux) will help, since
the configure switch "--with-headers=$linux-dir/include" doesn't work at this
point.

Oliver




|---------->
|          |
|          |
|---------->
  >------------------------------------------------------------------------|
  |Mark Hatle <fray@mvista.com>                                            |
  |2000-07-17 19:00                                                        |
  >------------------------------------------------------------------------|



I've been cross-compiling glibc-2.1.3 for ppc 7xx and 8xx for a while
now.  I've yet to see any problems like that.  What if your host OS,
(i.e. RedHat, debian etc? and it's version.)  And what are you
targeting?

--Mark

oliver.amft@ch.abb.com wrote:
>
> Hi all,
>
> i'm trying to build the glibc 2.1.3 on a i686-linux machine for a
powerpc-linux
> embedded target. The make command works fine (...no errors) but somehow "make
> check" stops in the "stdlib tests" part when it is invoking the "isomac"
command
> for the first time (after compiling it):
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
