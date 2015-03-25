Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DECA1A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 12:31:45 +1100 (AEDT)
Message-ID: <1427247104.29319.2.camel@ellerman.id.au>
Subject: Re: [PATCH 0/8] powerpc/8xx: Getting rid of CONFIG_8xx
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 25 Mar 2015 12:31:44 +1100
In-Reply-To: <1427244330.22867.76.camel@freescale.com>
References: <20150312152420.11C821A2425@localhost.localdomain>
 <1426203271.2772.3.camel@ellerman.id.au>
 <1427244330.22867.76.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-24 at 19:45 -0500, Scott Wood wrote:
> On Fri, 2015-03-13 at 10:34 +1100, Michael Ellerman wrote:
> > On Thu, 2015-03-12 at 16:24 +0100, Christophe Leroy wrote:
> > > Two config options exist to define powerpc MPC8xx:
> > > * CONFIG_PPC_8xx
> > > * CONFIG_8xx
> > > In addition, CONFIG_PPC_8xx also defines CONFIG_CPM1 as
> > > communication co-processor
> > > 
> > > arch/powerpc/platforms/Kconfig.cputype has contained the following
> > > comment about CONFIG_8xx item for some years:
> > > "# this is temp to handle compat with arch=ppc"
> > > 
> > > It looks like not many places still have that old CONFIG_8xx used,
> > > so it is likely to be a good time to get rid of it completely ?
> > > 
> > > Patchset is composed of the following patches:
> > > [1/8] powerpc: replace CONFIG_8xx by CONFIG_PPC_8xx
> > > [2/8] um: replace CONFIG_8xx by CONFIG_PPC_8xx
> > > [3/8] video: replace CONFIG_8xx by CONFIG_PPC_8xx
> > > [4/8] net: freescale: replace CONFIG_8xx by CONFIG_PPC_8xx
> > > [5/8] tty: cpm_uart: replace CONFIG_8xx by CONFIG_CPM1
> > > [6/8] mtd: replace CONFIG_8xx by CONFIG_PPC_8xx
> > > [7/8] isdn: replace CONFIG_8xx by CONFIG_PPC_8xx
> > > [8/8] powerpc: get rid of CONFIG_8xx
> > > 
> > > All but the last one are independant and can be applied in any
> > > order. Only the 8th one requires the first 7 patches to be applied.
> > 
> > Sounds good.
> > 
> > I only see 0, 4 and 7 on linuxppc-dev for some reason.
> 
> I see them all in linuxppc-dev patchwork.

Odd.

> > You'll need to collect ACKs, or get the individual patches merged, and then we
> > can take patch 8 through the powerpc tree once those are all in - probably for
> > 4.2.
> 
> It looks like CONFIG_8xx is used a lot more than CONFIG_PPC_8xx, so it
> would be less churn to get rid of the latter (plus, we also have
> CONFIG_4xx, CONFIG_6xx, etc).  The only use of PPC_8xx I see outside
> arch/powerpc is in drivers/watchdog/Kconfig.

Yeah fine by me.

cheers
