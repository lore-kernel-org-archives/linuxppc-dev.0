Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 143D1DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 06:10:05 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] powerpc: introduce "slices" (aka. meta-segments)
Date: Thu, 15 Feb 2007 20:09:58 +0100
References: <1171528608.20192.264.camel@localhost.localdomain>
In-Reply-To: <1171528608.20192.264.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702152009.58367.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 February 2007 09:36, Benjamin Herrenschmidt wrote:
> =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05
> =A0arch/powerpc/kernel/asm-offsets.c | =A0 16 -
> =A0arch/powerpc/mm/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01
> =A0arch/powerpc/mm/hash_utils_64.c =A0 | =A0 =A04
> =A0arch/powerpc/mm/hugetlbpage.c =A0 =A0 | =A0514 -----------------------=
=2D-------------
> =A0arch/powerpc/mm/mmu_context_64.c =A0| =A0 =A04
> =A0arch/powerpc/mm/slb.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11
> =A0arch/powerpc/mm/slb_low.S =A0 =A0 =A0 =A0 | =A0 50 ++-
> =A0arch/powerpc/mm/slice.c =A0 =A0 =A0 =A0 =A0 | =A0517 +++++++++++++++++=
+++++++++++++++++++++
> =A0include/asm-powerpc/mmu.h =A0 =A0 =A0 =A0 | =A0 12
> =A0include/asm-powerpc/paca.h =A0 =A0 =A0 =A0| =A0 =A02
> =A0include/asm-powerpc/page_64.h =A0 =A0 | =A0 83 ++----
> =A012 files changed, 625 insertions(+), 594 deletions(-)

I tried to review your patch, but I found it hard because of the amount of
code that that just gets moved from hugetlbpage.c to slice.c. Could you
send the next version of as two patches, with one of them only moving the
code without changing it?

	Arnd <><
