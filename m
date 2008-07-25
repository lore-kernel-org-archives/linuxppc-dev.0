Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A84ADDF1B
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 09:18:44 +1000 (EST)
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080725190838.27c227bc@zod.rchland.ibm.com>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
	<20080723115321.53aa655b@zod.rchland.ibm.com>
	<1216829442.5727.97.camel@gargoyle> <1216958433.11188.70.camel@pasglop>
	<C786174A-78C1-40B6-ABC9-24E7419FA182@kernel.crashing.org>
	<83A1F423-1C8B-405D-9118-D9BB51A8AA94@kernel.crashing.org>
	<1217021937.11188.110.camel@pasglop>
	<20080725190838.27c227bc@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 26 Jul 2008 09:18:24 +1000
Message-Id: <1217027904.11188.122.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 19:08 -0400, Josh Boyer wrote:
> On Sat, 26 Jul 2008 07:38:57 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > > Josh pointed out that you went ahead and merged this.  Curse you :)
> > > 
> > > I've got a patch in my tree to address my initial concerns.
> > 
> > Well, I asked Josh on IRC and he was fine, I got your email too late.
> 
> I was (and still am) OK with it.  Kumar's comments are valid but not
> major for 44x.  Some cleanup could be done, but I was more focused on
> getting it in during this merge window.
> 
> I think we just had a small case of bad timing.  I blame conferences
> and late nights of beer^H^H^H^Hcoding.

Yeah, as I said, the patch is fine (ie shouldn't break anything) and has
had plenty of review so I felt it was good to go, we can do cleanups
later. I wanted that feature in the merge window, next week would have
been too late :-)

Cheers,
Ben.
