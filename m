Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1DF98DDFB0
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 02:05:10 +1000 (EST)
Message-ID: <4638B6AE.3030306@freescale.com>
Date: Wed, 02 May 2007 11:05:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Remove duplicate export of __div64_32.
References: <20070501160538.GA24292@ld0162-tx32.am.freescale.net>
	<E8649267-DE22-4700-BF33-A9EB744B11DC@kernel.crashing.org>
In-Reply-To: <E8649267-DE22-4700-BF33-A9EB744B11DC@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On May 1, 2007, at 11:05 AM, Scott Wood wrote:
> 
>> Change 3927f2e8f9afa3424bb51ca81f7abac01ffd0005 moved lib/lib64.c from
>> lib-y to obj-y, preventing the export in ppc_ksyms.c from overriding
>> the one in lib, and thus causing a duplicate-export warning.
> 
> 
> I assume you mean lib/div64.c?

D'oh... of course. :-P

-Scott
