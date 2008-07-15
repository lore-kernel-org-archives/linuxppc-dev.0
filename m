Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id D61C5DE228
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 21:01:26 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 15 Jul 2008 12:45:52 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.26 does not boot on Pegasos
Message-ID: <20080715104552.GA6299@iram.es>
References: <20080715100033.GA5147@iram.es> <1216116349.7740.101.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216116349.7740.101.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 08:05:49PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-15 at 12:00 +0200, Gabriel Paubert wrote:
> > 	Hi,
> > 
> > I just tried to boot 2.6.26 on a Pegasos and the kernel does not boot.
> > The last message I have is:
> > gunzip (0xffffffff <----- some more hex digits)
> > 
> > The configuration has been created from a working 2.6.25 one with
> > make oldconfig and answering N to new config options.
> > 
> > Anybody has seen this or do I have to start digging deeper?
> 
> Unfortunately, I don't have a pegasos anymore. David, did you get a
> chance to test anything recent on yours ? Matt ?

I seem to remember that 2.6.26-rc5 booted fine. Compiling it right now
before I start a bisection.

	Regards,
	Gabriel
