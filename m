Return-Path: <pochini@shiny.it>
Received: from vsmtp3alice.tin.it (vsmtp3alice.tin.it [212.216.176.143])
	by ozlabs.org (Postfix) with ESMTP id 42A6268698
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 07:10:22 +1100 (EST)
Received: from Jay (82.56.61.137) by vsmtp3alice.tin.it (7.2.060.1)
	id 436F7ADE0000FF4D for linuxppc-dev@ozlabs.org;
	Mon, 7 Nov 2005 21:10:16 +0100
Date: Mon, 7 Nov 2005 20:10:11 +0000
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Message-Id: <20051107201011.3b1e4db4.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Linux 2.6.14 and ALSA
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



I know there is a big ppc32-ppc64 merge in progress. Anyway, with Linux
2.6.14 alsa-driver doesn't compile anymore. The configure script cannot
compile many of its mini test programs because it cannot find the following
headers. This is not a bug report. This is just a (incomplete?) list of
files that have still to be moved in order to make alsa compile. I hope it
helps.


/usr/src/linux//include/asm/delay.h:5:23: asm/param.h: No such file or directory
/usr/src/linux//include/asm/machdep.h:9:23: asm/setup.h: No such file or directory
/usr/src/linux//include/linux/errno.h:4:23: asm/errno.h: No such file or directory
/usr/src/linux//include/linux/fcntl.h:4:23: asm/fcntl.h: No such file or directory
/usr/src/linux//include/linux/ioctl.h:4:23: asm/ioctl.h: No such file or directory
/usr/src/linux//include/linux/jiffies.h:9:23: asm/div64.h: No such file or directory
/usr/src/linux//include/linux/linkage.h:5:25: asm/linkage.h: No such file or directory
/usr/src/linux//include/linux/module.h:21:23: asm/local.h: No such file or directory
/usr/src/linux//include/linux/module.h:23:24: asm/module.h: No such file or directory
/usr/src/linux//include/linux/percpu.h:7:24: asm/percpu.h: No such file or directory
/usr/src/linux//include/linux/resource.h:68:26: asm/resource.h: No such file or directory
/usr/src/linux//include/linux/sched.h:24:25: asm/cputime.h: No such file or directory
/usr/src/linux//include/linux/sched.h:4:36: asm/param.h: No such file or directory
/usr/src/linux//include/linux/sem.h:36:24: asm/sembuf.h: No such file or directory
/usr/src/linux//include/linux/signal.h:7:25: asm/siginfo.h: No such file or directory
/usr/src/linux//include/linux/string.h:24:24: asm/string.h: No such file or directory
/usr/src/linux//include/linux/termios.h:5:25: asm/termios.h: No such file or directory
/usr/src/linux//include/linux/timex.h:60:23: asm/param.h: No such file or directory
/usr/src/linux//include/linux/timex.h:61:23: asm/timex.h: No such file or directory
/usr/src/linux//include/linux/topology.h:34:26: asm/topology.h: No such file or directory

The whole config.log is here: http://www.webalice.it/g_pochini/config.log


--
Giuliano.
