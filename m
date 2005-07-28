Return-Path: <simlo@phys.au.dk>
Received: from lirs02.phys.au.dk (lirs02.phys.au.dk [130.225.28.43])
	by ozlabs.org (Postfix) with ESMTP id EFC3F67D8E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 18:47:36 +1000 (EST)
Date: Thu, 28 Jul 2005 09:47:26 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Frank <frannk_m1@yahoo.com>
In-Reply-To: <20050728042840.36296.qmail@web32203.mail.mud.yahoo.com>
Message-Id: <Pine.OSF.4.05.10507280943410.17491-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn>,
	linuxppc-embedded@ozlabs.org
Subject: Re: How to load a linux kernel under vxworks bootloader (PPC860
 board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 27 Jul 2005, Frank wrote:

> 
> 
> --- FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn> wrote:
> 
> > Dear All:
> >   I want to boot a linux 2.4.25 kernel under vxworks
> > bootloader. When I using flat mode(0x200000 -->  0x10000)
> > kernel  uncompressed ELF format ( vmlinux ),
> >  and download it using TFTP of vxworks, it print the "starting
> > at 0x1000 ...." and  freeze.  No input or output on serial
> > port.
> >  The version of vxworks is 5.3.1. 
> >  can you give me some detail advice or give me a tool to slove
> > it? thanks !

I have done it on a MPC5200 with a vxWorks 5.5 bootsector with ethernet
support: I just boot over FTP.  Give it the Linux kernel in elf-format, 
the bootsector doesn't care, _what_ the code actually is, it just loads
and run it. 

For vxWorks <= 5.4 I believe coff is used instead of elf - at least on
some architectures. Then you have a problem, because the kernel isn't
compiled to coff :-(

Esben


> 
> Do what I did:
> Replace the vxWorks rom with you u-boot and you can boot Linux
> or vxWorks with the same bootloader.
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
