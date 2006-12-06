Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9FB8C67C8E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 03:58:04 +1100 (EST)
Date: Wed, 6 Dec 2006 19:58:09 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Fairweather Kenneth-R61777" <kenneth.fairweather@freescale.com>
Subject: Re: Compiling 2.6.19 for powerpc 8xx
Message-ID: <20061206195809.270c9350@vitb.ru.mvista.com>
In-Reply-To: <BB9BA263E5615D44AF737CA35FB045F5420AA0@zuk35exm20.fsl.freescale.net>
References: <BB9BA263E5615D44AF737CA35FB045F5420AA0@zuk35exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 6 Dec 2006 15:51:14 -0000
"Fairweather Kenneth-R61777" <kenneth.fairweather@freescale.com> wrote:

> Hi,
> 
> I am trying to compile a 2.6.19 kernel for 8xx on powerpc branch. It
> fails on drivers/serial/cpm_uart/cpm_uart_cpm1.c for undefined __res
> variable
> 
> It looks like cpm1.c doesn't have the open firmware changes that cpm2.c
> has.
> 
> I have looked for a patch for this on the site, and havent found one. I
> have applied Vitaly Bordug's 5 patches for 8xx, but they don't appear to
> address this issue.
> 

Yes as the fix is driver-related not exact arch/powerpc stuff.
Bits will be submitted shortly (as I had to do sort of a rebase after 
powerpc.git tree reset) and mentioned issue will be addressed there, as well as similar in fs_enet.

And yes, cpm2's OF-related things were merged (but still needs a couple of fixes that will follow too).

-- 
Sincerely, 
Vitaly
