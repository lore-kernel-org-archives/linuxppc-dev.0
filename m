Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3468E67A76
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 11:31:02 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148550168.11759.0.camel@johannes.berg>
References: <1147860564.14395.6.camel@johannes>
	<446B721D.8020203@gentoo.org>  <1148034127.15507.178.camel@johannes>
	<1148169389.13249.44.camel@localhost.localdomain>
	<1148280172.6228.79.camel@johannes.berg>
	<1148422544.13249.96.camel@localhost.localdomain>
	<1148463777.11734.19.camel@johannes>
	<1148544004.13249.270.camel@localhost.localdomain>
	<1148550168.11759.0.camel@johannes.berg>
Content-Type: text/plain
Date: Fri, 26 May 2006 11:30:39 +1000
Message-Id: <1148607039.8089.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-25 at 11:42 +0200, Johannes Berg wrote:
> On Thu, 2006-05-25 at 18:00 +1000, Benjamin Herrenschmidt wrote:
> 
> > So it's bcm's fault ? Did you do a bit of analysis ? that would be
> > useful...
> 
> I kinda assumed the list was lagging again and my brother had already
> posted the solution. Yes, bcm does some measuring stuff that keeps
> interrupts disabled for lots of milliseconds (25 or something). It's
> being fixed.
> 
> I still think, however, that we ought to be able to deal with lost
> interrupts.

Oh sure, but it's also useful to have a way to find who are the bast*rds
who are causing big latencies so we can fix them :)

Ben.
