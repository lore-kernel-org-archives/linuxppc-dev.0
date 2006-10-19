Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA97467A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 11:54:33 +1000 (EST)
In-Reply-To: <54A124D27BDE0F449E2032F42ED617583197CD@zch01exm21.fsl.freescale.net>
References: <54A124D27BDE0F449E2032F42ED617583197CD@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <39D16244-1677-4ED0-99CD-C1A1F393D140@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Linuxppc-embedded Digest, Vol 26, Issue 36
Date: Wed, 18 Oct 2006 20:54:24 -0500
To: Wang Matthew-R59995 <Qi.W@freescale.com>
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


On Oct 18, 2006, at 8:10 PM, Wang Matthew-R59995 wrote:

> Hi Kumar,
>
> Actually I do many trials about it. Vxwerks Bootrom is smaller than
> U-Boot. The key difference between Bootrom and U-boot is that some
> source code of Bootrom is invisible to the users.
>
> Actually the rfi instruction which I point out is the first rfi
> instruction of Linux PowerPC bringup.
>
> Before that, it's TLB entry invalidation and temp TLB entry mapping.
>
> I check MMU setting carefully before coming Linux Kernel.
>
> I just want to know if other guys met similar scenario like me. I  
> don't
> need the precise answer, just overall suggestion about it because I
> understand that not everyone has the same bootloader of mine, that
> bootloader is actually a customized bootloader.

I understand that, thus I was asking what exact problem you were  
seeing to try and help.

> Anyway thank you.
>
> R9 point to LR register, mask the high 20 bit of r9 and send to r7,  
> and
> then add 24, which means stride 6 instructions for rfi instruction
> execution.
>
> Of course, rfi can switch the TLB entry, both the previous TLB  
> entry and
> the temp TLB entry point to the same physical address.
>
> I've checked it.

I know what the code does, I wrote it :)

- kumar
