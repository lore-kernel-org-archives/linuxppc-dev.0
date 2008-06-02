Return-Path: <Haavard.Skinnemoen@atmel.com>
Received: from bagnes.atmel.com (smtpeu1.atmel.com [195.65.72.27])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C475FDDEF4
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 18:18:53 +1000 (EST)
Date: Mon, 2 Jun 2008 10:11:02 +0200
From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080602101102.0d8979c5@hskinnemo-gx745.norway.atmel.com>
In-Reply-To: <Pine.LNX.4.64.0805301120510.26332@anakin>
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
	<Pine.LNX.4.64.0805301120510.26332@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, tpiepho@freescale.com, scottwood@freescale.com,
	Torvalds <torvalds@linux-foundation.org>, Linus, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 30 May 2008, Haavard Skinnemoen wrote:
> > Maybe we need another interface that does not do byteswapping but
> > provides stronger ordering guarantees?
> 
> The byte swapping depends on the device/bus.

Of course. But isn't it reasonable to assume that a device integrated
on the same silicon as the CPU is connected to a somewhat sane bus
which doesn't require any byte swapping?

> So what happened to the old idea of putting the accessor function pointers
> in the device/bus structure?

Don't know. I think it sounds like overkill to replace a simple load or
store with an indirect function call.

Haavard
