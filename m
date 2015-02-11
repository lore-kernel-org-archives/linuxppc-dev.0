Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48A4F1A054F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 15:50:26 +1100 (AEDT)
Message-ID: <1423630220.5965.2.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/boot: don't clobber r6 and r7 in epapr boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 15:50:20 +1100
In-Reply-To: <54DADA1B.4060009@ozlabs.org>
References: <1423570510.219346.759068385066.4.gpush@pablo>
 <1423620585.5891.22.camel@kernel.crashing.org>
 <54DADA1B.4060009@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-11 at 12:27 +0800, Jeremy Kerr wrote:
> Hi Ben,
> 
> > You might want to also remove the use of r8 and r9 which are supposed
> > to contain the OPAL entry and base for debugging purposes. We would also
> > have to restore them before booting the kernel.
> 
> I'd prefer that to be a separate change, if that's okay - it'd require
> us to change the kentry prototype, and would percolate to epapr_platform
> init too.

Ok.

Ben.
