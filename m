Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A971F1A0519
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 15:27:08 +1100 (AEDT)
Message-ID: <54DADA1B.4060009@ozlabs.org>
Date: Wed, 11 Feb 2015 12:27:07 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 4/4] powerpc/boot: don't clobber r6 and r7 in epapr boot
References: <1423570510.219346.759068385066.4.gpush@pablo>
 <1423620585.5891.22.camel@kernel.crashing.org>
In-Reply-To: <1423620585.5891.22.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> You might want to also remove the use of r8 and r9 which are supposed
> to contain the OPAL entry and base for debugging purposes. We would also
> have to restore them before booting the kernel.

I'd prefer that to be a separate change, if that's okay - it'd require
us to change the kentry prototype, and would percolate to epapr_platform
init too.

Cheers,


Jeremy
