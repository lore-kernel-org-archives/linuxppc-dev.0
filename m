Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DE041A0F77
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 14:26:22 +1100 (AEDT)
Message-ID: <1420687580.14988.1.camel@ellerman.id.au>
Subject: Re: powerpc: refresh mpc85xx_defconfig using "make savedefconfig"
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Thu, 08 Jan 2015 14:26:20 +1100
In-Reply-To: <CAPk1OjEfx=1yfb_GUnbdNsw9Y8QfJBeMEebSKiAqDcqwm+sLhA@mail.gmail.com>
References: <1417767462-11584-1-git-send-email-alessio.bogani@elettra.eu>
 <20141205094248.D5C9914011E@ozlabs.org>
 <CAPk1OjEfx=1yfb_GUnbdNsw9Y8QfJBeMEebSKiAqDcqwm+sLhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-07 at 09:08 +0100, Alessio Igor Bogani wrote:
> Hi Michael,
> 
> On 5 December 2014 at 10:42, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Fri, 2014-05-12 at 08:17:42 UTC, Alessio Igor Bogani wrote:
> >> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> >> ---
> >>  arch/powerpc/configs/mpc85xx_defconfig | 57 +++++++---------------------------
> >>  1 file changed, 12 insertions(+), 45 deletions(-)
> >
> > Actually I was planning on doing this in bulk for all the powerpc defconfigs.
> >
> > Someone remind me to do it late next week once most of next has gone into
> > Linus' tree.
> 
> Is there any news about this?

Nope, other than I didn't get around to doing it :)

So Scott you may as well just merge this.

cheers
