Return-Path: <x.xiao@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id CD78F679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 05:24:41 +1000 (EST)
Message-ID: <44638F6D.1030602@freescale.com>
Date: Thu, 11 May 2006 14:24:29 -0500
From: Xianghua Xiao <x.xiao@freescale.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC8641(D) software status
References: <20060511190201.D3818352B0C@atlas.denx.de>
In-Reply-To: <20060511190201.D3818352B0C@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

well I am not the one to be allowed to send public patches. However if 
someone needs a 2.6.15/2.6.16 patch I can certainly send it out before a 
public release(2.6.17?) is ready. It's also available on freescale's 
website.

thanks,
xianghua

Wolfgang Denk wrote:

>In message <44634541.3040109@freescale.com> you wrote:
>  
>
>>We have patches for 8641D against 2.6.15/2.6.16 and it works well in lab
>>in the last three months along with u-boot code. I think a patch against
>>2.6.17 or later will be released in the future. However if you need the
>>2.6.15/2.6.16 patch now, you can contact Freescale directly. In fact,
>>for all 8641D boards we will ship, we will include the kernel/u-boot
>>source code on the SATA hard drive directly as well, or you can also
>>download them from freescale's website.
>>    
>>
>
>And when will you start working with the commmunity, and submit  your
>patches  to the public source tree? Will Freescale wait (again) until
>they are against such an old version that it's a PITA to merge them?
>
>Best regards,
>
>Wolfgang Denk
>
>  
>

-- 
//  Xianghua Xiao
//  Freescale Semiconductor    x.xiao@freescale.com
//  (Tel)1 (512) 996-6768    (Fax) 1 (512) 996-7438
//  7700 W. Parmer Lane, MD: PL30, Austin, TX 78729 
