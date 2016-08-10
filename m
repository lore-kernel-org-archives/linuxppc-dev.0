Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8KNb55qPzDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 15:25:19 +1000 (AEST)
Date: Tue, 9 Aug 2016 22:25:13 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: 4.8.0-rc1: Invalid memory access at $SRR0: 0140f86c $SRR1:
 00003030
In-Reply-To: <87inv9te2n.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.DEB.2.20.14.1608092224220.8131@trent.utfs.org>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
 <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
 <1470743530.3015.38.camel@kernel.crashing.org>
 <87inv9te2n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 10 Aug 2016, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > On Tue, 2016-08-09 at 02:06 -0700, Christian Kujau wrote:
> >> On Mon, 8 Aug 2016, Christian Kujau wrote:
> >> > 
> >> > while trying to upgrade this PowerBook G4 from 4.7-rc7 to 4.8-rc1,
> >> > it's 
> >> > unable to boot the Yaboot (v1.3.16 from Debian/stable) boot loader:
> >
> > There should already be a fix for that:
> >
> > http://patchwork.ozlabs.org/patch/654560/
> >
> > It should be in Michael's tree if not already in Linus.
> 
> That fix is in rc1, so this must be a different bug.

Does the git bisect help?

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/147278.html

Thanks,
Christian.
-- 
BOFH excuse #8:

static buildup
