Return-Path: <happyphot@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.207])
	by ozlabs.org (Postfix) with ESMTP id 1E47368910
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jan 2006 13:48:16 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so2310486nzd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 02 Jan 2006 18:48:15 -0800 (PST)
Message-ID: <00af01c61010$245773b0$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: "David Jander" <david.jander@protonic.nl>, <linuxppc-embedded@ozlabs.org>
References: <000701c60fab$9fdca6a0$0760120a@photon>
	<200601021657.35359.david.jander@protonic.nl>
Date: Tue, 3 Jan 2006 10:48:02 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Subject: Re: VFS: Cannot open root device "31:03" or unknown-block(31,3)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Monday 02 January 2006 15:48, HappyPhot wrote:
>> Hi,
>>   I've suffered for many days and "google" almost every where.
>> I would like to boot from the flash with jffs2 (i.e. using jffs2 as my
>> root /) . But it alyaws shows:
>> VFS: Cannot open root device..... (whole message is as below)
>>
>>   Anybody knows what may cause this ? Please help and
>> thank you.
>>[...]
>
> You omitted the interesting part of the log output, the bootarguments at 
> the
> very beginning. What is the value of root= ?
> Maybe you made the typical mistake of specifying /dev/mtd3 instead
> of /dev/mtdblock3, or you didn't compile in support for mtd access as a 
> block
> device?
>

Hi, David and all,
  I've tried root=/dev/mtdblock3, root=/dev/mtd3, root=31:03 etc.  And 
"Caching
block device access to MTD devices" was also selected when 'make 
menuconfig'.
The results were the same.
  I use "phys_mapped_flash" and "mtdparts=phys_mapped_flash:2M(k4),2M(k6),
4M(rd),4M(jffs2),-(User_Data)". What is the "root=" I should use ?

  Also, I am wondering how the kernel knows "/dev/mtdblock3" is in my flash 
?
I think I never do any setting about this....

thank you ,
/HappyPhot
