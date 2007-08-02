Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB766DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 02:56:19 +1000 (EST)
Date: Thu, 2 Aug 2007 11:56:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] lite5200b: flash definition in dts
Message-ID: <20070802165610.GA5364@ld0162-tx32.am.freescale.net>
References: <20070619095408.GK23294@moe.telargo.com>
	<20070801065203.GK4529@moe.telargo.com>
	<fa686aa40708010541n4d4900cfv7042d6ca685416d1@mail.gmail.com>
	<20070802055830.GM4529@moe.telargo.com>
	<fa686aa40708012323p2eca4b05pd47acac635cf6370@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40708012323p2eca4b05pd47acac635cf6370@mail.gmail.com>
Cc: Domen Puncer <domen.puncer@telargo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2007 at 12:23:31AM -0600, Grant Likely wrote:
> On the other hand there is PCI whose control registers fall within the
> SoC range; but the memory windows absolutely do not.  If my flash
> argument holds water, then where does that leave PCI which kind of
> straddles the fence.

IMHO, PCI should be split into a bus node that sits outside the SoC, and
a control node that sits inside, with phandles between the two.

-Scott
