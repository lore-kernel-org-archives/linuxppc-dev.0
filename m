Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 3E6DADDED7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 08:00:10 +1100 (EST)
Date: Wed, 4 Feb 2009 21:59:41 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] Add platform support for AmigaOne
Message-ID: <20090204205941.GB17771@iram.es>
References: <20090202212139.69160@gmx.net> <20090202213910.258290@gmx.net>
	<1233719407.16867.164.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233719407.16867.164.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 04, 2009 at 02:50:07PM +1100, Benjamin Herrenschmidt wrote:
> 
> > + hose->first_busno = bus_range ? bus_range[0] : 0;
> > + hose->last_busno = bus_range ? bus_range[1] : 0xff;
> > +
> > + setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc, 0);
> 
> Minor in the context of amigaone but still... the above should come from
> the device-tree... I suppose those are really just IO space addresses
> cf8 and cfc, in which case, an option is to call that first:

Hmm, the first is feC...,the other one feE..., 2Mbytes apart.

I don't know the hardware but I've never seen something like that.
Of course a typo is always a possibility...

	Gabriel
