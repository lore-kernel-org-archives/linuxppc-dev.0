Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPhwK3PpqzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 04:50:09 +1100 (AEDT)
Message-ID: <1458064205.12370.29.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org, Christophe
 Leroy <christophe.leroy@c-s.fr>, chenhui.zhao@freescale.com
Date: Tue, 15 Mar 2016 12:50:05 -0500
In-Reply-To: <1458032847.10733.1.camel@ellerman.id.au>
References: <20160312031535.GA24351@home.buserror.net>
 <1458001168.8059.3.camel@ellerman.id.au>
 <1458025311.12370.18.camel@buserror.net>
 <1458032847.10733.1.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-15 at 20:07 +1100, Michael Ellerman wrote:
> On Tue, 2016-03-15 at 02:01 -0500, Scott Wood wrote:
> > On Tue, 2016-03-15 at 11:19 +1100, Michael Ellerman wrote:
> > > On Fri, 2016-03-11 at 21:15 -0600, Scott Wood wrote:
> > > >       powerpc/mpc85xx: Add CPU hotplug support for E6500
> > > 
> > > And this one breaks with old binutils (<= 2.22) because of:
> > > 
> > >   arch/powerpc/kernel/head_64.S:210: Error: Unrecognized opcode: `mttmr'
> > > 
> > > If you're happy to break the build on older bintuils for those configs
> > > then
> > > that's OK with me.
> > 
> > I'm not too bothered, but it's also an easy fix -- patch sent.
> 
> Thanks. Do you want to add it to your branch, or I can apply it after I
> merge
> your branch?

If you want to just apply them that'd be fine.

-Scott
