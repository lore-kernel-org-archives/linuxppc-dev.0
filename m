Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57AAD1A0064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 09:04:36 +1100 (AEDT)
Message-ID: <1414447475.1913.1.camel@concordia>
Subject: Re: powerpc: Replace __get_cpu_var uses
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2014 09:04:35 +1100
In-Reply-To: <1414444233.364.192.camel@pasglop>
References: <alpine.DEB.2.11.1410211520470.20253@gentwo.org>
 <alpine.DEB.2.11.1410271055380.18104@gentwo.org>
 <1414444233.364.192.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Christoph Lameter <cl@linux.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-28 at 08:10 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2014-10-27 at 10:57 -0500, Christoph Lameter wrote:
> > Ping? We are planning to remove support for __get_cpu_var in the
> > 3.19 merge period. I can move the definition for __get_cpu_var into the
> > powerpc per cpu definition instead if we cannot get this merged?
> 
> Yes, yes, I know, we should merge that, Michael, can you still throw
> that in ?

For 3.18, nah. We didn't even see it until after the merge window had closed.

I realise they're all fairly simple translations, but it's too big and too easy
for one of them to be wrong.

I'm happy to put it in a topic branch for 3.19, or move the definition or
whatever, your choice Christoph.

cheers
