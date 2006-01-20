Return-Path: <wim@iguana.be>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.5.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17E00689D5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 22:56:08 +1100 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0KBtr0k011362
	for <linuxppc-embedded@ozlabs.org>; Fri, 20 Jan 2006 12:55:54 +0100
	(envelope-from <wim@iguana.be>)
Date: Fri, 20 Jan 2006 12:55:43 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
Message-ID: <20060120115543.GA6174@infomag.infomag.iguana.be>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
	<1137664156.8471.16.camel@localhost.localdomain>
	<20060119164811.GB4418@dmt.cnet>
	<1137708739.8471.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137708739.8471.69.camel@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, Kumar Gala <galak@gate.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

> On Iau, 2006-01-19 at 14:48 -0200, Marcelo Tosatti wrote:
> > On Thu, Jan 19, 2006 at 09:49:16AM +0000, Alan Cox wrote:
> > > 
> > > 	f = open("/dev/watchdog", O_RDWR);
> > > 	fork();
> > > 	while(1) {
> > > 		write(f, "Boing", 5);
> > > 	}
> > 
> > Oops.
> > 
> > At least 50% of the watchdog drivers rely solely on the "wdt_is_open"
> > atomic variable and are broken with respect to synchronization.
> 
> What an excellent janitors project

I'll have a look at it from a global point of view.

Greetings,
Wim.
