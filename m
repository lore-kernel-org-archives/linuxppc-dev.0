Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3116B679E6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 09:48:07 +1000 (EST)
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060510172443.GF3878@localhost>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
	<20060510172443.GF3878@localhost>
Content-Type: text/plain
Date: Thu, 11 May 2006 09:48:00 +1000
Message-Id: <1147304880.32448.84.camel@localhost.localdomain>
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

On Wed, 2006-05-10 at 19:24 +0200, Wolfgang Pfeiffer wrote:
> On Wed, May 10, 2006 at 06:04:13PM +0200, Johannes Berg wrote:
> > > As to the reason why I came here:
> > > As I can't be sure whether the issue announced in the subject line is
> > > really a kernel issue
> > 
> > Did it ever work? 
> 
> Not with Debian, but with this Ubuntu live CD I have sound: 
> Ubuntu 6.06 "Dapper Drake" Beta 2 powerpc (20060427)
> 
> The kernel on their CD is a 2.6.15-21-powerpc

Dapper kernel has the hack to consider it as a toonie. No volume control
nor anything.

> > I don't quite know what machine a 5,8 is since I have a
> > 5,6 only. 
> 
> 
> 5.8 is, IINM, the last PPC 15" Powerbook that Apple made
> 
> > Also, try snd-aoa.
> 
> With the git kernel mentioned in my previous mail there's no snd-aoa
> available, IINM. I'll try figure out how to get the source and compile
> another kernel with this driver ...

It's not merged upstream yet.

Ben.
