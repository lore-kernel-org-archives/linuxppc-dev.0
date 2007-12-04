Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 429D2DE049
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:59:42 +1100 (EST)
Date: Tue, 4 Dec 2007 15:03:44 -0600
From: Olof Johansson <olof@lixom.net>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_of_platform: Move electra-ide support over to new
	framework
Message-ID: <20071204210344.GE8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204204432.GD8099@lixom.net> <4755BD7B.6030208@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4755BD7B.6030208@garzik.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 03:50:03PM -0500, Jeff Garzik wrote:
> Olof Johansson wrote:
>> [POWERPC] Move electra-ide support over to new pata_of_platform framework
>> Move electra-ide glue over to the new pata_of_platform framework, and
>> add the quirks needed to that driver.
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>> I'll remove the electra-ide stuff from arch/powerpc/platforms/pasemi
>> once this hits a common tree, since otherwise I'd be without IDE until
>> they converge (i.e.  2.6.25 merge window).
>
> FWIW I'm presuming this work will go via a powerpc tree not libata... 
> Generally that's not the case, but here it's largely an arch-specific work.

Ok, that works. I was thinking of letting this patch go through libata,
and do the removal through the powerpc merge path. But I can do both
through powerpc.

-Olof
