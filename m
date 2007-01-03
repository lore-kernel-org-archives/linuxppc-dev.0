Return-Path: <linux-ppc@castalie.org>
Received: from tloen.castalie.org (tloen.castalie.org [213.41.240.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 451A8DDED0
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 18:01:59 +1100 (EST)
Date: Wed, 3 Jan 2007 08:01:51 +0100
From: Simon Vallet <linux-ppc@castalie.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
Message-ID: <20070103080151.214ebb62@mlejnas.priv.castalie.org>
In-Reply-To: <1167770486.6165.70.camel@localhost.localdomain>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
	<1167770486.6165.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 03 Jan 2007 07:41:26 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> BTW. What is this evil^H^H^H^Hbinary driver you are talking about ?

Yes, blobs are evil, but a binary driver is still better than no driver
at all...

I'm working on the unicorn driver for the BeWan ADSL PCI card -- the
card manufacturer does not seem willing to provide the relevant info
(I'm not really aware of the specifics -- Sven Luther will probably
know more about this). Besides, much of the functionality of the card
is implemented in software, so a 100% open-source driver would probably
require a lot of work.

Last but not least I wanted to dig a bit into binary formats anyway ;-)

Simon
