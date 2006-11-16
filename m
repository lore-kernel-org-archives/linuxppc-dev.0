Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 884DB67C9A
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 11:51:34 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAG0pXKL028450
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 09:51:33 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAG0pWcs028442
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 09:51:32 +0900 (JST)
Message-ID: <455BB60D.1070506@am.sony.com>
Date: Wed, 15 Nov 2006 16:51:25 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/16] add base support for Celleb platform
References: <200611150931.kAF9VciJ023243@toshiba.co.jp>
	<20061115183621.GB21633@lst.de>
In-Reply-To: <20061115183621.GB21633@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
>> @@ -16,3 +16,4 @@
>>  obj-$(CONFIG_PPC_PASEMI)		+= pasemi/
>>  obj-$(CONFIG_PPC_CELL)		+= cell/
>>  obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
>> +obj-$(CONFIG_PPC_CELLEB)	+= celleb/
> 
> So another platforms directory.  I think we need to sort out the
> mess we have currently.
> 
> I'd prefer either
> 
>   arch/powerpc/platforms/cell		generic cell code (spufs, ..)
>   arch/powerpc/platforms/ibmcell	cell blade & co support
>   arch/powerpc/platforms/ps3hv		Sony hypervisor support
>   arch/powerpc/platforms/celleb		Toshiba

I also think this is preferable to the existing layout, that has both generic
cell support and IBM Blade support in one directory (platforms/cell).

-Geoff
