Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 00DA0B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2012 07:49:02 +1100 (EST)
Subject: Re: [PATCH] powerpc/mm: Fix parse_arg build error
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326431115-425-1-git-send-email-msm@freescale.com>
Date: Fri, 13 Jan 2012 14:45:31 -0600
Message-Id: <AD686389-E2D8-49C6-9443-FF3B33775469@kernel.crashing.org>
References: <1326431115-425-1-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 12, 2012, at 11:05 PM, Matthew McClintock wrote:

> This fixes this build issue:
>=20
> arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages':
> arch/powerpc/mm/hugetlbpage.c:312:2: error: implicit declaration of =
function 'parse_args'
> make[1]: *** [arch/powerpc/mm/hugetlbpage.o] Error 1
>=20
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> This is for benh next tree
>=20
> arch/powerpc/mm/hugetlbpage.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

This is fixed upstream, benh's tree is based on a older snapshot of =
linus's tree that doesn't have this fix.

commit 13020be8be2d5843c3810169cdbcc51f07ff020f
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Thu Nov 24 09:40:07 2011 +0000

    powerpc: Fix compiliation with hugetlbfs enabled

- k=
