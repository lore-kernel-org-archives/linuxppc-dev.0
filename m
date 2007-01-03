Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC2B0DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 20:59:20 +1100 (EST)
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Simon Vallet <linux-ppc@castalie.org>
In-Reply-To: <20070103080151.214ebb62@mlejnas.priv.castalie.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
	<1167770486.6165.70.camel@localhost.localdomain>
	<20070103080151.214ebb62@mlejnas.priv.castalie.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 20:58:12 +1100
Message-Id: <1167818293.6165.143.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-03 at 08:01 +0100, Simon Vallet wrote:
> On Wed, 03 Jan 2007 07:41:26 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > BTW. What is this evil^H^H^H^Hbinary driver you are talking about ?
> 
> Yes, blobs are evil, but a binary driver is still better than no driver
> at all...
> 
> I'm working on the unicorn driver for the BeWan ADSL PCI card -- the
> card manufacturer does not seem willing to provide the relevant info
> (I'm not really aware of the specifics -- Sven Luther will probably
> know more about this). Besides, much of the functionality of the card
> is implemented in software, so a 100% open-source driver would probably
> require a lot of work.
> 
> Last but not least I wanted to dig a bit into binary formats anyway ;-)

Doh ! I've been in "contact" with that driver in a previous life... it's
a whole bunch of horrid C++ with windows wrappers all over... or did
they improve it ? It's still an ST chip ?

Ben.
