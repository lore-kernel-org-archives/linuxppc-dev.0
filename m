Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE0F2DDE37
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 00:39:54 +1000 (EST)
Message-ID: <4703A9B4.6010507@freescale.com>
Date: Wed, 03 Oct 2007 09:39:48 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3] qe: miscellaneous code improvements and fixes to the
	QE library
References: <11903212461510-git-send-email-timur@freescale.com>
	<20071003133032.GA2417@localhost.localdomain>
	<4703A453.8080305@freescale.com>
	<20071003143417.GA5123@localhost.localdomain>
In-Reply-To: <20071003143417.GA5123@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Doubtfully, if changes are completely transparent. Because everything works
> here without that cleanup.
> 
> Ok, thanks anyway, will look further as time will permit.

I did have one idea - the programming of the GUEMR register in ucc_fast_init() 
could be wrong.  Can do a before/after comparison of the contents of that 
register?


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
