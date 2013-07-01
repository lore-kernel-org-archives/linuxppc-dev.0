Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 95EB72C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 08:59:37 +1000 (EST)
Message-ID: <1372719568.18612.162.camel@pasglop>
Subject: Re: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 02 Jul 2013 08:59:28 +1000
In-Reply-To: <1372718200.8183.96@snotra>
References: <1372718200.8183.96@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-07-01 at 17:36 -0500, Scott Wood wrote:
> I'll send it tonight after I verify no obvious breakage.
> 
> I realize it's late, but I wasn't involved until a few weeks ago, and  
> there was a large backlog (of which I've only been able to get through  
> a portion so far).  Most of what I have gone through was done in the  
> past week -- I wasn't just holding on to it.

Sure, I know :-) Just saying for next time ... I prefer a regular trickle
to a big batch too late.

Cheers,
Ben.
