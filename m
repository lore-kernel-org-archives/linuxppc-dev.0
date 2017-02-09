Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzCQ2vCNzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:17:54 +1100 (AEDT)
In-Reply-To: <20170203004316.25291-1-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: Documentation: powerpc/fsl: Update compatible for l2cache binding
Message-Id: <3vJzCQ1N7Cz9s7H@ozlabs.org>
Date: Fri, 10 Feb 2017 00:17:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-03 at 00:43:16 UTC, Chris Packham wrote:
> List all the current valid compatible strings for the l2cache binding.
> This should stop checkpatch.pl from complaining and will hopefully save
> someone from having to debug a typo in their dts.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/de55ce0de94b5daa804f69aa6ede79

cheers
