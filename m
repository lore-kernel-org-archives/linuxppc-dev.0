Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 375CF67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 06:59:00 +1000 (EST)
To: Igor Luri <iluri@fagorautomation.es>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CRAMFS: Error -3 while decompressing! 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 May 2006 11:40:18 +0200."
	<44718702.1070809@fagorautomation.es>
Date: Mon, 22 May 2006 22:58:58 +0200
Sender: wd@denx.de
Message-Id: <20060522205858.5CC443525D9@atlas.denx.de>
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

In message <44718702.1070809@fagorautomation.es> you wrote:
> 
> We have a mpc5200liteB evaluation board with u-boot 1.1.4 and linux 
> 2.4.25 from Denx.  We have grabed a cramfs  root fs on a mtd partition 
> and we are able to boot linux without problems:
...
> However, we are not able to boot linux with the same rootfs image (with 
> the u-boot header) loaded from RAM.
> 
>         setenv bootargs root=/dev/rw rw console=ttyS0 console=ttyS0
>         init=/sbin/init ip=on

What's /dev/rw ???

> and CRAMFS image is built with correct endianess:

Ummm.. Why would you want to use a cramfs file system in a ramdisk
image? This iseems to be a truely pessimal combination of features to
me. Please see
http://www.denx.de/wiki/view/DULG/RootFileSystemDesignAndBuilding for
some hints...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Life sucks, but it's better than the alternative."
- Peter da Silva
