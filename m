Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 87870B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 07:46:46 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix __flush_icache_range on 44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090817160713.GE8710@zod.rchland.ibm.com>
References: <20090817134136.GB8710@zod.rchland.ibm.com>
	<20090817160713.GE8710@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 07:46:28 +1000
Message-Id: <1250545588.4861.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-17 at 12:07 -0400, Josh Boyer wrote:
> 
> Olof pointed out that we could probably do the iccci before the icbi loop and
> just skip that loop entirely on 44x.  This is most certainly valid, but at
> this particular moment I don't have time to try and reproduce the issue with
> an alternative fix and I wanted to get _something_ out there to fix the issue.  
> 
> I suck for that, I know.

Well, I can massage your patch if you want. The fact is, the icbi loop
and iccci are definitely redundant :-)

Cheers,
Ben.
