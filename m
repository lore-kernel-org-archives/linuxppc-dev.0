Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id CF094688C6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 03:05:16 +1100 (EST)
Message-ID: <439859BA.6060600@ru.mvista.com>
Date: Thu, 08 Dec 2005 19:05:14 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: jimmy liu <jimmyzhmliu@yahoo.com>
References: <20051208151926.74524.qmail@web53105.mail.yahoo.com>
In-Reply-To: <20051208151926.74524.qmail@web53105.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Need help for Linux hangs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

jimmy liu wrote:
> I have U-Boot running on a board similar to
> MPC8260ADS.
> bootargs=root=/dev/ram rw console=ttyS0,115200
try to set console=ttyCPM0,115200 in the bootargs.
> When I run command: bootm ff060000 ff260000, the
> prompt shows message:
> ## Booting image at ff060000 ...
>    Image Name:   Linux-2.4.25
>    Image Type:   PowerPC Linux Kernel Image (gzip
> compressed)
>    Data Size:    621131 Bytes = 606.6 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at ff260000 ...
>    Image Name:   Simple Embedded Linux Framework
>    Image Type:   PowerPC Linux RAMDisk Image (gzip
> compressed)
>    Data Size:    1591658 Bytes = 1.5 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Loading Ramdisk to 00e07000, end 00f8b96a ... OK
> 
> The system hangs here. I have checked in the FAQs
> provided in the Denx's site, could not find the
> similar case.
> 
> I would appreciate any help.
> 
> Thanks & Regards,
> 
> Jimmy
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
