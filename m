Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A86867B32
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 10:10:36 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113090515.12012.65.camel@baythorne.infradead.org>
References: <1112594783.26086.22.camel@gaston>
	<1113064594.4636.28.camel@localhost.localdomain>
	<1113089830.9518.444.camel@gaston>
	<1113090515.12012.65.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 10:07:01 +1000
Message-Id: <1113091621.9518.450.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: iBook G3 owners
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-04-10 at 00:48 +0100, David Woodhouse wrote:
> On Sun, 2005-04-10 at 09:37 +1000, Benjamin Herrenschmidt wrote:
> > Make sure you have the 2 cpufreq related patches though, there are
> > issues with CPU voltage possibly not correct on wakeup that can cause
> > similar problems.
> 
> It was those I originally applied after cpufreq stopped working. Sleep
> hasn't worked reliably since then. I've built a kernel without any of
> the four patches, and if that works I'll test some more to work out
> precisely which one makes the difference.

Can you check that you have the very latest versions of these patches ?
I updated them a couple of time since I posted the message...

Ben.
