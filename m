Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DBB78DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jul 2007 03:56:13 +1000 (EST)
Message-ID: <46AA31B6.4040809@freescale.com>
Date: Fri, 27 Jul 2007 12:56:06 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: a question about mpc8xx linux
References: <200707272111187341027@163.com> <46AA3127.4060806@freescale.com>
In-Reply-To: <46AA3127.4060806@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: poorbeyond <poorbeyond@163.com>,
	Linux-ppc mail list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> poorbeyond wrote:
> 
>>my cpu is MPC860, use u-boot-1.1.4, linux-2.6.20.14
>>
>>i use the "tftp 300000 uImage" command download kernel image,
>>
>>then use the "bootm 300000" command boot the image.
> 
> 
> You'll need either a device-tree-aware u-boot or 8xx cuImage support; 
> you can get the latter from the patchset I posted recently.

Sorry, I missed that you're using arch/ppc rather than arch/powerpc.

arch/ppc doesn't require a device tree, though it would be good to 
switch to arch/powerpc once my 8xx fixes go in -- arch/ppc is deprecated.

-Scott
