Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A7DD67D00
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 04:43:44 +1000 (EST)
Message-ID: <42E3DD39.8040104@varma-el.com>
Date: Sun, 24 Jul 2005 22:26:01 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Olivier Singla <osingla@integrian.com>
References: <42DE89B1.1030400@integrian.com>
In-Reply-To: <42DE89B1.1030400@integrian.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: LITE5200 2.6.x kernel support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Oliver,

Could you send boot log?
And, at this time, vanilla 2.6.xx kernel couldn't boot from nfs (and use
eth too), since fec (ethernet) driver still not ready.

-- 
Regards
Andrey Volkov

Olivier Singla wrote:
> Hi,
> 
> I am currently using 2.4.25 on the Lite5200 board, but I'd really like to
> switch to 2.6.x. The only 5200 specific support I need are the integrated
> uart and the PCI. I tried both 2.6.11 and 2.6.12 without luck: the kernel
> start, but then is stuck (seems into the init sequence). I use the
> configuration
> file from arch/ppc/configs/lite5200_defconfig. I cross-compiled the
> kernel with gcc-3.4.1.
> 
> I was wondering if somebody could give me some help, maybe by telling
> be what I am doing wrong.
> 
> Thanks,
> Olivier
> 
> BTW, I tried also 2.6.13-rc3, but I can't even compile for the Lite5200,
> there are some syntax error when compile the pci module...
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
