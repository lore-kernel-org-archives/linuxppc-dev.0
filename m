Return-Path: <nkbj@mail.tele.dk>
Received: from fep33.mail.dk (fep33.mail.dk [80.160.76.197])
	by ozlabs.org (Postfix) with ESMTP id 5DED967B8F
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 15:04:02 +1000 (EST)
Received: from fep44.mail.dk ([195.41.46.227]) by fep31.mail.dk
	(InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
	id <20060809035933.YLMI11067.fep31.mail.dk@fep44.mail.dk>
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 05:59:33 +0200
Received: from [87.51.137.148] by fep44.mail.dk
	(InterMail vG.2.02.00.00 201-2161-120-101-20051020) with ESMTP
	id <20060809035932.KFMZ15124.fep44.mail.dk@[87.51.137.148]>
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 05:59:32 +0200
Subject: Re: booting with BootX corrupts memory
From: Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 09 Aug 2006 06:00:24 +0200
Message-Id: <1155096025.3813.6.camel@plutonium.opasia.dk>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Aug  1, Olaf Hering wrote:

> Booting an old Mac with BootX corrupts memory, the kernel seldom gets
> into init. Even the built-in initramfs archive gets corrupted. So far I
> havent figured out where the corruption starts. The only data point so
> far is that a passed initrd gets overwritten with stuff that looks like
> part of the device-tree after the call to free_area_init_node() from
> paging_init(). Perhaps the virtual/real address mapping isnt handled
> correctly.

> This is broken since at least 2.6.15, 2.6.14 dies very early, 2.6.13 was
> still ok.

> Symptoms differ, depending on used .config and wether an initrd is passed.

I think I've been hit by this bug on my beige G3 running Ubuntu Edgy.

When booting with initrd the boot process stops before any kernel output (CONFIG_BOOTX_TEXT is not enabled). Booting without initrd works fine - at least until it cannot find the root filesystem driver. ;-)

Anything I can do to help debug this?

Regards,
-- 
Niels Kristian Bech Jensen

Stop software piracy --- use free software.
