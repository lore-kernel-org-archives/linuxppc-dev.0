Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDF78DDE27
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 03:26:18 +1000 (EST)
Message-ID: <471645A9.7090500@freescale.com>
Date: Wed, 17 Oct 2007 12:26:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: mpc 860 boot linux2.6.23 problem
References: <20071015233839.959F4247BB@gemini.denx.de>
	<4714E44F.7030909@freescale.com>
	<85100356-D95B-4343-98BE-66080EA9887D@embeddedalley.com>
	<47162AE7.80305@freescale.com>
	<5E6FFDE1-D706-4460-8621-0BFA38FDC502@embeddedalley.com>
In-Reply-To: <5E6FFDE1-D706-4460-8621-0BFA38FDC502@embeddedalley.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Oct 17, 2007, at 11:31 AM, Scott Wood wrote:
> 
>> I just pulled Wolfgang's latest u-boot tree, and I don't see any fdt 
>> or ft_ calls in cpu/mpc8xx, nor in any 8xx board that I recognize.
> 
> The STx XTc 885 is supported and was used for
> a majority of the FT development in u-boot.  I
> just built it a few months ago, it worked fine, so
> if it isn't working today the changes should be
> minimal to bring it up to date.

OK, that wasn't a board I recognized. :-P

Still, most 8xx boards are not yet converted AFAICT.  Not that it'd be 
hard to do so, but it might be a bit misleading to say "upgrade u-boot 
and get device tree support". :-)

-Scott
