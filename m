Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD8B2B7BB2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2009 01:22:49 +1100 (EST)
Subject: Re: How to mount rootfs though harddisk when booting?
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <e997b7420910220708i63b85ca1n256f332ddc6819c1@mail.gmail.com>
Date: Thu, 22 Oct 2009 09:22:42 -0500
Message-Id: <CAEDEFF6-55D3-43AA-BA6C-92D14CBA8A79@kernel.crashing.org>
References: <e997b7420910220708i63b85ca1n256f332ddc6819c1@mail.gmail.com>
To: "wilbur.chan" <wilbur512@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 22, 2009, at 9:08 AM, wilbur.chan wrote:

> mpc85xx with sata harddisk,which has a rootfs on sda3.
>
> I ' ve tried to use  freescale's kernel image , which is  togehther
> with the mpc85xx board, to successfully mount the sda3 filesystem when
> booting,
>
>
> But when I used my own kernle, it failed:
>
>
>
> I am using  kernel 2.6.21.7 to mount the harddisk as the rootfs.
>
> However, it failed in booting and print:
>
>
> VFS: Cannot open root device "sda3" or unknown-block(0,0)
>
> My kernel's bootargs are as followed:
>
>
> root=/dev/sda3 rw console=ttyS0,115200 console=tty0
>
>
> I guess there were some incorrect configs when doing kernel
> menuconfig,  I' ve set "ext2,ext3", and some "sata" ,"scsi" configs,
>
> but that might be  not enough.
>
>
> May anyone please give me some  suggestions?
>
> THX in advance.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

Post the full kernel boot log.

- k
