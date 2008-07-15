Return-Path: <SRS0+19936fab061860b7d9a6+1787+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1D4CDE5C8
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 00:18:02 +1000 (EST)
Subject: Re: 2.6.26 does not boot on Pegasos
From: David Woodhouse <dwmw2@infradead.org>
To: benh@kernel.crashing.org
In-Reply-To: <1216116349.7740.101.camel@pasglop>
References: <20080715100033.GA5147@iram.es> <1216116349.7740.101.camel@pasglop>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 07:17:52 -0700
Message-Id: <1216131472.27455.240.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 20:05 +1000, Benjamin Herrenschmidt wrote:
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

I'm away from home for the next couple of weeks, but can test when I get
home after OLS. I've run relatively recent kernels on Pegasos within the
last 2-3 weeks.

-- 
dwmw2
