Message-Id: <200007272021.WAA31472@denx.local.net>
To: Mike Coy <coym@embeddedplanet.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.3 kernels 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Jul 2000 15:01:02 EDT."
             <4.3.2.7.0.20000727145521.00ae8410@10.0.0.2>
Date: Thu, 27 Jul 2000 22:21:49 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mike,

in message <4.3.2.7.0.20000727145521.00ae8410@10.0.0.2> you wrote:
>
> I'm trying to get a 2.3 kernel working on an RPX-LITE board.  After a bunch
> of guesswork, I got it to compile.  A good number of hte things I disabled
> can probably be re-enabled now, but that isn't the problem.  It now
> compiles OK, but when I download it to the board and run it, I get no
> output whatsoever.

Do you have any indication  how  far  it  comes?  Do  you  have  kgdb
working, or a good BDM debugger (i. e. one with MMU support)?

> Has anyone successfully ran a 2.3 kernel on one of these boards?

It depends on what you mean with 2.3; it's just two days that I  have
2.4.0-test5  running  stable  on  TQM8xxL boards. This is the _first_
kernel after 2.3.18 that ever ran for me on a MPC8xx. And  even  this
is  only  when  you  fix cache problems in string.S (either by simply
replacing the file with the version from 2.2.13, or by applying Dan's
patch).

Sorry, I don't have any RPX boards here to test, but  I  have  tested
three  systems  (2  x 850 and a 860), two of them under > 24 h stress
tests (with things like compiling the linux kernel  on  the  target),
and I had not a single problem since.

In  case  you're  interested  -  I've  put  my  patches  against  the
2.4.0-test5  BitKeeper  sources on our FTP server (the "COMMON" patch
includes all I neded to change for TQM8xxL  support  to  the  current
kernel;  the "TQM" patch is probably of little interest since this is
just needed when you use the old TQ monitor instead of PPCBOOT):

ftp://ftp.denx.de/pub/LinuxPPC/usr/src/patches/COMMON-2.4.0-test5.patch.gz
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/patches/TQM-2.4.0-test5.patch.gz

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Real programmers don't comment their code. It was hard to  write,  it
should be hard to understand.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
