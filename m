Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 1619B68719
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Nov 2005 19:19:23 +1100 (EST)
Message-ID: <43784888.9040806@ru.mvista.com>
Date: Mon, 14 Nov 2005 11:19:20 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: srideep.devireddy@wipro.com
References: <6AD9F6A5F6E096408F0B703773355A07605E5D@CHN-SNR-MBX01.wipro.com>
In-Reply-To: <6AD9F6A5F6E096408F0B703773355A07605E5D@CHN-SNR-MBX01.wipro.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8272 + kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

srideep.devireddy@wipro.com wrote:
> Hi Sir ,
> 
>  
> 
>       With the help of mailing list I am able to get my u-boot 1.1.3 
> version … right held up with kernel
> 
> ….
> 
> I am able to boot my MPC8272ADS  with u-boot 1.1.3 version . how can 
> build my uImaze(compressed linux image so that I can boot it ) ,what are 
> the options .. I got the source from Montavista BSP for MPC 8272 .. so 
> can  you guide me in making a compressed image so that I can boot my 
> Linux kernel .
> 
>  
> 
> As of now I am getting and error of
> 
>  
> 
> ## Booting image at 01000000 ...
> 
>  
> 
>    Image Name:   Linux-2.4.22
> 
>  
> 
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> 
>  
> 
>    Data Size:    782360 Bytes = 764 kB
> 
>  
> 
>    Load Address: 00000000
> 
>  
> 
>    Entry Point:  00000000
> 
>  
> 
>    Verifying Checksum ... OK
> 
>  
> 
>    Uncompressing Kernel Image ... OK
> 
>  
> 
>  
> 
> That’s it ... kernel hangs .. why is this ? can you kindly help me 
> resolving in the issue
> 
Do you have console=ttyCPM0,115200 in your bootargs? Anyway, what kernel 
(version) is used, what config file?

The output of the u-boot printenv command will be helpful as well.
>  
> 
>  
> 
> Best Regards
> 
>  
> 
> 
> 
> Confidentiality Notice
> 
> The information contained in this electronic message and any attachments 
> to this message are intended
> for the exclusive use of the addressee(s) and may contain confidential 
> or privileged information. If
> you are not the intended recipient, please notify the sender at Wipro or 
> Mailadmin@wipro.com immediately
> and destroy all copies of this message and any attachments.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Sincerely,
Vitaly
