Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8709267D00
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jul 2005 04:30:39 +1000 (EST)
In-Reply-To: <1121959795.800.18.camel@rd-lab>
References: <1121959795.800.18.camel@rd-lab>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1a928a85f53f5dcd972161356611a312@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 21 Jul 2005 13:59:38 -0400
To: bogdan antonovici <bantonovici@priority.mb.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, ppckernel <ppckernel@ppckernel.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: swap_dup: Bad swap file entry 00480020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 21, 2005, at 11:29 AM, bogdan antonovici wrote:

> At the time of swap messages i was running a proprietary driver, my
> application and few daemons.

Looks like your driver may have written over some of the page
tables in the kernel space.

> I look on the net for some clues but it's quite confusing, i noticed
> many emails on swap_dup/swap_free error messages but i couldn't figure
> out what should i search for.

Those messages are likely due to a bug with swapping to disk
that has been in some 2.4 kernels, but I don't believe that is
the case here, since you don't have a disk or swapping enabled.


	-- Dan
