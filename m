Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9D7C2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2012 09:03:53 +1000 (EST)
Message-ID: <504A7D4D.1090403@freescale.com>
Date: Fri, 7 Sep 2012 18:03:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/booke-64: fix tlbsrx. path in bolted tlb handler
References: <20120612220232.GA17228@tyr.buserror.net>
 <1346991839.2385.42.camel@pasglop> <504A4C43.3040206@freescale.com>
In-Reply-To: <504A4C43.3040206@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/2012 02:34 PM, Scott Wood wrote:
> On 09/06/2012 11:23 PM, Benjamin Herrenschmidt wrote:
>> On Tue, 2012-06-12 at 17:02 -0500, Scott Wood wrote:
>>> It was branching to the cleanup part of the non-bolted handler,
>>> which would have been bad if there were any chips with tlbsrx.
>>> that use the bolted handler.
>>
>> Still relevant ? It doesn't apply anymore :-)

It's still relevant -- I'll respin.

-Scott
