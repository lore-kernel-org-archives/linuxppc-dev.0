Message-Id: <199903251819.MAA23996@wolfram.com>
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bugs building stuff.. somewhere.. (was: back to gcc under pre-R5) 
Date: Thu, 25 Mar 1999 12:19:07 -0600
From: Brian Downing <bdowning@wolfram.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As a belated update to my own post:

I've finally gotten this to work.

"gcc -static -Wl,--relax ... -o binary" makes this link fine with
egcs-1.1.2 and glibc-2.1.  The resulting binary runs on pre-R5, R4,
and mklinux DR3.  I just wish I had a non-Mac to test it on.

-bcd
--
**               Brian Downing
**  UNIX Systems Administrator
**        bdowning@wolfram.com

On Wed, 17 Feb 1999 10:03:54 -0600, Brian Downing writes:
 > I've had similar problems building software.  I'm not sure where the
 > problem is, but I cannot compile this software statically.  I wouldn't
 > care, but for it to be useful, it must be able to run on all PPC
 > platforms.
 > 
 > When I link dynamically, everything works fine, everywhere that I've
 > built it - unfortunately binary portability is a little low.
 > 
 > When I try to link it statically, I get a bunch of ld errors from
 > libc.a about "tried to relocate __pthread_mutex_lock" and other various
 > __pthread_* calls.  No binary is generated.  I tried to compile a
 > non-reentrant version of glibc with no linuxthreads (since I'm building
 > statically and the software isn't threaded I figured it was worth a try).
 > Unfortunately glibc doesn't appear to build without linuxthreads anymore
 > - even with --disable-sanity-checks.  I've even gone so far as to ifdef
 > out the offending calls in glibc (for testing), and other similar errors
 > show up for different places in glibc.  I don't have the exact errors
 > on hand right now, but I can get them if anyone thinks they would help.

[snip]

 > (Built on a PowerBook G3 266, with linuxppc-pre-r5, with egcs-1.1.1 and
 > the latest snapshot I could build, with glibc-2.0.108 and glibc-2.1,
 > and with some other variations made for the heck of it.)

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
