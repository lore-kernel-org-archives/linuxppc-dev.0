Return-Path: <simlo@phys.au.dk>
Received: from lirs02.phys.au.dk (lirs02.phys.au.dk [130.225.28.43])
	by ozlabs.org (Postfix) with ESMTP id BE6016892B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 22:40:57 +1100 (EST)
Date: Sat, 31 Dec 2005 11:55:09 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051230081049.2C117352ADF@atlas.denx.de>
Message-ID: <Pine.LNX.4.44L0.0512311147590.7195-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: siman <siman@bsysjob.sharella.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Migrate vxworks bsp to linux 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 30 Dec 2005, Wolfgang Denk wrote:

> In message <001301c60ce8$7b4456a0$1200a8c0@xbh> you wrote:
> >
> > I have the prpmc610 borad(with MPC8245), I have the board's vxworks bsp, did
> > anybody have experience to migrate  from the vxworks to Linux system? I
> > think the main problem is initial the boards.
>
> You start porting a boot loader, like U-Boot.

To see if I could get Linux to run on our MPC5200 board I politely asked
the vxWorks bootloader to boot the Linux kernel via ftp. It worked. I used
the Denx kernel for the Lite5200. I had to compile the kernel with good
default parameters (ip address, nfsroot, serial setup etc.) as I couldn't
make the  vxWorks bootsector parse kernel parameters. It was a good and
very easy way to demonstrate that Linux could run on our board.

Esben

>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> As far as the laws of mathematics refer  to  reality,  they  are  not
> certain;  and  as  far  as  they  are  certain,  they do not refer to
> reality.                                           -- Albert Einstein
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
