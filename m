Message-ID: <20030709010622.15390.qmail@kunk.qbjnet.com>
Subject: Making 2.5 kernels
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 8 Jul 2003 20:06:22 -0500 (CDT)
From: Robert E Brose II <bob@kunk.qbjnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to compile the most revent bitkeeper 2.5 kernel and am getting
this:
.
.
.
make -f scripts/Makefile.build obj=drivers/net
  gcc -Wp,-MD,drivers/net/.loopback.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=loopback -DKBUILD_MODNAME=loopback -c -o drivers/net/.tmp_loopback.o drivers/net/loopback.c
In file included from include/net/ip.h:33,
                 from include/net/checksum.h:31,
                 from drivers/net/loopback.c:52:
include/net/route.h:24: features.h: No such file or directory
include/net/route.h:25: sys/socket.h: No such file or directory
include/net/route.h:26: sys/types.h: No such file or directory
include/net/route.h:27: netinet/in.h: No such file or directory
include/net/route.h:100: warning: `RTCF_NAT' redefined
include/linux/in_route.h:28: warning: this is the location of the previous definition
include/net/route.h:114: warning: `RT_TOS' redefined
include/linux/in_route.h:30: warning: this is the location of the previous definition
In file included from include/net/ip.h:33,
                 from include/net/checksum.h:31,
                 from drivers/net/loopback.c:52:
include/net/route.h:55: field `rtmsg_dst' has incomplete type
include/net/route.h:56: field `rtmsg_src' has incomplete type
include/net/route.h:57: field `rtmsg_gateway' has incomplete type
make[2]: *** [drivers/net/loopback.o] Error 1

I get an error at the same place in the 2.5.74 kernel on an i386
box.

Did look around but the problem is not obvious to me.
The includes that are "missing" are in the /usr/include.... tree.
Can anyone give me some pointers? I did do a make mrproper as a
matter of course.

Thanks,
Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
