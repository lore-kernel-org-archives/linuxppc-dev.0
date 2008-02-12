Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 5CC50DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 23:30:07 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 12 Feb 2008 13:30:03 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 00/18] ide: warm-plug support for IDE devices and other
	goodies
Message-ID: <20080212123002.GA11000@iram.es>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<1202460043.7079.157.camel@pasglop> <20080212114905.GA9940@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080212114905.GA9940@iram.es>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 12:49:05PM +0100, Gabriel Paubert wrote:
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

Argh, the first bisect point ended up with timeouts on hdb...

Flagged as bad, to try to see when the problems started, but 
I suspect that there are several.

	Gabriel
