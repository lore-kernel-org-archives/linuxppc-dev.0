Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6444DDDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 07:32:43 +1000 (EST)
Message-ID: <4692A972.80402@freescale.com>
Date: Mon, 09 Jul 2007 16:32:34 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages, with
	a warning.
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de> <4692A5B8.9010702@freescale.com>
In-Reply-To: <4692A5B8.9010702@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Arnd Bergmann wrote:
>> I may be missing the obvious, but doesn't that defeat the purpose of
>> non-executable mappings?
> 
> 
> The hardware in question doesn't support non-executable mappings; 
> otherwise, it'd never have worked in the first place.  Note that this is 
> only allowed on 32-bit, non-book-E.

To be more precise, the classic MMU does appear to have non-exec 
functionality, but at the segment level, which is less than useful for 
implementing vma flags.

-Scott
