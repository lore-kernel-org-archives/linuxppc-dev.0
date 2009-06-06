Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD0EBB70AC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 08:42:17 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13747DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 08:42:16 +1000 (EST)
Subject: Re: [RFC][PATCH v5] MPC5121 TLB errata workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20090606220723.A38DA832E416@gemini.denx.de>
References: <200903161652.09747.david.jander@protonic.nl>
	<20090606220723.A38DA832E416@gemini.denx.de>
Content-Type: text/plain
Date: Sun, 07 Jun 2009 08:42:04 +1000
Message-Id: <1244328124.31984.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Jander <david.jander@protonic.nl>,
	gunnar@genesi-usa.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-06-07 at 00:07 +0200, Wolfgang Denk wrote:
> Dear David Jander,
> 
> In message <200903161652.09747.david.jander@protonic.nl> you wrote:
> > Complete workaround for DTLB errata in e300c2/c3/c4 processors.
> > 
> > Due to the bug, the hardware-implemented LRU algorythm always goes to way
> > 1 of the TLB. This fix implements the proposed software workaround in
> > form of a LRW table for chosing the TLB-way.
> > 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > Signed-off-by: David Jander <david@protonic.nl>
> 
> What is the actual status of this patch?
> 
> Patchwork (http://patchwork.ozlabs.org/patch/24502/) says it's
> "superseded" - but by what?
> 
> I can't see such code in mainline - what happened to it?

I can see the code in mainline ... but only in the -data- TLB miss
handler, not the instruction one...

Kumar ? Shouldn't we have the workaround in both ?

Cheers,
Ben.
