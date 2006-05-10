Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06D9D679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 09:49:11 +1000 (EST)
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060510230811.GH3878@localhost>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
	<20060510213028.GG3878@localhost>  <20060510230811.GH3878@localhost>
Content-Type: text/plain
Date: Thu, 11 May 2006 09:49:03 +1000
Message-Id: <1147304943.32448.86.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-11 at 01:08 +0200, Wolfgang Pfeiffer wrote:
> On Wed, May 10, 2006 at 11:30:28PM +0200, Wolfgang Pfeiffer wrote:
> > On Wed, May 10, 2006 at 06:04:13PM +0200, Johannes Berg wrote:
> > 
> > > Also, try snd-aoa.
> > 
> > Impossible here, it does not compile here. Neither with gcc 4.0 or 4.1
> > 
> 
> Not being sure tho' whether the fact my source dir for the running
> kernel is cleaned up, IINM, (like "fakeroot make-kpkg clean") is the
> culprit for the failed compile ... I'll have a look into that at
> next daylight ... :)

You can't build modules with "cleaned" kernel headers.

Ben.
