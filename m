Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12358DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jun 2007 18:56:08 +1000 (EST)
Message-ID: <46613028.9080004@dlasys.net>
Date: Sat, 02 Jun 2007 04:54:00 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
Subject: Re: Kernel and rootfs in ONE image?
References: <29DC34A6B43468409F5A371CFE34E8491B5A4A@ex01.ads.ubidyne.de>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E8491B5A4A@ex01.ads.ubidyne.de>
Content-Type: text/plain; charset=ISO-8859-1
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

    If you are using 2.6 and you use initramfs, then typically you will
get a single image that contains both the kernel,
    and the initial ramdisk. When you load and execute that image
everything will get sorted out "automagically".

   




Frank Prepelica wrote:
> Hi all,
>
>  
>
> in normal case you have got a kernel image and a rootfs image. Place
>
> that images into flash memory, set correct bootargs and it should work.
>
>  
>
> But, is it possible to generate one image which includes the linux
> kernel 
>
> and a rootfs, place that single image into flash memory and it should
> also work?
>
>  
>
> Thanks in advance!
>
>  
>
> Beste regrads
>
> Frank
>
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
