Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A4CC679F4
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 01:04:51 +1000 (EST)
In-Reply-To: <7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 16 May 2005 11:04:50 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 16, 2005, at 2:21 AM, Kumar Gala wrote:

>
> On May 16, 2005, at 12:52 AM, Benjamin Herrenschmidt wrote:
>> Agreed. I'll fix PReP/CHRP/pmac & defconfig. Every embedded board
>>  vendor/maintainer will be responsible for fixing his/her boards 
>> support.
>
> Agreed.  We should probably send an email to linuxppc-embedded with a 
> more proper subject line to let people know.

There isn't any reason to break everything and force updates.  If 
someone wants
a 3G task size, then just configure that with the advanced options.   
All of that
grew out of the embedded board support, so just make PMac support it 
too.
In particular, I don't want to force the 8xx to a 3G task space, 
because it adds
more instructions to the TLB handlers, on a system that has never 
required
such application space.  We are 12 releases in 2.6, and it still seems 
like
a development kernel :-)  I think if someone wants this feature on a 
board
port that doesn't support it, then just fix that one board port instead 
of breaking
everything.

Thanks.

	-- Dan
