Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68A81679EA
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 22:04:53 +1000 (EST)
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1147348702.9630.7.camel@johannes>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
	<1147304824.32448.82.camel@localhost.localdomain>
	<1147348702.9630.7.camel@johannes>
Content-Type: text/plain
Date: Thu, 11 May 2006 22:04:46 +1000
Message-Id: <1147349086.20614.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-11 at 13:58 +0200, Johannes Berg wrote:
> On Thu, 2006-05-11 at 09:47 +1000, Benjamin Herrenschmidt wrote:
> 
> > Same as mine, it works fine with snd-aoa
> 
> I should build a database with a machine string -> user* mapping... This
> means that even my brother has this one and it works great with snd-aoa
> as far as I know :)
> 
> Though, since the alsa userspace libs absolutely *SUCK* no program I
> know of can properly represent the mixer controls except maybe amixer...
> I'd hate to work around this in the kernel, but the alsa libs are such
> complex beasts that I have a feeling they won't be fixed.

kmix looks approx. ok

> Anyone up to inventing a new mixer API that uses sysfs? ;)
> 
> johannes
