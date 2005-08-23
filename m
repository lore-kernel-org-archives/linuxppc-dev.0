Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 1B48668053
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 15:32:09 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'Robert P. J. Day'" <rpjday@mindspring.com>
Date: Tue, 23 Aug 2005 13:31:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.63.0508222323480.18519@localhost.localdomain>
Message-Id: <20050823053209.1B48668053@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux Kernel MTD question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It doesn't work, too. 
Error message: Invalid argument.

Thanks,
Johnson Cheng

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Robert P. J. Day
Sent: Tuesday, August 23, 2005 11:24 AM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux Kernel MTD question 

On Sat, 23 Jul 2005, JohnsonCheng wrote:

> Yes. You are right. It's design by myself.
> But I meet a problem. If I have three configuration files, A.conf, B.conf
> and C.conf, then I hope save them in one of partitions of MTD,
> 0x005C0000-0x10000000.
> Two questions:
> 1. How to build these configuration files into an image for U-boot with
> mkimage?
> 2. In kernel, how to get these data? I use "mount /dev/mtd4 /mnt", but it
> failed by block device required.

for this second issue, you might try mounting the block device, which
is probably called /dev/mtdblock4 or something similar.

rday
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
