Message-ID: <3842A611.EDEF0E4E@plutonium.net>
Date: Mon, 29 Nov 1999 11:13:05 -0500
From: "Steven J. Hill" <sjhill@plutonium.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Building PPC cross compiling environment...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings.

I am attempting to build a cross compiling environment for PPC under
my RH 6.1 Linux system. I am new at this, however, I looked through
the mailing list archives, DejaNews, and a few other FAQs and was
unable to find anything on this. This my first attempt at this, I
beg for your patience. Please reply to me personally as I am not
subscribed to the list currently. Thanks.

-Steve

***********************************

configure --prefix=/usr --host=i386-linux-gnu --target=powerpc-linux

Created "Makefile" in /tmp/binutils-2.9.1.0.19a using "mt-frag"
collect2: ld returned 33 exit status
*** The command '/usr/bin/gcc -o conftest -g -O2   conftest.c' failed.
*** You must set the environment variable CC to a working compiler.

***********************************

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
