Mime-Version: 1.0
Message-Id: <p06010202bbdad56b46c0@[192.168.0.254]>
Date: Fri, 14 Nov 2003 17:28:56 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: powerpc-linux-ar not found?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is probably a newbie question... I'm trying to compile a
toolchain according to the directions at

http://penguinppc.org/embedded/cross-compiling/

I'm compiling on a Pentium box running 2.4.18 and gcc 2.96 from a
Redhat 7.3 install.

binutils-2.14.90.0.7 makes OK (it looked like the latest version). I
got gcc 3.3.2 and when trying to build the bootstrap I error out:

make[2] powerpc-linux-ar: Command not found
make[2] *** [libgcc.a] Error 127
make[2] Leaving directory ... blah blah blah
make[1] *** [stmp-multilib] Error 2

However, binutils appears to have built powerpc-linux-ar just fine. I
note in the command line buffer above the error that I see a 'rm -f
libgcc.a' and then -after- that the powerpc-linux-ar command is
invoked, leading to the error.

Any thoughts?

(FWIW, I also discovered I was running out of disk space along the
way of this build - but I have fixed that and still get this error;
however, I am curious: is 470Meg free enough to build the toolchain?
I've seen mozilla for example take up an unbelievable amount of disk
space on a build).


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
