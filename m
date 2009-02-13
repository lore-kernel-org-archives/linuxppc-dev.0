Return-Path: <aaronleefly@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by ozlabs.org (Postfix) with ESMTP id 18E2CDDDAC
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 05:56:42 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id j2so1077788tid.13
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 10:56:41 -0800 (PST)
From: "Li Jun (Aaron)" <aaronleefly@gmail.com>
To: "'Grant Likely'" <grant.likely@secretlab.ca>
References: <001101c98dfd$ed7993e0$c86cbba0$@com>
	<fa686aa40902131008s28d27756g8dd3d76ec3bc379f@mail.gmail.com>
In-Reply-To: <fa686aa40902131008s28d27756g8dd3d76ec3bc379f@mail.gmail.com>
Subject: RE: LINUX BOOT UP PROBLEM-PPC405 ML403
Date: Sat, 14 Feb 2009 02:56:37 +0800
Message-ID: <002301c98e0c$cda73950$68f5abf0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

I can not find the /dev/ttyUL0 in my root filesystem.
Is that the problem? What should I do? Just make a node, like : mknod
/dev/ttyUL0?
I am not familiar with the root filesystem.
Thanks!

Best regards,
Li Jun

-----Original Message-----
From: Grant Likely [mailto:grant.likely@secretlab.ca]=20
Sent: 2009=C4=EA2=D4=C214=C8=D5 2:08
To: Li Jun (Aaron)
Cc: linuxppc-dev@ozlabs.org
Subject: Re: LINUX BOOT UP PROBLEM-PPC405 ML403

Is there a /dev/ttyUL0 in your root filesystem?

On Fri, Feb 13, 2009 at 10:10 AM, Li Jun (Aaron) <aaronleefly@gmail.com>
wrote:
> Hi,
>
> When I try to boot the linux on the Xilinx virtex4 fx ml403 board.
>
>
>
> The information below shows up:
>
>
-------------------------------------------------------------------------=
---
-
>
> Welcome to ML403 Linux 2.6
>
>
>
> Starting system...
>
> mounting /proc: done.
>
> Mounting '/' read-write: done.
>
> brining up loopback interface: done.
>
> Mounting /tmp: done.
>
> Starting syslogd: done.
>
> Starting klogd: done.
>
> Starting inetd: done.
>
> System started.
>
> starting pid 158, tty '': '/sbin/getty'
>
> process '/sbin/getty -L ttyUL0 9600 vt100' (pid 158) exited. =
Scheduling it
> for r
>
> estart.
>
> starting pid 163, tty '': '/sbin/getty'
>
> process '/sbin/getty -L ttyUL0 9600 vt100' (pid 163) exited. =
Scheduling it
> for r
>
> estart.
>
> starting pid 168, tty '': '/sbin/getty'
>
>
-------------------------------------------------------------------------=
---
----------------------
>
> I am using the uart lite 9600, and the inittab of my root file system =
is
as
> below:
>
> ::sysinit:/etc/init.d/rcS
>
> #::askfirst:-/bin/sh
>
> ::ctrlaltdel:/sbin/reboot
>
> ::shutdown:/sbin/swapoff -a
>
> ::shutdown:/bin/umount -a -r
>
> ::restart:/sbin/init
>
> ::respawn:/sbin/getty -L ttyUL0 9600 vt100
>
>
>
> Anybody can help?
>
>
>
> Thanks!
>
>
>
> Best regards,
>
> Li Jun
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
