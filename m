Return-Path: <rsantos@grupopie.com>
Received: from bipbip.grupopie.com (bipbip.grupopie.com [195.23.16.24])
	by ozlabs.org (Postfix) with ESMTP id E01321007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Dec 2010 02:17:09 +1100 (EST)
Message-ID: <4D08D602.9040005@grupopie.com>
Date: Wed, 15 Dec 2010 14:51:46 +0000
From: Rui Santos <rsantos@grupopie.com>
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Force FB off
References: <alpine.LNX.2.01.1012141840130.18577@obet.zrqbmnf.qr>
	<AANLkTimEh+2rEFuq7q+wLcfHw_UKKHVipC0t7mFwSzx8@mail.gmail.com>
	<alpine.LNX.2.01.1012151430220.2052@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1012151430220.2052@obet.zrqbmnf.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  Hi Jan,

     You could boot with "vga=normal i915.modeset=0". This will provide 
you with a 25x80 console.
     You can also use vga=ext for an somethingx50 console.

Regards,
Rui


On 15-12-2010 13:39, Jan Engelhardt wrote:
> On Tuesday 2010-12-14 21:18, Dave Airlie wrote:
>> On Wed, Dec 15, 2010 at 3:41 AM, Jan Engelhardt<jengelh@medozas.de>  wrote:
>>
>>> booting with video=off nor video=i915:off has any effect on skipping
>>> FB. What is the correct option to stop FB from taking over my boot
>>> consoles?
>> For KMS its not fb taking over its the drm i915 driver, nomodeset will
>> stop it however X will no longer work since it relies on the kernel
>> driver.
> That would make sense. Furthermore I discovered that video=vesafb:off
> also has no effect, but here it is clear because the source code ignores
> the return value of fb_get_options, and so ignores any off command.
>
> The real strange thing is that video=offb:off on an Apple Xserve G5
> PPC64, while probably skipping OFFB initialization, still ends up in a
> 640x480 mode with a 8x16 font instead of retaining the PROM
> console/font.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

-- 

Cumprimentos

*Rui Santos*

Email: rsantos@grupopie.com <mailto:rsantos@grupopie.com>
