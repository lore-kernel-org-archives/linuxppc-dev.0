Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 67975679F9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 21:00:25 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4CB4ukL005675
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 14:05:06 +0300 (EEST)
Message-ID: <4283335A.7070209@intracom.gr>
Date: Thu, 12 May 2005 13:43:38 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Jaap-Jan Boor <jjboor@aimsys.nl>
References: <427F4D41.10908@intracom.gr>
	<883b9affce23db0859a4619cff66da4e@aimsys.nl>
In-Reply-To: <883b9affce23db0859a4619cff66da4e@aimsys.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jaap-Jan Boor wrote:
> Hi,
> 
> May be a little late (I'm trying to catch up on all mailing list mail)
> but I was wondering if the io port handling functions I see now in these 
> patches
> should not be 'atomic'. So toggling MII pins does not interfere with 
> toggling
> e.g. I2C bit-bang interface pins when those pins happen to be on the same
> port (A/B/C/D/E).
> 
> best regards,
> 
> Jaap-Jan
> 
> 
> 

Jaap-Jan

All mii operations are done under a spinlock with interrupts disabled.

Regards

Pantelis
