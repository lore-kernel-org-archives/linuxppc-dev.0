Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id E430D67DF7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 11:36:45 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i25so763339wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 18:36:44 -0700 (PDT)
Message-ID: <9b7ca6570507291836ac62600@mail.gmail.com>
Date: Sat, 30 Jul 2005 10:36:44 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
In-Reply-To: <1122686376.4755.2.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca65705072918062249e41f@mail.gmail.com>
	<1122686376.4755.2.camel@yoda.jdub.homelinux.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console
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

I too have /dev/null
0 crw-rw-rw-  1 root root 1, 3 Aug 31  2001 null

However, Im not using initrd. null, and console devices are in my RAMDISK t=
ho.

On 7/30/05, Josh Boyer <jwboyer@jdub.homelinux.org> wrote:
> On Sat, 2005-07-30 at 10:06 +0900, Daniel Ann wrote:
> > Hi folks,
> >
> > Just wondering if anyone could lend a hand with this problem I have
> > with serial console. I'm trying to boot up my board (very similar to
> > sandpoint using MPC8245) with kernel 2.6.12.3, and most of it is
> > working but console will display up to,
> > [snip]
> > RAMDISK: Compressed image found at block 0
> > VFS: Mounted root (ext2 filesystem) readonly.
> > Freeing unused kernel memory: 112k init
> >
> > I've done series of printk in sys_execve() to see if /sbin/init is
> > working, and found out it went thru the whole rcS file okay. Mind you,
> > printk is successfully displaying the output on the console while I'm
> > still not getting anything from the user processes.
> >
> > Having all the kernel boot up log on console means that I've done some
> > part right. But why am I not getting anything from the user processes
> > on the console screen ?
> >
> > Is there anything I need to do on the kernel config ?
>=20
> Do you have a /dev/console device node in your initrd?  If not, that is
> one of the reasons you could be seeing that problem.  Make
> sure /dev/null is there too.
>=20
> josh
>=20
>=20


--=20
Daniel
