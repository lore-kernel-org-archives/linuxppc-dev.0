MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: sorry!Another question about flash!
Date: Thu, 6 Sep 2001 10:25:02 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459272@kolkrabbi.flaga.is>
From: =?gb2312?B?S6iicmkgRGF2qKplc3Nvbg==?= <kd@flaga.is>
To: "weiwu" <weiwu@isdn.iscas.ac.cn>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: weiwu [mailto:weiwu@isdn.iscas.ac.cn]
> Sent: 6. september 2001 10:18
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: sorry!Another question about flash!
>
>
>
> >  A character device driver is included with our sources,
> see for instance
> >ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-07-23.tar.bz2
> >
> >The standard solution is to use MTD, which is part of recent
> kernels, too.
>
> 1.who have block device driver of flash?  And can I share with you?
>  (Intel 28F320J5(4MBytes, 8bit) flash memory)

Check the mtd code. It allready supports 28F320 (16 bit 4Mb).

>
> 2.The "ftl or mtd" is only for PCMCIA?

No. Check the mtd code. It can work with PCMCIA and ftl but they are not
necessary.

> Can we use it in the general flash board ?such as ppc mother board!

I am using the mtd for 28F320 for a homegrown board, no pcmcia, no ftl.
Check the FLAGADM configuration in mtd.

K.D.

>
>
> I need help!Thank you very much!
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
