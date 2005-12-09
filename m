Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 82F5F68879
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 22:50:04 +1100 (EST)
Message-ID: <43996F63.10403@varma-el.com>
Date: Fri, 09 Dec 2005 14:49:55 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: White <white@from-b.org>
References: <20051208231003.3C60B353F77@atlas.denx.de>
In-Reply-To: <20051208231003.3C60B353F77@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Video Card to Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <20051208065907.26c2b1d0@White64> you wrote:
> 
>>DMA is a problem, because the implementation from Freescale use binary
>>data, and has some dirty points. This would never be included in the
>>mainstream kernel. Sylvian has included the new DMA .. works fine for
>>FEC.
> 
> 
> ...did you try this on Rev. B (like B3) silicon?
> 
> What I cannot understand is why there were no attempots to co-operate
> on this with Freescale. They offered their help here on the list...
> 
Cooperation? With Freescale? THEY don't wish it.

About Bestcomm DMA tasks, fec, PCI ... in kernel.

1) Quotation from Freescale support (AFAIK standard answer to
everybody):
===============================================================
"Dear Andrey Volkov,

In reply to your message regarding Service Request SR 1-214731336 (see
details below):

Freescale doesn't disclose the Bestcomm specifications. Alas, I can't
govern this policy.

The customers can use BestComm API with precompiled BestComm images.

OEM customers can create a custom images from a redy for use tasks.

So, Freescale do not give an opportunity for customers to write their
own BestComm tasks.

Should you need to contact us with regard to this message, please see
the notes below.
Best Regards,
Pavel

---------------------------------------------------------------------
This message is in reply to:Activity ID: 1-3KDNVD
Comment:
Dear Andrey Volkov,

In reply to your message regarding Service Request SR 1-214731336 (see
details below):

As far as i know, Freescale do not provide ability to create BestComm
tasks. OEM customers can only link ready for use tasks into BestComm image.

I've asked the factory about current Freescale policy regarding BestComm
development tools and documentation. I'll send their reply to you ASAP.

Please accept my apology for possible delay.

Should you need to contact us with regard to this message, please see
the notes below.
Best Regards,
Pavel

===============================================================

2) Whithout Bestcomm spec you couldn't write right DMA tasklet
or FIX FREESCALE BestcommAPI images (rev B. and fec as ex.),
and hence eth, pci, ide, or something else, like custom mem mapped
device will not work (in worst case) or will work SLOW.

3) Bestcomm API doesn't freely available (you couldn't download it
from MPC5200 page).

3) I and Sylvain try some reverse engineering work of bestcomm u-code,
docos draft is here: http://patchwork.ozlabs.org/linuxppc/patch?id=2057.
So, I repeat my proposal: if somebody have more info, please, expand
this doco.

--
Regards
Andrey Volkov

P.S. I feel like Freescale wish to kill this fine proc or restrict
OS (linux in particular) that could run on it, for they one known
internal reasons.
