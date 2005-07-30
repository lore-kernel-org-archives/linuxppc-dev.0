Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.197])
	by ozlabs.org (Postfix) with ESMTP id 514C367E09
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 11:34:24 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i24so707534wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 18:34:23 -0700 (PDT)
Message-ID: <9b7ca657050729183410394f8d@mail.gmail.com>
Date: Sat, 30 Jul 2005 10:34:23 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Ricardo Scop <scop@digitel.com.br>
In-Reply-To: <200507292227.45626.scop@digitel.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca65705072918062249e41f@mail.gmail.com>
	<200507292227.45626.scop@digitel.com.br>
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

Looks like I have /dev/console
0 crw-------  1 root root 5, 1 Sep 26  2002 console
0 crw-rw-rw-  1 root root 4, 64 Jun 17  2004 ttyS0

I havent yet figured out how I should go about seeing if init is
correctly accessing it tho. Let me take a look at busybox init part.
BTW, any more reasons why this problem might exist ?



On 7/30/05, Ricardo Scop <scop@digitel.com.br> wrote:
> Hi Daniel,
>=20
> On Friday 29 July 2005 22:06, Daniel Ann wrote:
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
> Please verify that you have a /dev/console in your rootfs, and that it's =
being
> correctly acessed by the init process.
>=20
> HTH,
>=20
> --
> Ricardo Scop.
>=20
>        \|/
>    ___ -*-
>   (@ @)/|\
>  /  V  \|  R SCOP Consult.
>  /(     )\  Linux-based communications
> --^^---^^+------------------------------
> rscop@matrix.com.br
> +55 51 999-36-777
> Porto Alegre, RS - BRazil
>=20
>=20


--=20
Daniel
