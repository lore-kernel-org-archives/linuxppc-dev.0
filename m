Message-Id: <200002051337.IAA03125@fermi.cmf.nrl.navy.mil>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
In-reply-to: Your message of "Fri, 04 Feb 2000 23:26:03 CST."
             <Pine.LNX.3.96.1000204232520.15802L-100000@mandrakesoft.mandrakesoft.com>
Date: Sat, 05 Feb 2000 08:37:37 -0500
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.3.96.1000204232520.15802L-100000@mandrakesoft.mandrakesoft
.com>,Jeff Garzik writes:
>This patch is wrong.  I fixed nvram to use initcalls.
>If nvram doesn't load you have other problems.

i think is see what you are saying, look at this:

./drivers/char/nvram.c:static int __init nvram_init(void)
./drivers/char/nvram.c:module_init(nvram_init);
./drivers/macintosh/nvram.c:int nvram_init(void)
./drivers/macintosh/nvram.c:        return( nvram_init() );

i guess the nvram_init() in macintosh/nvram.c needs the __init declaration
then?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
