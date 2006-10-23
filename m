Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37369679E1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 00:47:47 +1000 (EST)
Message-ID: <453CD615.4050401@genesi-usa.com>
Date: Mon, 23 Oct 2006 16:47:49 +0200
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
References: <453771E5.4090808@bplan-gmbh.de>	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>	<453884F5.4000804@bplan-gmbh.de>	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>	<453B6A84.3050209@bplan-gmbh.de>
	<1161585371.10524.444.camel@localhost.localdomain>
In-Reply-To: <1161585371.10524.444.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Curious question.

What are you guys going to do when the PowerPC name is defunct?

Like, last month :)

Power Architecture is where it is at. The trademark is even going to
lapse. It's a bit too late for the ppc->powerpc tree breakout now,
but wouldn't it just confuse people to be using a "Power Architecture"
processor or SoC of some type, using collections of definitions from
the Power ISA 2.03 and have this "powerpc" thing pop up?

It confused me even before, because ppc and ppc64 have also been
used to support real POWER (with a capital P, O, W, E and R) processors,
and now these are lumped in with powerpc which is no better than
ppc64 in these terms?

Just flexing my marketing exec muscles, see if they work, never done
it before. Oh... *crack*.. that wasn't a good noise :]

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Benjamin Herrenschmidt wrote:
> Ok, here's a batch of comments. They go on top of the comments I sent
> about your device-tree, which you might want to make public.
> 
> Also note that the size of the patch is partially due to stale ##
> and .orig files :)
> 
> In general, one big thing is: Don't bother with re-using the arch/ppc
> code, API, .h etc... There is not enough re-use there to justify it (FEC
> driver is new, serial can easily be changed, as for USB).
> 
> * /proc/ppc64/rtas changes: we need to continue that discussion
> separately and ask for paulus point of view. I prefer /proc/powerpc
> personally with a /proc/ppc64->/proc/powerpc symlink on 64 bits machines
> only.
> 
[snip]
