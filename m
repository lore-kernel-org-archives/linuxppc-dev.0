Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0130.outbound.protection.outlook.com [207.46.100.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 674E91A027B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 02:34:12 +1000 (AEST)
Message-ID: <1431534837.3868.42.camel@freescale.com>
Subject: Re: [PATCH] powerpc/mpic: Remove WHOAMI readback after EOI
From: Scott Wood <scottwood@freescale.com>
To: Purcareata Bogdan <b43198@freescale.com>
Date: Wed, 13 May 2015 11:33:57 -0500
In-Reply-To: <55534225.1050305@freescale.com>
References: <1427193823-14597-1-git-send-email-bogdan.purcareata@freescale.com>
 <55534225.1050305@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-13 at 15:23 +0300, Purcareata Bogdan wrote:
> Ping?
> 
> On 24.03.2015 12:43, Bogdan Purcareata wrote:
> > After previous discussions regarding the subject [1][2], there's no clear
> > explanation or reason why the call was needed in the first place. The sensible
> > argument is some sort of synchronization between the CPU and the MPIC, which
> > hasn't been pointed out precisely and is no longer required (at least on BookE
> > platforms).
> >
> > The benefit of this change is saving a MMIO trap per interrupt when running in a
> > KVM guest.
> >
> > [1] https://patchwork.ozlabs.org/patch/429098/
> > [2] https://patchwork.ozlabs.org/patch/433557/
> >
> > Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
> > ---
> >   arch/powerpc/sysdev/mpic.c | 1 -
> >   1 file changed, 1 deletion(-)

Don't top-post.

This is commit 56302c53d3dc477b8360954fc92c1dfc4fc0ec54 in Linus's tree.

-Scott
