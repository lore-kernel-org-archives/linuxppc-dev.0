To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can I run linux without a file system? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Jun 2002 14:31:33 MDT."
             <3.0.3.32.20020621143133.006d37a8@hollabaugh.com>
Date: Fri, 21 Jun 2002 23:06:07 +0200
Message-Id: <20020621210612.4C9C31030A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3.0.3.32.20020621143133.006d37a8@hollabaugh.com> you wrote:
>
> I can say that a minimum RedHat install uses 29,296 files – 382.020MB, debian 10,734 files - 67.428MB, my minimal root filesystem 82 files and 4.8MB.

You cannot really call this a "minimal root filesystem".

A small (not even this is minimal, nor optimized) image can be found at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/mini-2048kB-ramdisk.image.gz

This has:
	-> find .
	.
	./lost+found
	./bin
	./bin/sh
	./bin/ls
	./dev
	./dev/ttyS0
	./dev/tty
	./dev/console
	./lib
	./lib/ld.so.1
	./lib/libc-1.99.so
	./lib/libc.so.6
	./lib/libtermcap.so.2.0.8
	./lib/libtermcap.so.2
	-> du -sk .
	1367    .

Obvious optimizations: rmdir lost+found, use busybox instead of  bash
+ ls, ...


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Were there fewer fools, knaves would starve.              - Anonymous

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
