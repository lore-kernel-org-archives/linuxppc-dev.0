Return-Path: <tim@seoss.co.uk>
Received: from relay1.allsecuredomains.com (relay1.allsecuredomains.com
 [78.47.251.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PJf30SHSzDqvV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 18:39:05 +1000 (AEST)
Subject: Re: NXP p1010se device trees only correct for P1010E/P1014E, not
 P1010/P1014 SoCs.
To: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
References: <1ed6ce0c-f7df-615b-ffdb-8dab25b506f6@seoss.co.uk>
 <bdc2e385580cc08bcbf9d5b3595cbca5162314f8.camel@buserror.net>
From: Tim Small <tim@seoss.co.uk>
Message-ID: <0bec4690-992b-a6ef-3989-a1ce96da825d@seoss.co.uk>
Date: Mon, 9 Jul 2018 09:38:59 +0100
MIME-Version: 1.0
In-Reply-To: <bdc2e385580cc08bcbf9d5b3595cbca5162314f8.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/07/18 19:41, Scott Wood wrote:
>> My openwrt patch
>> just does a:
>>
>> /delete-node/  crypto@30000;
>>
>> after the p1010si-post.dtsi include.
> U-Boot should already be removing the node on non-E chips -- see
> ft_cpu_setup() in arch/powerpc/cpu/mpc85xx/fdt.c


Hi Scott,

Thanks for your email.  The device in question ships an old uboot (a 
vendor fork of U-Boot 2010.12-svn15934).

I am right in saying that the right fix is to either:

Use a bootloader (such as current upstream uboot) which adjusts the 
device tree properly...

or:

In the case (such as OpenWRT) where the preferred installation method is 
to retain the vendor bootloader, then the distro kernel should handle 
the device tree fixup itself?

Regards,

Tim.
