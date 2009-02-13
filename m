Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f159.google.com (mail-gx0-f159.google.com
	[209.85.217.159]) by ozlabs.org (Postfix) with ESMTP id A809ADDDB0
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 05:08:08 +1100 (EST)
Received: by gxk3 with SMTP id 3so1457247gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 10:08:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001101c98dfd$ed7993e0$c86cbba0$@com>
References: <001101c98dfd$ed7993e0$c86cbba0$@com>
Date: Fri, 13 Feb 2009 11:08:06 -0700
Message-ID: <fa686aa40902131008s28d27756g8dd3d76ec3bc379f@mail.gmail.com>
Subject: Re: LINUX BOOT UP PROBLEM-PPC405 ML403
From: Grant Likely <grant.likely@secretlab.ca>
To: "Li Jun (Aaron)" <aaronleefly@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is there a /dev/ttyUL0 in your root filesystem?

On Fri, Feb 13, 2009 at 10:10 AM, Li Jun (Aaron) <aaronleefly@gmail.com> wrote:
> Hi,
>
> When I try to boot the linux on the Xilinx virtex4 fx ml403 board.
>
>
>
> The information below shows up:
>
> -----------------------------------------------------------------------------
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
> process '/sbin/getty -L ttyUL0 9600 vt100' (pid 158) exited. Scheduling it
> for r
>
> estart.
>
> starting pid 163, tty '': '/sbin/getty'
>
> process '/sbin/getty -L ttyUL0 9600 vt100' (pid 163) exited. Scheduling it
> for r
>
> estart.
>
> starting pid 168, tty '': '/sbin/getty'
>
> --------------------------------------------------------------------------------------------------
>
> I am using the uart lite 9600, and the inittab of my root file system is as
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



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
