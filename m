Return-Path: <josh@joshtriplett.org>
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
	[217.70.183.194]) by ozlabs.org (Postfix) with ESMTP id 94B60B7CB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Mar 2010 09:23:42 +1100 (EST)
Date: Sun, 28 Mar 2010 15:23:28 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Failing to get DMA working with MPC5200 (TQM5200) and CompactFlash
Message-ID: <20100328222327.GB16396@feather>
References: <20100317051521.GA16826@feather>
	<fa686aa41003261122s7c03244bm2ffc3347263af613@mail.gmail.com>
	<20100326213202.GD5350@feather>
	<20100326221707.GA1953@leila.ping.de>
	<20100326225916.GA5690@feather>
	<20100327174455.1888CEAD184@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100327174455.1888CEAD184@gemini.denx.de>
Cc: Wolfgang Wegner <wolfgang@leila.ping.de>, linuxppc-dev@lists.ozlabs.org,
	Andrew Greenberg <andrew@psas.pdx.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 27, 2010 at 06:44:55PM +0100, Wolfgang Denk wrote:
> In message <20100326225916.GA5690@feather> you wrote:
> > However, according to one of our hardware hackers, Andrew Greenberg
> > (CCed), the STK5200 development breakout board for the TQM5200 *does*
> > have the DMA pins wired up correctly, at least according to its
> > schematic.  That doesn't guarantee that the board matches the schematic,
> > of course.
> 
> We tested CF cards for DMA support some time ago, and IIRC this
> included the STK5200. Situation was that only very few CF cards
> actually support DMA (even if they advertise it on the label).

How very odd and disappointing.

So a CF card might advertise DMA on its label and feature set, and
show DMA modes in hdparm's info dump, but break when actually using DMA
modes?

Do you know of any specific CF cards which *do* support DMA?

- Josh Triplett
