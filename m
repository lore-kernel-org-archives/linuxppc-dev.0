Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A64FB6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Mar 2011 07:34:45 +1100 (EST)
Subject: Re: [PATCH] powerpc: perf: Handle events that raise an exception
	without overflowing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20110316125053.GA7387@elte.hu>
References: <20110309143842.6c22845e@kryten> <20110316125053.GA7387@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 07:34:26 +1100
Message-ID: <1300307666.22236.1179.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>, acme@ghostprotocols.net,
	a.p.zijlstra@chello.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-16 at 13:50 +0100, Ingo Molnar wrote:
> * Anton Blanchard <anton@samba.org> wrote:
> 
> > 
> > Events on POWER7 can roll back if a speculative event doesn't
> > eventually complete. Unfortunately in some rare cases they will
> > raise a performance monitor exception. We need to catch this to
> > ensure we reset the PMC. In all cases the PMC will be 256 or less
> > cycles from overflow.
> > 
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> > Cc: stable@kernel.org
> > ---
> > 
> > I would prefer not to add the PVR check, but I think we want to limit
> > this workaround to POWER7. Would a cpu feature be preferable?
> 
> There was no objection from the PowerPC folks so i'll send this fix Linuswards, ok?

Ah yes.

Ack.

Cheers,
Ben.
