Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4893CDDDE0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 22:26:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mA3BPXBa007271
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 04:25:33 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA3BQHkv148576
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 04:26:17 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA3BQGlL006399
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 04:26:17 -0700
Date: Mon, 3 Nov 2008 06:26:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x
	PPC32 architectures.
Message-ID: <20081103062612.023c24fc@zod.rchland.ibm.com>
In-Reply-To: <1225673034.8004.239.camel@pasglop>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
	<48FF3889.2030304@linux.vnet.ibm.com>
	<fb412d760810311623i2b0f93a3r5aa0eb297e154b4a@mail.gmail.com>
	<20081101113018.GA13646@zod.rchland.ibm.com>
	<1225576502.8004.222.camel@pasglop>
	<20081102134153.GA1029@zod.rchland.ibm.com>
	<1225661596.8004.226.camel@pasglop>
	<20081102193307.32d17e62@zod.rchland.ibm.com>
	<1225673034.8004.239.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>,
	Hollis Blanchard <hollisb@us.ibm.com>, linuxppc-dev@ozlabs.org,
	pvr@emcraft.com, dzu@denx.de, Hollis Blanchard <hollis@penguinppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 03 Nov 2008 11:43:54 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Cropping the size of the memory node.  That was simplest to do from the
> > cuboot wrapper at the time.  If marking it reserved via a reserve map
> > is more elegant and correct, we could do that.
> > 
> > But I will still like to know what about the other way is hairy please.
> 
> I don't like it :-) Bad feeling ... don't like having a memory
> node entry that isn't aligned to some large power of two typically.

Erm, ok.  And does your heebie-geebies extend to people using the mem=
parameter in a similar fashion?

josh
