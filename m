Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6854BDDFA5
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 08:04:27 +1100 (EST)
Subject: Re: [PATCH 00/18] ide: warm-plug support for IDE devices and other
	goodies
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <1202460043.7079.157.camel@pasglop>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<1202460043.7079.157.camel@pasglop>
Content-Type: text/plain
Date: Wed, 13 Feb 2008 08:04:07 +1100
Message-Id: <1202850247.7410.24.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-02-08 at 19:40 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2008-02-08 at 01:44 +0100, Bartlomiej Zolnierkiewicz wrote:
> > - couple of fixes and preparatory patches
> > 
> > - rework of PowerMac media-bay support ([un]register IDE devices instead of
> >   [un]registering IDE interface) [ it is the main reason for spamming PPC ML ]
> 
> Interesting... I was thinking about doing a full remove of the device at
> a higher level instead but I suppose what you propose is easier.
> 
> I'll have a look & test next week hopefully.

Also, the above would have the advantage of not relying on drivers/ide
infrastructure, and thus working with libata (once somebody has ported
pmac ide to libata).

Ben.
