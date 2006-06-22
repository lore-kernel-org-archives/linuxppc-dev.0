Return-Path: <robinpv@aiware.co.jp>
Received: from cat.aiware.co.jp (ml.aiware.jp [222.228.111.22])
	by ozlabs.org (Postfix) with ESMTP id B075B679FD
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 11:09:25 +1000 (EST)
Message-ID: <4499EDEF.6000902@aiware.co.jp>
Date: Thu, 22 Jun 2006 10:10:07 +0900
From: robinpv <robinpv@aiware.co.jp>
MIME-Version: 1.0
To: "Zhan, Rongkai" <rongkai.zhan@windriver.com>
Subject: Re: Linux ppc port problem
References: <6A3254532ACD7A42805B4E1BFD18080E01039494@ism-mail01.corp.ad.wrs.com>
In-Reply-To: <6A3254532ACD7A42805B4E1BFD18080E01039494@ism-mail01.corp.ad.wrs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The linux is up, Thank you. I did do anything checked today console is 
up!! strange

With Regards
Robin

Zhan, Rongkai wrote:

>You even have not a working kernel console.
>
>Best Regards,
>Mark. Zhan
>-----Original Message-----
>From: linuxppc-dev-bounces+rongkai.zhan=windriver.com@ozlabs.org [mailto:linuxppc-dev-bounces+rongkai.zhan=windriver.com@ozlabs.org] On Behalf Of robinpv
>Sent: Wednesday, June 21, 2006 5:45 PM
>To: linuxppc-dev@ozlabs.org
>Subject: Linux ppc port problem
>
>Hi ,
>     I am trying to the port linux to the mpc5200 based board( Lite5200.)
>     I am using linux version 2.6.16.1.  I am getting the below message 
>after that, linux seems to he in hanged state
>     I debugged and found that the control is reaching the schedule() in 
>rest_init() which is the last function called in start_kernel().
>     I have set the command line arguements to "console=ttyPSC0,115200 
>root=/dev/ram0 rw ramdisk_size=16384"
>     Can you suggest, how to proceed or what could be the problem.
>
>With regards
>Robin
>
>
>## Booting image at ff000000 ...
>   Image Name:   Linux-2.6.16.1
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1301999 Bytes =  1.2 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
>## Loading RAMDisk Image at ff200000 ...
>   Image Name:   ramdisk
>   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>   Data Size:    2788700 Bytes =  2.7 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Loading Ramdisk to 03d05000, end 03fadd5c ... OK
>id mach(): done
>MMU:enter
>MMU:hw init
>MMU:mapin
>MMU:setio
>MMU:exit
>setup_arch: enter
>setup_arch: bootmem
>arch: exit
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>  
>
