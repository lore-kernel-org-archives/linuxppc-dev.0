Return-Path: <geert@linux-m68k.org>
Received: from yergi.telenet-ops.be (yergi.telenet-ops.be [195.130.132.36])
	by ozlabs.org (Postfix) with ESMTP id C2685DDECA
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 17:46:42 +1000 (EST)
Received: from wilson.telenet-ops.be (unknown [195.130.132.42])
	by yergi.telenet-ops.be (Postfix) with ESMTP id 2587D71271B
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 09:47:00 +0200 (CEST)
Date: Mon, 9 Jun 2008 09:46:22 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now 
In-Reply-To: <E1K5NE9-000275-2M@jdl.com>
Message-ID: <Pine.LNX.4.64.0806090942230.25145@anakin>
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
	<fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
	<20080606115347.GC472@cs181133002.pp.htv.fi>
	<20080606085601.623ef866@vader.jdub.homelinux.org>
	<fa686aa40806060753i76b1d652ldd2bb99f5406dab@mail.gmail.com>
	<18506.31325.899081.47718@cargo.ozlabs.ibm.com>
	<E1K5NE9-000275-2M@jdl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Adrian Bunk <bunk@kernel.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 8 Jun 2008, Jon Loeliger wrote:
> > Grant Likely writes:
> > 
> > > Oh, and we're going try to create the longest acked-by chain in
> > > Linux history.
> > 
> > Cool :)
> > 
> > Paul.
> 
> So far, I think it looks like this, sorted:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Becky Bruce <becky.bruce@freescale.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Jochen Friedrich <jochen@scram.de>
> Acked-by: Jon Loeliger <jdl@freescale.com>
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> Acked-by: Scott Wood <scottwood@freescale.com>
> Acked-by: Sean MacLennan <smaclennan@pikatech.com>
> Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
> Acked-by: Stefan Roese <sr@denx.de>
> Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> Acked-by: Wolfgang Denk <wd@denx.de>
> 
> I'm not sure, but I _think_ there are a few other PowerPC
> developers out there still... :-)

As there's no CHRP LongTrail support (bummer, mine died 4 years ago) left in
arch/ppc/, I don't mind you killing the whole arch/ppc/ ;-)

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
