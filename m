Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0D67DDE42
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 07:48:11 +1000 (EST)
Message-ID: <47016B11.3070609@freescale.com>
Date: Mon, 01 Oct 2007 16:48:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: Problem with OF interrupt parsing code
References: <20071001210025.314240@gmx.net> <470165F6.7030505@freescale.com>	
	<470168B4.7090005@freescale.com> <1191274981.6310.19.camel@pasglop>
In-Reply-To: <1191274981.6310.19.camel@pasglop>
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

Benjamin Herrenschmidt wrote:
> On Mon, 2007-10-01 at 16:37 -0500, Scott Wood wrote:
>> Scott Wood wrote:
>> Actually, it doesn't -- it should stop when it sees the 
>> interrupt-controller property in the i8259 node, at which point it'll be 
>> trying to use the raw PCI IRQ pin number as an i8259 IRQ.  This is 
>> Unlikely To Work(tm).
> 
> It will work in the specific 8259 case I suppose since it gets the
> legacy 1:1 mapping... but it sucks :-)

The mapping between INTA-D and i8259 numbers isn't generally 1:1, and it 
looked as if it'd try using the former... though the code is 
sufficiently complicated that I could easily be missing something.

-Scott
