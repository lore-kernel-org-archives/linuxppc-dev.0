Return-Path: <geert@linux-m68k.org>
Received: from yorgi.telenet-ops.be (yorgi.telenet-ops.be [195.130.133.69])
	by ozlabs.org (Postfix) with ESMTP id 50306DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 19:22:36 +1000 (EST)
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id 12B84681554
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 11:22:34 +0200 (CEST)
Date: Fri, 30 May 2008 11:22:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <20080530102706.56fca248@siona.local>
Message-ID: <Pine.LNX.4.64.0805301120510.26332@anakin>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
	<20080527214241.GA22636@parisc-linux.org>
	<1211926636.3286.100.camel@pasglop>
	<20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
	<1212110003.15633.0.camel@pasglop>
	<20080530080700.773a82cc@siona.local>
	<1212132267.15633.69.camel@pasglop>
	<20080530102706.56fca248@siona.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, tpiepho@freescale.com,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 May 2008, Haavard Skinnemoen wrote:
> Maybe we need another interface that does not do byteswapping but
> provides stronger ordering guarantees?

The byte swapping depends on the device/bus.

So what happened to the old idea of putting the accessor function pointers
in the device/bus structure?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
