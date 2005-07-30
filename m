Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-69-68.roch.qwest.net [67.41.69.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FE0F67DEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 11:19:39 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Daniel Ann <ktdann@gmail.com>
In-Reply-To: <9b7ca65705072918062249e41f@mail.gmail.com>
References: <9b7ca65705072918062249e41f@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 20:19:36 -0500
Message-Id: <1122686376.4755.2.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 2005-07-30 at 10:06 +0900, Daniel Ann wrote:
> Hi folks,
> 
> Just wondering if anyone could lend a hand with this problem I have
> with serial console. I'm trying to boot up my board (very similar to
> sandpoint using MPC8245) with kernel 2.6.12.3, and most of it is
> working but console will display up to,
> [snip]
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 112k init                                        
> 
> I've done series of printk in sys_execve() to see if /sbin/init is
> working, and found out it went thru the whole rcS file okay. Mind you,
> printk is successfully displaying the output on the console while I'm
> still not getting anything from the user processes.
> 
> Having all the kernel boot up log on console means that I've done some
> part right. But why am I not getting anything from the user processes
> on the console screen ?
> 
> Is there anything I need to do on the kernel config ?

Do you have a /dev/console device node in your initrd?  If not, that is
one of the reasons you could be seeing that problem.  Make
sure /dev/null is there too.

josh
