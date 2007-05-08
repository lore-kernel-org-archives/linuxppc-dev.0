Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D68B5DDDFE
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 01:23:26 +1000 (EST)
Message-ID: <464095DF.8050600@freescale.com>
Date: Tue, 08 May 2007 10:23:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 03/13] Document the sleep property.
References: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
	<20070507182944.GB26920@ld0162-tx32.am.freescale.net>
	<20070508021149.GE12613@lixom.net>
In-Reply-To: <20070508021149.GE12613@lixom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Mon, May 07, 2007 at 01:29:44PM -0500, Scott Wood wrote:
>>+   The first cell of a sleep node is a phandle to the sleep controller.
>>+   The remaining cells are interpreted by said controller.  In the case
>>+   of an fsl,mpc83xx-pmc sleep controller, the second cell represents the
>>+   bits to clear in SCCR to stop the device's clock.
> 
> The second part here is completely implementation-dependent. I don't
> really see the need to document that in this global document?

In this document, not necessarily (I like David's suggestion of a wiki). 
   It should be documented somewhere, though, so one doesn't have to dig 
through Linux source code to write code for another OS that supports the 
binding.

-Scott
