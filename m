Return-Path: <fabien.fb@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id C6EE5DDE33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 21:56:25 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so3255358nfd
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 02:56:24 -0800 (PST)
Message-ID: <f8f856500711230256j5f3c7b9fneb7351a4fdfdfe09@mail.gmail.com>
Date: Fri, 23 Nov 2007 11:56:23 +0100
From: fabien <fabien.fb@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: cant' compile busybox-1.8.1 with eldk 4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I try to compile busybox for my ppc custom  board. I successfuly
compile kernel 2.6.19 with
eldk and boot it. Now i try to get busybox working but i get some
errors at compile time.
It's look strange if someone can spend one minute to look at the compile log
What step could i miss ?
Thank a lot

[fabien@localhost busybox-1.8.1]  cat /opt/eldk/version
ELDK version 4.1
ppc_8xx: Build 2007-01-21-uclibc

[fabien@localhost busybox-1.8.1]$ make CROSS_COMPILE=ppc_8xx-
 CC      applets/applets.o
In file included from /opt/eldk/usr/../ppc_8xx/usr/include/netinet/in.h:212,
                from /opt/eldk/usr/../ppc_8xx/usr/include/arpa/inet.h:23,
                from include/platform.h:139,
                from include/libbb.h:13,
                from include/busybox.h:10,
                from applets/applets.c:11:
/opt/eldk/usr/../ppc_8xx/usr/include/bits/socket.h:305:24: error:
asm/socket.h: No such file or directory
In file included from /opt/eldk/usr/../ppc_8xx/usr/include/sys/ioctl.h:27,
                from /opt/eldk/usr/../ppc_8xx/usr/include/sys/mount.h:26,
                from include/platform.h:305,
                from include/libbb.h:13,
                from include/busybox.h:10,
                from applets/applets.c:11:
/opt/eldk/usr/../ppc_8xx/usr/include/bits/ioctls.h:24:24: error:
asm/ioctls.h: No such file or directory
In file included from /opt/eldk/usr/../ppc_8xx/usr/include/signal.h:309,
                from include/libbb.h:23,
                from include/busybox.h:10,
                from applets/applets.c:11:
/opt/eldk/usr/../ppc_8xx/usr/include/bits/sigcontext.h:28:29: error:
asm/sigcontext.h: No such file or directory
In file included from /opt/eldk/usr/../ppc_8xx/usr/include/ucontext.h:25,
                from /opt/eldk/usr/../ppc_8xx/usr/include/signal.h:326,
                from include/libbb.h:23,
                from include/busybox.h:10,
                from applets/applets.c:11:
/opt/eldk/usr/../ppc_8xx/usr/include/sys/ucontext.h:37: error: field
'uc_mcontext' has incomplete type
In file included from /opt/eldk/usr/../ppc_8xx/usr/include/sys/param.h:24,
                from include/libbb.h:67,
                from include/busybox.h:10,
                from applets/applets.c:11:
/opt/eldk/usr/../ppc_8xx/usr/include/linux/param.h:4:23: error:
asm/param.h: No such file or directory
make[1]: *** [applets/applets.o] Erreur 1
make: *** [applets] Erreur 2
