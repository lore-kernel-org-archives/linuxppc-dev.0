Message-ID: <20021118122042.74002.qmail@web8001.mail.in.yahoo.com>
Date: Mon, 18 Nov 2002 04:20:42 -0800 (PST)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: glibc 2.2.2  error 
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I am setting up glibc for powerpc target but It gives
me errors ..
I have set the options
CC=powerpc-linux-gcc
./configure --build=powerpc-linux \
> --enable-add-ons=linuxthreads \
> --with-headers=/usr/local/powerpc-linux/include

But when u compile  it is not able to find the headers
there ...
it gives these errors ...
so can anyone specify the right options to configure
glibc.


In file included from ../posix/bits/posix1_lim.h:126,
                 from :1:
../linuxthreads/sysdeps/unix/sysv/linux/bits/local_lim.h:36:26:
linux/limits.h: No such file or directory
make[1]: *** [../bits/stdio_lim.st] Error 1
make[1]: Leaving directory `/usr/src/glibc-2.2.2/csu'
make: *** [csu/subdir_lib] Error 2


thankyou!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
