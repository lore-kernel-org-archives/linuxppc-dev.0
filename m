Return-Path: <scop@digitel.com.br>
Received: from phoenix.digitel.com.br (unknown [200.198.105.46])
	by ozlabs.org (Postfix) with ESMTP id F28D667DF7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 11:32:02 +1000 (EST)
Received: from [10.10.10.4] by phoenix.digitel.com.br (GMS
	10.03.3304/NU1492.00.9fae9071) with ESMTP id menlqbaa for
	linuxppc-embedded@ozlabs.org; Fri, 29 Jul 2005 22:19:26 -0300
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Daniel Ann <ktdann@gmail.com>,
 linuxppc-embedded@ozlabs.org
Date: Fri, 29 Jul 2005 22:27:45 -0300
References: <9b7ca65705072918062249e41f@mail.gmail.com>
In-Reply-To: <9b7ca65705072918062249e41f@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200507292227.45626.scop@digitel.com.br>
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

Hi Daniel,

On Friday 29 July 2005 22:06, Daniel Ann wrote:
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
Please verify that you have a /dev/console in your rootfs, and that it's =
being=20
correctly acessed by the init process.

HTH,

--=20
Ricardo Scop.

        \|/
    ___ -*-
   (@ @)/|\
  /  V  \|  R SCOP Consult.
 /(     )\  Linux-based communications
--^^---^^+------------------------------
rscop@matrix.com.br
+55 51 999-36-777
Porto Alegre, RS - BRazil
