Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 32DDF679EF
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Mar 2006 00:05:52 +1100 (EST)
In-Reply-To: <22544.1141981797@www088.gmx.net>
References: <1141942301.3603.12.camel@localhost.localdomain>
	<22544.1141981797@www088.gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <051c9d8f422b0e5289b7083367cf44ca@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Unmapping pages from the linear addressing without HIGHMEM	support
Date: Fri, 10 Mar 2006 07:59:33 -0500
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 10, 2006, at 4:09 AM, Gerhard Pircher wrote:

> That would mean I cannot reuse the code in dma-mapping.c, right?

Sure you can.  All you need to do is turn of BAT mapping, which
is as easy as using the 'nobats' command line parameter and
all of this code should just work for you.

> ...   but I guess I have to setup my own page table for the reserved
> DMA memory area and implement my own alloc_pages() function!?

No, that's already done for you behind all of these functions.

Thanks.

	-- Dan
