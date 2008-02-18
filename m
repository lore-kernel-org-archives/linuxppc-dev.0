Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C71BDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 03:17:53 +1100 (EST)
Date: Mon, 18 Feb 2008 11:18:05 -0500
To: Linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia NAND - others missing?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080218161754.6C71BDDE20@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Looking at the "arch/ppc/platforms/4xx/sequoia.c" from 2.6.14 
MontaVista, I also see ECC error handling, a Serial RTC device, UART4 
to UART11. It doesn't look like those are supported in the current 
"arch/powerpc/platforms/44x/sequoia" ?

Regarding the nftd NAND driver, I see a device table hookup in 
"arch/powerpc/platforms/44x/warp-nand.c".  Am I right in saying that 
file is a perfect template from which to generate sequoia-nand.c ?

thanks,
Steve


At 03:56 PM 2/17/2008, you wrote:
>On Sun, 17 Feb 2008 10:27:22 -0500
>Steve Heflin <sheflin@newagemicro.com> wrote:
>
> > Are there other devices (beside the NAND Flash Controller) that exist
> > on the AMCC-440EPx chip and are not supported by the current
> > Linux-2.6.25 ARCH=powerpc?
>
>i2c, GPIO, the security stuff (if your version has that), and GPT.
>Thought GPT has never really been supported in any kernel that I
>remember.
>
>Patches for i2c and GPIO are floating around somewhere I think.  Just
>need to get them polished up and device-tree compliant.
>
>josh
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
