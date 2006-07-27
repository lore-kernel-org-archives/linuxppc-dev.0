Return-Path: <lombardo@mdivac.com>
Received: from mail.mdivac.com (adsl-68-253-104-89.dsl.bcvloh.ameritech.net
	[68.253.104.89]) by ozlabs.org (Postfix) with ESMTP id 08ECF67B56
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jul 2006 01:42:42 +1000 (EST)
Message-ID: <44C8DC19.9030600@mdivac.com>
Date: Thu, 27 Jul 2006 11:30:33 -0400
From: Frank D Lombardo <lombardo@mdivac.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Where to store the Linux kernel.
References: <BAY110-F64D7B98642F2626AA4E90B2580@phx.gbl>
In-Reply-To: <BAY110-F64D7B98642F2626AA4E90B2580@phx.gbl>
Content-Type: text/plain; charset=GB2312
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ming,

I am using an ML403 in a similar way. I have the download.bit file
stored in platform flash. U-Boot, the Linux Kernel and initrd are stored
in the linear flash.

Frank


Ming Liu wrote:
> Hello everyone,
> Now I am doing a embedded linux project on the board of ML403(virtex4, 
> ppc405). In my product, I cannot use CF card. So I have to use flash memory 
> to store the Linux kernel. Except for the Linux kernel, also I have to 
> store the hardware information of the system.bit file. I know in ml403 
> board, there are two types of flash. One is Platform Flash and the other is 
> Linear Flash. Can anyone tell me how can I arrange my hardware .bit file 
> and Linux kernel zImage.elf file and store them in the flash provided in 
> the board? Can I put both of them in the Platform Flash chip? Thanks for 
> the telling. 
>
> Regards
> Ming
>
> _________________________________________________________________
> 与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
