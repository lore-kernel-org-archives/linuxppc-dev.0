Return-Path: <macro@linux-mips.org>
Received: from pollux.ds.pg.gda.pl (pollux.ds.pg.gda.pl [153.19.208.7])
	by ozlabs.org (Postfix) with ESMTP id DD099DDE17
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 00:05:24 +1000 (EST)
Date: Wed, 4 Apr 2007 14:43:19 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
Sender: macro@blysk.ds.pg.gda.pl
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <Pine.LNX.4.64.0704040903470.20803@anakin>
Message-ID: <Pine.LNX.4.64N.0704041436130.19559@blysk.ds.pg.gda.pl>
References: <20070404022544.59b022a6@the-village.bc.nu>
	<17939.10130.687893.167511@cargo.ozlabs.ibm.com>
	<1175663999.2932.8.camel@shinybook.infradead.org>
	<20070403.225006.119275067.davem@davemloft.net>
	<Pine.LNX.4.64.0704040903470.20803@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, David Miller <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Apr 2007, Geert Uytterhoeven wrote:

> > > I don't see why that 'should' be the case. Certainly it _isn't_ the case
> > > on most supported platforms -- we have separate device numbers, and
> > > names, for most types of ports. There's only one or two drivers which
> > > abuse ttySn for anything other than 8250 ports.
> > 
> > sunsu, sunzilog, pmac_zilog, sunsab, etc.
> 
> amiserial.
> 
> > The list is longer than you think.  In fact the convention is
> > very well established.
> 
> And I guess the recently revived Atari serial driver, too.

 And also DEC hardware, i.e. zs (which drives Zilog ports too) and dz 
(which handles integrated to the various extent clones of the original 
PDP-11 serial multiplexer ;-) ).

  Maciej
