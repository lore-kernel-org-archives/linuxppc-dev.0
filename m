Return-Path: <x.xiao@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 38E9667C31
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Jun 2006 05:45:39 +1000 (EST)
Message-ID: <4489D00B.7070800@freescale.com>
Date: Fri, 09 Jun 2006 14:46:19 -0500
From: Xianghua Xiao <x.xiao@freescale.com>
MIME-Version: 1.0
To: Scott Coulter <scott.coulter@cyclone.com>, linuxppc-embedded@ozlabs.org
Subject: Re: booting Linux 2.6.15 using a ramdisk and greater than 512MB of
	DRAM
References: <43EB80E07C42E1408726E4905FB96B0466C6C1@CYBORG3.cyclone.com>
In-Reply-To: <43EB80E07C42E1408726E4905FB96B0466C6C1@CYBORG3.cyclone.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: x.xiao@freescale.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I think it's a u-boot 'feature' and has nothing to do with the kernel.
xianghua

Scott Coulter wrote:

>Xianghua,
>
>That seems to have worked.
>
>Do you think that this is worth investigating?
>
>Thanks,
>
>
>Scott
>
>
>
>
>
>
>___________________________________________________________________
>
>  Scott N. Coulter
>  Senior Software Engineer
>  
>  Cyclone Microsystems          
>  370 James Street              Phone:  203.786.5536 ext. 118
>  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
>  U.S.A.                        Web:    http://www.cyclone.com
>___________________________________________________________________
>
>-----Original Message-----
>From: Xianghua Xiao [mailto:x.xiao@freescale.com] 
>Sent: Friday, June 09, 2006 3:37 PM
>To: Scott Coulter
>Subject: Re: booting Linux 2.6.15 using a ramdisk and greater than 512MB
>of DRAM
>
>try set initrd_high=0xffffffff under u-boot, see if it helps
>
>Scott Coulter wrote:
>
>  
>
>>Hi everyone,
>>
>>I am not sure if this is a linux question or a u-boot question.  I have
>>a custom MPC8540 board running U-boot 1.1.4.  With a NFS root
>>configuration, I have booted and run 2.6.15 with memory from 256MB to
>>2GB.  If I build a ramdisk image (or even if I use the ramdisk image
>>with the 85xx version of ELDK 4.0) and then combine it with the kernel
>>image (vmlinux.gz) using "mkimage", the linux boot blows out with an
>>oops if I boot the board with more that 512MB of DRAM.  From the U-boot
>>output, it looks like the ramdisk image is getting copied to the upper
>>portion of DRAM.  Is it possible that the kernel doesn't map enough
>>    
>>
>DRAM
>  
>
>>to allow the image to be read?
>>
>>I haven't spent a lot of time debugging this once I saw that the 512MB
>>configuration worked OK.  Has anyone run into this?
>>
>>Thanks,
>>
>>Scott
>>
>>
>>
>>___________________________________________________________________
>>
>> Scott N. Coulter
>> Senior Software Engineer
>> 
>> Cyclone Microsystems          
>> 370 James Street              Phone:  203.786.5536 ext. 118
>> New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
>> U.S.A.                        Web:    http://www.cyclone.com
>>___________________________________________________________________
>>
>>_______________________________________________
>>Linuxppc-embedded mailing list
>>Linuxppc-embedded@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> 
>>
>>    
>>
