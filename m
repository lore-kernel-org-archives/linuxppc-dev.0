Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E327867AC7
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 14:38:17 +1000 (EST)
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20060420215514.GE25755@gate.ebshome.net>
References: <20060420210201.GA25755@gate.ebshome.net>
	<10026.1145567455@www088.gmx.net>
	<20060420215514.GE25755@gate.ebshome.net>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 14:38:05 +1000
Message-Id: <1145594285.28014.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-20 at 14:55 -0700, Eugene Surovegin wrote:
> On Thu, Apr 20, 2006 at 11:10:55PM +0200, Gerhard Pircher wrote:
> > Well, Freescale's PPC programming environment manual clearly states that
> > this will not work on G4 CPUs (74xx). Also Benjamin Herrenschmidt told me,
> > that this implementation will not work for the reasons I mentioned before. 
> > The approach I'm trying to implement was his idea, so I have to trust in
> > him.
> 
> Well, you aren't the first person who tries to run G4 with 
> CONFIG_NOT_COHERENT_CACHE. This was done before and I don't remember 
> that those people had to implement anything as complex as you are 
> trying to do.
> 
> You can try asking on #mklinux. It always better to ask people who 
> actually _did_ this :).
> 
> In fact, I just grepped 2.6 and found 
> #ifdef(CONFIG_NOT_COHERENT_CACHE) in syslib/mv64x60.c. Guess what 
> systems usually have this type of bridge? Not 4xx/8xx, that's for sure.

I think some folks tried ... and failed.

Ben.
