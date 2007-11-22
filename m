Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6ACE2DDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 10:37:24 +1100 (EST)
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20071118004729.67824247F1@gemini.denx.de>
References: <20071118004729.67824247F1@gemini.denx.de>
Content-Type: text/plain
Date: Fri, 23 Nov 2007 10:37:05 +1100
Message-Id: <1195774625.6970.145.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-11-18 at 01:47 +0100, Wolfgang Denk wrote:
> In message <9e4733910711141834n2bfb1742v5637c56e27e26f5a@mail.gmail.com> you wrote:
> >
> > > * The documentation is only available under NDA, a problem for open
> > > source debuggers.
> > 
> > This is what we need. I would like it specifically for the mpc5200.
> > But we want to use it in OpenOCD so NDA won't work.
> 
> It doesn't work. Been  there  a  logn  time  ago.  It's  and  endless
> fingerpointing.  Freescale  (by  then:  Motorola)  says  they  cannot
> release any information because of their contracts with IBM, and vice
> versa.

It seems like AMCC does provide the necessary infos for 4xx processors
though. Jon, do you think what they provide is enough to use an open
source debugger ?

Ben.
