Date: 3 Jun 2003 09:47:44 -0000
Message-ID: <20030603094744.2309.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
From: "ramanathan G A" <ramanathan_ga@rediffmail.com>
Reply-To: "ramanathan G A" <ramanathan_ga@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: compiling newlib for powerpc-linux
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
I am trying to setup an cross development environment for
powerpc-linux on i686-linux.
Built binutils 2.13.90.0.4 and GCC (cross) 3.2 and was then trying
to configure and compile newlib 1.11.0
(anything wrong with using newlib here?. Mine is an embedded
powerpc -MPC8260- target system)

Here is the screen shot.
-----------------screen shot----
[root@linuxswan newlib-powerpc]# ../newlib-1.11.0/configure
--with-newlib --target=powerpc-linux
Configuring for a i686-pc-linux-gnu host.
*** This configuration is not supported in the following
subdirectories:
      target-newlib target-libgloss
     (Any other directories should still work fine.)
Created "Makefile" in /root/anandapa/newlib-powerpc using
"mt-frag"
./config.status is unchanged
[root@linuxswan newlib-powerpc]#
--------
I think the configuration step is incomplete here in setting up an
cross dev. environment to build applications for powerpc.
(library is not getting compiled and installed with this config. I
guess. Why is it not taking directries recursively?)

I even, went on doing a  'make all install' and tried compiling a
sample application.

---------------------screen shot---
[root@linuxswan wd]# powerpc-linux-gcc -I /usr/include test.c
/usr/local/lib/gcc-lib/powerpc-linux/3.2/../../../../powerpc-linux/bin/ld:
cannot open crt1.o: No such file or directory
collect2: ld returned 1 exit status
-----------

Could some one correct me with the proper configuration steps
required?

Thanks.

Rgds,
Ramanathan G A


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
