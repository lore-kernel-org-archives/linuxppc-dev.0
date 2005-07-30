Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by ozlabs.org (Postfix) with ESMTP id D850767D93
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 11:12:49 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i24so702664wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 18:12:48 -0700 (PDT)
Message-ID: <9b7ca65705072918062249e41f@mail.gmail.com>
Date: Sat, 30 Jul 2005 10:06:48 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Serial console
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks,

Just wondering if anyone could lend a hand with this problem I have
with serial console. I'm trying to boot up my board (very similar to
sandpoint using MPC8245) with kernel 2.6.12.3, and most of it is
working but console will display up to,
[snip]
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 112k init                                    =
   =20

I've done series of printk in sys_execve() to see if /sbin/init is
working, and found out it went thru the whole rcS file okay. Mind you,
printk is successfully displaying the output on the console while I'm
still not getting anything from the user processes.

Having all the kernel boot up log on console means that I've done some
part right. But why am I not getting anything from the user processes
on the console screen ?

Is there anything I need to do on the kernel config ?

--=20
Daniel
