Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 115CDDDE04
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jul 2007 03:53:58 +1000 (EST)
Message-ID: <46AA3127.4060806@freescale.com>
Date: Fri, 27 Jul 2007 12:53:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: poorbeyond <poorbeyond@163.com>
Subject: Re: a question about mpc8xx linux
References: <200707272111187341027@163.com>
In-Reply-To: <200707272111187341027@163.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linux-ppc mail list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

poorbeyond wrote:
> my cpu is MPC860, use u-boot-1.1.4, linux-2.6.20.14
> 
> i use the "tftp 300000 uImage" command download kernel image,
> 
> then use the "bootm 300000" command boot the image.

You'll need either a device-tree-aware u-boot or 8xx cuImage support; 
you can get the latter from the patchset I posted recently.

> i found the bootm cmd entered the /arch/ppc/kernel/head_8xx.s, stop at the instruction "rfi".
> is it right? after the instruction, where does the code go normally ? what should i do now?

The rfi transfers control to start_here:

-Scott
