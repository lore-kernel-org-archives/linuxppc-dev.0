Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 9E833DDD1C
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 00:31:46 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LYh5w-0000ga-HP
	for linuxppc-dev@ozlabs.org; Sun, 15 Feb 2009 05:31:40 -0800
Message-ID: <22022614.post@talk.nabble.com>
Date: Sun, 15 Feb 2009 05:31:40 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 4xx tree updates
In-Reply-To: <20090214194732.GA30783@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20090214194732.GA30783@zod.rchland.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Josh Boyer-4 wrote:
> 
> Hi All,
> 
> I've been rather busy lately and have unfortunately gotten behind on
> updating the 4xx tree.  I spent some time this weekend looking over
> the patches queued up, and fortunately there were not too many.  I'm
> doing some build testing of these 4 today:
> 
> commit 6c7120902305b3a21460cd2f0f917a39307df566
> Author: Madhulika Madishetty <mmadishetty@amcc.com>
> 
>     AMCC PPC 460SX redwood SoC platform initial framework
> 
> commit 41b6a085e48d0d9e1200946755f49f31dd930137
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
>     powerpc/4xx: Enable PCI domains on 4xx
> 
> commit 018f76ec516c09a5381e517d0739d377a60ec0d5
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
>     powerpc/4xx: Add missing USB and i2c devices to Canyonlands
> 
> commit e12401222f749c37277a313d631dc024bbfd3b00
> Author: Yuri Tikhonov <yur@emcraft.com>
> 
>     powerpc/44x: Support for 256KB PAGE_SIZE
> 
> Barring any unforseen issues with these, I'll push them to my
> next branch tomorrow and ask Ben to pull them shortly thereafter.
> 
> If I've missed any patches that should be headed for 2.6.30, please
> let me know!
> 
> josh
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

Hi, Josh

What about 4xx  SPI driver ? Is it planned for inclusion in 2.6.30 ?

Thanks.

Felix.


-- 
View this message in context: http://www.nabble.com/4xx-tree-updates-tp22016711p22022614.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
