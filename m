Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 192FADDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:20:51 +1000 (EST)
In-Reply-To: <20070821152745.GA28986@localhost.localdomain>
References: <20070821134537.GA7428@localhost.localdomain>
	<20070821152745.GA28986@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3DC4D103-C7C1-42CC-AEE6-38CFB8836E82@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v5 0/2] SPI support for fsl_soc and mpc832x_rdb
Date: Wed, 22 Aug 2007 09:22:47 -0500
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2007, at 10:27 AM, Anton Vorontsov wrote:

> On Tue, Aug 21, 2007 at 05:45:37PM +0400, Anton Vorontsov wrote:
>> Hi all,
>>
>> Thanks for the previous reviews, this is v4 against Linus' tree,
>> as of today.
>
> Okay, here is brand-new, shiny v5. Today and only today it comes
> without section mismatch warnings, don't miss your chance. Get it
> free of charge! ;-)

This looks good, have some minor cleanup nits.

- k
