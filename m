Return-Path: <jchapman@katalix.com>
Received: from ptb-relay03.plus.net (ptb-relay03.plus.net [212.159.14.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D526267A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 05:47:49 +1100 (EST)
Message-ID: <42260A4F.8030205@katalix.com>
Date: Wed, 02 Mar 2005 18:47:43 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: Ron Bianco <ronb@lcsaudio.com>
References: <NCBBJPCHJLKAEAHINDCEGEJFFMAA.ronb@lcsaudio.com>
In-Reply-To: <NCBBJPCHJLKAEAHINDCEGEJFFMAA.ronb@lcsaudio.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: linuxppc tree with mv64xxx included?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ron Bianco wrote:

> I'm trying to locate the correct bitkeeper or other URL to get access to a
> linux 2.5 or 2.6 tree that includes the support for the marvell mv64xxx
> series chips.
> I've examined the emails in this list regarding related patches for clues,
> but am still confused.
> 
> Tried bk://ppc.bkbits.net/linuxppc-2.5, but there is no marvell code.

There is Marvell code in that tree. Look in drivers/net/mv64*,
arch/ppc/syslib/mv*

Some boards are already ported. See arch/ppc/platforms/*

You'll also find the Marvell code in the "mainline" at

bk://linux.bkbits.net/linux-2.6

> We downloaded a 2.4.23 kernel tree directly from the marvell website, but it
> is lacking some things like i2c for marvell, that have been discussed here.
> Was further work, existing in some other tree, based on this?

i2c and several other improvements are in queue. Check the archives for
patches.

The latest ethernet code can be obtained from
bk://farnsworth.bkbits.net/linux-2.5-mv643xx-enet

-- 
James Chapman
PGP key : http://www.katalix.com/~jchapman/pgpkey.txt
