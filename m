Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44E12DDF93
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 09:13:30 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6PNDRbP028073
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 19:13:27 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6PNCBWa189140
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 19:12:11 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6PNCA3J030464
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 19:12:11 -0400
Date: Fri, 25 Jul 2008 19:08:38 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC] 4xx hardware watchpoint support
Message-ID: <20080725190838.27c227bc@zod.rchland.ibm.com>
In-Reply-To: <1217021937.11188.110.camel@pasglop>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
	<20080723115321.53aa655b@zod.rchland.ibm.com>
	<1216829442.5727.97.camel@gargoyle>
	<1216958433.11188.70.camel@pasglop>
	<C786174A-78C1-40B6-ABC9-24E7419FA182@kernel.crashing.org>
	<83A1F423-1C8B-405D-9118-D9BB51A8AA94@kernel.crashing.org>
	<1217021937.11188.110.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>, Christoph
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 26 Jul 2008 07:38:57 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Josh pointed out that you went ahead and merged this.  Curse you :)
> > 
> > I've got a patch in my tree to address my initial concerns.
> 
> Well, I asked Josh on IRC and he was fine, I got your email too late.

I was (and still am) OK with it.  Kumar's comments are valid but not
major for 44x.  Some cleanup could be done, but I was more focused on
getting it in during this merge window.

I think we just had a small case of bad timing.  I blame conferences
and late nights of beer^H^H^H^Hcoding.

josh
