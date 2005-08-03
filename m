Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 3886167E7B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 23:03:09 +1000 (EST)
Message-ID: <42F0C08C.7060801@ru.mvista.com>
Date: Wed, 03 Aug 2005 17:03:08 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
References: <8E342283C2100540AAC5D103097054776F8500@rcexc.racoms.loc>
In-Reply-To: <8E342283C2100540AAC5D103097054776F8500@rcexc.racoms.loc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC885ADS and 2.6.13-rc5 - nogo ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Schaefer-Hutter, Peter wrote:

>Hello!
>
>I gave the MPC885ADS support recently added by Andrei Konovalov 
>a try - but no luck: booting 2.6.13-rc5 with u-boot 1.1.2 
>(tftpboot & bootm) hangs after uncompressing.
>
>Did anybody succeed with this?
>
>Applied were the following patches from patchwork.ozlabs.org:
>
> * 8xx_cpm_hostalloc
> * all fixes to fec.c
>
>The board boots an 2.4-Kernel just fine. Did i miss some patches 
>for U-Boot?
>
>Best regards,
>
> Peter
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>  
>
Mentioned support should work `out-of-the box`.
Make sure you have console=ttyCPM0,115200 (or whatever baudrate you 
have) within bootargs in the U-Boot environment. U-Boot modification is 
needed only if you wish to have both FEC MAC addresses configured via 
U-Boot env as well. Also only the related defconfig should be used.

-- 
Sincerely, 
Vitaly
