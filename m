Date: Thu, 13 Mar 2003 12:4:47 +0800
From: "hn" <hnmem@163.com>
Reply-To: hnmem@163.com
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: uClibc on ppclinux
Mime-Version: 1.0
Content-Type: text/plain
Message-Id: <20030313040634.BF78D1CC8AC31@sm181.163.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,all,
     I am building for a ppc860 target using uClibc-0.9.19/gcc-3.2.2/busybox-0.60.5 and has built the compiler wrapper powerpc-uclibc-xxx toolchain.
if busybox built using uClibc shared libraries, kernel could not start init and panic:(
Now it runs well when I build Busybox statically linked against uClibc.
But the problem persists:(
e.g. the following message comes every time I run a application:
	symbol '__mcount_internal' is type R_PPC_REL24
        Compile shared libraries with -fPIC!
The application may continue for I commented the line in uClibc/ldso/ldso/powerpc/elfxxx.c: exit(1):)
Thanks.
Best Regards.
			hn

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
