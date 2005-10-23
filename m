Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E600685C8
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 20:00:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rupert Eibauer <rupert@ces.ch>
In-Reply-To: <200510231136.51548.rupert@ces.ch>
References: <200510221554.03810.rupert@ces.ch>
	<17242.56232.293762.303684@cargo.ozlabs.ibm.com>
	<200510231136.51548.rupert@ces.ch>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 19:55:31 +1000
Message-Id: <1130061332.7919.63.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFT] Extended BAT features, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-10-23 at 11:36 +0200, Rupert Eibauer wrote:
> On Sunday 23 October 2005 02:39, Paul Mackerras wrote:
> > Rupert Eibauer writes:
> > 
> > > What this patch actually does:
> > > - Make CONFIG_PHYS_64BIT selectable for the 6xx family
> > 
> > Why?  What does this gain us?  
> 
> I have I/O resources there which are not reachable in 32 bit mode.
> 
> > We still can't use RAM above the 4GB point AFAICS.
> 
> Does this mean the page tables do not support 63 bit?

Not with the current code. At least not for those CPUs.

Ben.
