Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4111EDE0F7
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 08:00:25 +1100 (EST)
Subject: Re: [PATCH 00/18] ide: warm-plug support for IDE devices and other
	goodies
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20080212114905.GA9940@iram.es>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<1202460043.7079.157.camel@pasglop>  <20080212114905.GA9940@iram.es>
Content-Type: text/plain
Date: Wed, 13 Feb 2008 07:59:52 +1100
Message-Id: <1202849992.7410.19.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-12 at 12:49 +0100, Gabriel Paubert wrote:
> On Fri, Feb 08, 2008 at 07:40:43PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > On Fri, 2008-02-08 at 01:44 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > - couple of fixes and preparatory patches
> > > 
> > > - rework of PowerMac media-bay support ([un]register IDE devices instead of
> > >   [un]registering IDE interface) [ it is the main reason for spamming PPC ML ]
> > 
> > Interesting... I was thinking about doing a full remove of the device at
> > a higher level instead but I suppose what you propose is easier.
> 
> Well, I have serious problem on a Pegasos which appeared some time
> between 2.6.24 and 2.6.25-rc1: at boot I get an infinite string of 
> 
> hdb: empty DMA table?
> 
> I'm trying to bisect it right now.

Pegasos doesn't use the pmac ide which is what we were discussing. It
uses a VIA IDE which uses a normal PRD table. So something else must
have broken...

Ben.
