Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FpJf4x9wzF1Cl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 13:28:02 +1000 (AEST)
Message-ID: <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Finn Thain
 <fthain@telegraphics.com.au>, geert@linux-m68k.org
Cc: Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 27 Jun 2018 13:27:37 +1000
In-Reply-To: <874lhp6i4d.fsf@concordia.ellerman.id.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
 <874lhp6i4d.fsf@concordia.ellerman.id.au>
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

On Wed, 2018-06-27 at 13:08 +1000, Michael Ellerman wrote:
> > I will rewrite patch 10/12 after Arnd's fixes and this series have all 
> > made their way through both powerpc and m68k trees, and submit it 
> > separately.
> 
> drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
> series is high on his todo list.

We need at least to pull out a couple of powerbooks we have sitting in
drawers and try it out.

> 
> Should it just go in via the m68k tree?
> 
> Or I can create a topic branch to share it between ppc and m68k?
