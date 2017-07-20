Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCvGL59CPzDrJp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 23:03:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/pseries: energy driver only print message when
 LPAR guest
In-Reply-To: <20170720115900.455-1-npiggin@gmail.com>
References: <20170720115900.455-1-npiggin@gmail.com>
Date: Thu, 20 Jul 2017 23:03:21 +1000
Message-ID: <87eftbgt0m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> This driver currently reports the H_BEST_ENERGY is unsupported even
> when booting in a non-LPAR environment (e.g., powernv). Prevent it.

Just delete the printk(). Users don't know what that means, and
developers have other better ways to detect that the hcall is missing if
anyone cares.

cheers
