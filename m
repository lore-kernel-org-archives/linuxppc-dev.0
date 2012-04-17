Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9393CB7005
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 11:00:47 +1000 (EST)
Message-ID: <1334624440.25353.18.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 17 Apr 2012 11:00:40 +1000
In-Reply-To: <OFAAF4BF26.BF8400B2-ONC12579E2.008226AC-C12579E3.00005051@transmode.se>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
 <CACxGe6u7EUYqyZ_8tC8PFRHwS+xq7u9+fCJk+UFbrtrV-YJFvQ@mail.gmail.com>
 <1334617419.25353.15.camel@pasglop>
 <OFAAF4BF26.BF8400B2-ONC12579E2.008226AC-C12579E3.00005051@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-17 at 02:03 +0200, Joakim Tjernlund wrote:
> 
> If you are going to test 8xx, could you revert
> e0908085fc2391c85b85fb814ae1df377c8e0dcb,
> powerpc/8xx: Fix regression introduced by cache coherency rewrite ?
> 
> It should not be needed after I fixed up the 8xx TLB code and added a
> workaround
> for buggy dcbX instructions. 

Have you actually verified that things still work after reverting it ?

Cheers,
Ben.
