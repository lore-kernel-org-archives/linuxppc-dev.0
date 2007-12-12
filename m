Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6A8FFDDE47
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 18:18:01 +1100 (EST)
Date: Wed, 12 Dec 2007 01:23:10 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2] [POWERPC] pasemi: Implement MSI support
Message-ID: <20071212072310.GA3173@lixom.net>
References: <20071212063406.GA786@lixom.net> <20071212064446.GB786@lixom.net>
	<1197442179.24356.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1197442179.24356.3.camel@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 05:49:39PM +1100, Michael Ellerman wrote:
> Before the ugliness spreads .. I'm pretty sure we can get this from the
> chip_data of the virq - I haven't fixed it though because I wasn't sure
> if using chip_data was kosher or not.

Hmm, maybe.

I can forsee MSI and legacy interrupts being handled by different irq
hosts on systems where they are cascaded, so I'm not 100% sure that's a
workable way to do it (I assume you'd look it up through the pci_dev's
legacy irq field, right?).


-Olof
