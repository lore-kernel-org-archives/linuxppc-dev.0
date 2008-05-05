Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62D2DDDEE7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 09:42:03 +1000 (EST)
Subject: Re: [PATCH] Sam440ep support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080505135404.5c57720e@zod.rchland.ibm.com>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<20080505135404.5c57720e@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 06 May 2008 09:40:05 +1000
Message-Id: <1210030805.21644.118.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Giuseppe Coviello <cjg@cruxppc.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-05 at 13:54 -0500, Josh Boyer wrote:
> > +arch_initcall(sam440ep_i2c_of_init);
> 
> Ok, now I'm confused as to why you aren't doing this in your platform
> file (which would make it specific, and therefore justify its
> existence.

I addition, that gets called on all platforms, not only sam440ep, which
is wrong.

Ben.
