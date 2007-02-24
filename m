Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 188AFDDE30
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 14:38:08 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HKnjZ-00061a-Di
	for linuxppc-embedded@ozlabs.org; Fri, 23 Feb 2007 19:38:05 -0800
Message-ID: <9130715.post@talk.nabble.com>
Date: Fri, 23 Feb 2007 19:38:05 -0800 (PST)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] jffs2 file system
In-Reply-To: <10456.15332.qm@web307.biz.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <9097247.post@talk.nabble.com>
	<200702221128.02970.juergen.beisert@weihenstephan.org>
	<9097618.post@talk.nabble.com>
	<200702221229.51830.juergen.beisert@weihenstephan.org>
	<9113399.post@talk.nabble.com>
	<1172242531.22834.138.camel@saruman.qstreams.net>
	<9130617.post@talk.nabble.com>
	<10456.15332.qm@web307.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



mkfs.jffs2 -r /mnt -e 0x20000 -o image.jffs2 -b

board is PQ2FADS-ZU, u-boot is u-boot-1.1.1 and linux is montavista2.6.10

is mkfs.jffs2 is architecture dependent?

nethra


Ben Warren wrote:
> 
> 
> --- Nethra <nethra_gmit@yahoo.co.in> wrote:
> 
>> 
>> 
>>  thanks ben,
>> 
>> I have already tried to build jffs2 image as per
>> link mentioned using
>> mkfs.jffs2 utility, but mkfs.jffs2 is absent in
>> host...so i downloded
>> mkfs.jffs2 from net and used the same to create the
>> image.Is it the correct
>> way?
>> 
> 
> Sounds reasonable.
> 
>> it is giveing error when booting...
>> 
>> nethra
> 
> OK, what's the error?  Did you set the endianness
> correctly when using mkfs.jffs2?
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/jffs2-file-system-tf3271928.html#a9130715
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
