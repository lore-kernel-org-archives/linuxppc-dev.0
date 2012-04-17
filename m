Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 36501B6FD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 15:33:13 +1000 (EST)
In-Reply-To: <1334624440.25353.18.camel@pasglop>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>	
 <CACxGe6u7EUYqyZ_8tC8PFRHwS+xq7u9+fCJk+UFbrtrV-YJFvQ@mail.gmail.com>
 <1334617419.25353.15.camel@pasglop>	
 <OFAAF4BF26.BF8400B2-ONC12579E2.008226AC-C12579E3.00005051@transmode.se>
 <1334624440.25353.18.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFE9765BBA.C01624AC-ONC12579E3.001E58A0-C12579E3.001E7F8B@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 17 Apr 2012 07:33:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2012/04/17 03:00:40:
>
> On Tue, 2012-04-17 at 02:03 +0200, Joakim Tjernlund wrote:
> >
> > If you are going to test 8xx, could you revert
> > e0908085fc2391c85b85fb814ae1df377c8e0dcb,
> > powerpc/8xx: Fix regression introduced by cache coherency rewrite ?
> >
> > It should not be needed after I fixed up the 8xx TLB code and added a
> > workaround
> > for buggy dcbX instructions.
>
> Have you actually verified that things still work after reverting it ?

Nope, I haven't moved our 8xx to 3.x. We are still on
2.4 and it works there.

 Jocke
