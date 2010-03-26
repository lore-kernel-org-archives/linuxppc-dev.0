Return-Path: <wolfgang@leila.ping.de>
Received: from lilly.ping.de (lilly.ping.de [83.97.42.2])
	by ozlabs.org (Postfix) with SMTP id E7EE8B7CB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Mar 2010 09:41:48 +1100 (EST)
Date: Fri, 26 Mar 2010 23:17:07 +0100
To: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Failing to get DMA working with MPC5200 (TQM5200) and CompactFlash
Message-ID: <20100326221707.GA1953@leila.ping.de>
References: <20100317051521.GA16826@feather>
	<fa686aa41003261122s7c03244bm2ffc3347263af613@mail.gmail.com>
	<20100326213202.GD5350@feather>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100326213202.GD5350@feather>
From: wolfgang@leila.ping.de (Wolfgang Wegner)
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Josh,

On Fri, Mar 26, 2010 at 02:32:02PM -0700, Josh Triplett wrote:
> On Fri, Mar 26, 2010 at 12:22:32PM -0600, Grant Likely wrote:
> > 
> > Not all CF adapters have all the pins wired up that are needed for
> > *DMA modes.  That is the most likely problem.
> 
> True, but we bought a card that specifically advertises support for
> UDMA, and says UDMA right on the card's label.
> 
> http://store.lexar.com/?productid=CF8GB-300-381

Grant was referring to the adapter, not the card!

In fact I still have to see a single CF-to-IDE adapter that does
have the wires needed for (U)DMA without me soldering them in place...

Regards,
Wolfgang
