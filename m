Message-ID: <38EF05F9.B7417C7D@iiic.ethz.ch>
Date: Sat, 08 Apr 2000 12:12:09 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Michael A. Peters" <mpeters@mac.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Building X 3.3.6 (non-distributor environment)
References: <v04220801b513d68f9145@[192.168.0.2]>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Michael A. Peters" wrote:
>
> I'm running the Linux From Scratch project
> (http://www.linuxfromscratch.org) and its all working swell except X
> won't build.
>
> When I unpack X3.3.6 and try "make World" it very quickly quits with
> an error from gcc. Funny thing is, the build *does* complete under
> LinuxPPC (gcc 2.95.2, glibc 2.1.3 if it matters) from the same source.
>
> Opinion among people who have used the LFS howto on x86 and also
> built X on other platforms is that my problem is that the make World
> script doesn't know my compiler is gcc. Yes, I do have cc symlinked
> to gcc
>
> I've even tried make CC=gcc World with same result.
>
> However, under LinuxPPC it compiles no problem.
>
> Any of you know what the problem is (if its something else) or how to
> set up the non-distribution linux so that it DOES know the compiler
> is gcc?

In xc/config/cf there's a bunch of config files, the important ones for you
are probably xf86site.cf and linux.cf.

Set everything concerning Gcc (and maybe other stuff as well) to reflect your
system and you should be fine.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
