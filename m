Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0133.outbound.protection.outlook.com [157.56.110.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 922F31A024F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 03:48:25 +1100 (AEDT)
Message-ID: <1444150089.5336.283.camel@freescale.com>
Subject: Re: [PATCH v2 13/25] powerpc/8xx: also use r3 in the ITLB miss in
 all situations
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 6 Oct 2015 11:48:09 -0500
In-Reply-To: <5613D6C5.1030100@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <94728e239cad2224383db7ddc1c57df7d11561eb.1442939410.git.christophe.leroy@c-s.fr>
 <20150929000039.GG6161@home.buserror.net> <5613D6C5.1030100@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-06 at 16:12 +0200, Christophe Leroy wrote:
> Le 29/09/2015 02:00, Scott Wood a écrit :
> > On Tue, Sep 22, 2015 at 06:50:54PM +0200, Christophe Leroy wrote:
> > > We are spending between 40 and 160 cycles with a mean of 65 cycles
> > > in the TLB handling routines (measured with mftbl) so make it more
> > > simple althought it adds one instruction
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > ---
> > > No change in v2
> > > 
> > >   arch/powerpc/kernel/head_8xx.S | 15 ++++-----------
> > >   1 file changed, 4 insertions(+), 11 deletions(-)
> > Why is this a separate patch from 1/25?
> > 
> > Same comments as on that patch.
> > 
> > 
> Just because here there is no real need behind the simplification of the 
> code, whereas the first one was a pre-requisite for the following patch.
> Should I merge them together anyway ?

If there's no real need, why do it?  It's not really a major readability 
enhancement...

-Scott
