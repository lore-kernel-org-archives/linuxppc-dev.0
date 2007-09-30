Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A62E4DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Sep 2007 21:05:03 +1000 (EST)
Message-ID: <46FF7A7D.6040300@genesi-usa.com>
Date: Sun, 30 Sep 2007 11:29:17 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Efika, initrd and current kernel
References: <9e4733910709292205p7b1cdda9m661b241908fdedab@mail.gmail.com>
In-Reply-To: <9e4733910709292205p7b1cdda9m661b241908fdedab@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

How did you build the kernel?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Jon Smirl wrote:
> I'm trying to boot a current kernel on the Efika like this:
> boot hd:0 efika init=/linuxrc root=/dev/ram0 looptype=squashfs
> loop=/squashfs.img cdroot
> 
> It is not finding the initrd.
> I added some printks and start_initrd is not getting set.
> 
> The 2.6.19 gentoo kernel described here boots and finds the same initrd
> http://gentoo-wiki.com/Efika
> 
> Something is missing in the hand off from the OF to the kernel code.
> I'm poking around in powerpc/kernel/prom_init.c
> looking for answers.
> 
