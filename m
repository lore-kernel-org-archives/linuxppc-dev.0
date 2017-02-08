Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ2FY4z6GzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 11:31:29 +1100 (AEDT)
In-Reply-To: <20170207050317.GA10303@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/powernv: Remove separate entry for OPAL real mode
 calls
Message-Id: <3vJ2FY3XKCz9s73@ozlabs.org>
Date: Wed,  8 Feb 2017 11:31:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-07 at 05:03:17 UTC, Paul Mackerras wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> All entry points already read the MSR so they can easily do
> the right thing.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/ab9bad0ead9ab179ace09988a3f1cf

cheers
