Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 30 Apr 2002 10:40:35 +0200
From: Gunnar Larisch <la@softing.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Dross Zhou <zjuzhou@yahoo.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to mount romfs in flash as root filesystem?
Message-ID: <20020430104035.A28417@w-la.dhcp.softing.com>
References: <20020429141408.33240.qmail@web15001.mail.bjs.yahoo.com> <20020429143529.A188FFF68@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020429143529.A188FFF68@denx.denx.de>; from Wolfgang Denk on Mon, Apr 29, 2002 at 04:35:24PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Apr 29, 2002 at 04:35:24PM +0200, Wolfgang Denk wrote:
>
> In message <20020429141408.33240.qmail@web15001.mail.bjs.yahoo.com> you wrote:
> >
> > 	Now my kernel has support ROMFS ,i can mount
> > /dev/mtdblock0 /mnt -t romfs and use chroot /mnt as
> > root filesystem.But i want to mount /dev/mtdblock0 as
> > root filesystem when system reboot,how to?I have try
> > many parameters into kernel such as "root=/dev/mtdblk0
> > romfs ro", but it is no use, it also mount NFS
>
> Probably because you mistyoed  the  device  name?  There  is  an  'o'
> missing, it seems.
>
> > root,how can i mount /dev/mtdblock0 (ROMFS) as root
> > filesystem?I used linux2.4.4 from denx .
>
> Just pass "root=/dev/mtdblock0", that's all.

This will not work. You must use "root=/dev/mtdblock/0" and Linux must be
configured with devfs, devfs must be mounted before and boot support
from ramdisk must be disabled.

Gunnar Larisch
--
Gunnar Larisch
Dipl.-Ing.
Entwicklung
Softing AG - Dep. Industrial Communication
Richard-Reitzner-Allee 6
85540 Haar (near Munich)
Germany
Tel.: ++49 / (0) 89 / 4 56 56 - 183
Fax.: ++49 / (0) 89 / 4 56 56 - 399

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
