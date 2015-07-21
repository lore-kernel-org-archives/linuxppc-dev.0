Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DC41A0072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 15:50:12 +1000 (AEST)
Message-ID: <1437457811.30722.8.camel@ellerman.id.au>
Subject: Re: [PATCH V3 2/2] kprobes: Mark OPTPROBES na for powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 masami.hiramatsu.pt@hitachi.com, mingo@kernel.org,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Tue, 21 Jul 2015 15:50:11 +1000
In-Reply-To: <20150720134103.GA9691@gate.crashing.org>
References: <20150720105349.24801.64387.stgit@thinktux.in.ibm.com>
 <20150720105417.24801.66440.stgit@thinktux.in.ibm.com>
 <20150720134103.GA9691@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-20 at 08:41 -0500, Segher Boessenkool wrote:
> On Mon, Jul 20, 2015 at 04:24:22PM +0530, Ananth N Mavinakayanahalli wrote:
> > There is a potential gain to be had with a direct
> > jump instead of a breakpoint, but the caveats need to be traded off
> > with the complexity it brings in.
> > 
> > For now, mark OPTPROBES na for powerpc.
> 
> If we haven't yet investigated whether this feature is something beneficial
> to the powerpc kernel, it should just stay as TODO, not be marked as n/a.

Yep, agreed. As discussed in the other thread we'll leave this as TODO until we
know it's either not a win or not worth the complexity.

cheers
