Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8A245DE2F5
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 23:58:10 +1100 (EST)
Message-ID: <496F318D.6010302@denx.de>
Date: Thu, 15 Jan 2009 13:52:29 +0100
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
In-Reply-To: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean-Michel Hautbois wrote:

> I have a MPC8272ADS board, 64MB RAM, 8MB Flash.
> I compiled u-boot using the existing config file, and compiled my linux
> kernel successfully with the defconfig file too.
> 
> I have updated u-boot, downloaded my kernel file, and a ramdisk image
> from the eldk distribution.
> I have tried using a lot of bootargs (
> bootargs root=/dev/ram rw console=ttyS0,115200
> bootargs through nfs, etc.)
> 
> When I am resetting my card, it reboots:
> bootargs=root=/dev/ram rw console=ttyS0,115200
> bootcmd=bootm ff800000 ff980000

you also need to build a device tree blob for mpc8272ads, load it
into RAM or flash and boot using "bootm" command as follows:

=> bootm ff800000 ff980000 %FDT_ADDR%"

See also http://www.denx.de/wiki/view/DULG/BootingEmbeddedLinux

Best regards,
Anatolij
