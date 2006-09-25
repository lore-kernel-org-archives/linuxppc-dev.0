Return-Path: <lombardo@mdivac.com>
Message-ID: <4517FFA9.5050004@mdivac.com>
Date: Mon, 25 Sep 2006 12:11:21 -0400
From: Frank D Lombardo <lombardo@mdivac.com>
MIME-Version: 1.0
To: christophe.alayrac@univ-orleans.fr
Subject: Re: ML403 patch for UBOOT
References: <BAY110-F21CF9E20190CB4CC022CCFB2240@phx.gbl>
	<1159189359.4848.6.camel@Serge-Linux>
In-Reply-To: <1159189359.4848.6.camel@Serge-Linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

alayrac wrote:
> Le lundi 25 septembre 2006 à 12:34 +0000, Ming Liu a écrit :
>   
>> Hi,
>> Here it is...
>>
>> http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/023912.html
>>
>> Regards
>> Ming
>>
>>     
> Thank you Ming for your prompt reply. It is exactly the pacth I've found
> previously.
> The pacth start with the following lines :
> diff -Naur linux-2.6.17-4.patch1/arch/ppc/platforms/4xx/xilinx_ml300.h
> linux-2.6.17-4.working/arch/ppc/platforms/4xx/xilinx_ml300.h
> --- linux-2.6.17-4.patch1/arch/ppc/platforms/4xx/xilinx_ml300.h 2006-07-25 16:42:50.000000000 -0400
> +++ linux-2.6.17-4.working/arch/ppc/platforms/4xx/xilinx_ml300.h        2006-08-02 19:47:00.000000000 -0400
>
> I understand from that that it try to change linux-2.6.17-4 xilinx_ml300.h
> If I type from u-boot (1.1.4) source code directory
> patch -i U-BOOT 
> with U-BOOT the text file containing that pacth then it stop askink for file path.
>
> So I wonder if the pacth is for UBOOT or Linux 2.6.17-4 kernel source?
>
> I should precise that I'm a beginner with Uboot and linux 2.6 (already port linux 2.4 on ML403 using BYU instructions)
> I must miss something basic...
>
> Thanks for your help
>
> Chris
>   
Chris,

You are correct, that patch is for the Linux kernel and should be 
applied to the kernel if you are planning on using u-boot.  It ensures 
that the board_info structure in the kernel matches the one used by u-boot.

Xilinx has a u-boot tree that works with the ML403 board.  It is 
available here:
http://www.xilinx.com/ml410-p/designs/u-boot.zip

Good luck,
Frank
