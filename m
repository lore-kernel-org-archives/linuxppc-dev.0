Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id ADE30DDF23
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 01:14:24 +1100 (EST)
Message-ID: <47273BF4.80001@ru.mvista.com>
Date: Tue, 30 Oct 2007 17:13:08 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] Add device-tree aware NDFC driver
References: <20071029201738.GA2022@ru.mvista.com>
	<alpine.LFD.0.9999.0710300235580.3186@localhost.localdomain>
In-Reply-To: <alpine.LFD.0.9999.0710300235580.3186@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas Gleixner wrote:
> On Mon, 29 Oct 2007, Valentine Barshak wrote:
> 
>> This adds a device-tree aware PowerPC 44x NanD Flash Controller driver
>> The code is based on the original NDFC driver by Thomas Gleixner, but
>> since it's been changed much and has initialization/clean-up completely
>> reworked it's been put into a separate ndfc_of.c file. This version
>> supports both separate mtd devices on each chip attached to NDFC banks and
>> single mtd device spread across identical chips (not using mtdconcat) as well.
>> The choice is selected with device tree settings. This has been tested
>> on PowerPC 440EPx Sequoia board.
>> Any comments are greatly appreciated.
> 
> Did I express myself not clear enough in my first reply or is this
> just a repeated epiphany in my inbox ? 
> 
> You got plenty of comments to your patches, but you decided to ignore
> them silently.
> 
> Darn, fix it the right way once and forever and please don't try to
> tell me another heartrending "why I did it my way" story.
> 
> This all can be done with a nice series of incremental patches
> including a fixup to the existing users.
> 
> We have enough dump and run shit in the kernel already.
> 
> No thanks,
> 
>    tglx

You know, you're really too tense Thomas. I'm not sure of the reason why 
you're being a complete nerve, but I'm feeling sorry for you.
I'm not saying my approach is the best, but I was hoping for a discussion.
I've reworked the patches according to the comments to the previous 
version and used my arguments to explain why I don't see much reason to 
mess with the code we currently have and added a separate _of version.
I'm sure you'd find some time to do it yourself "the right way once and 
forever" with a "nice series of incremental patches" to fix what we 
currently have (call it a "dump" or anything you like) and even maybe 
add new device tree support.
I'm sorry if for some reason I've made you feel bad.
This is the last time I disturb you with my e-mail, so please, forget it.
Thank you very much for your comments anyway.
It's been nice talking to you,
Valentine.
