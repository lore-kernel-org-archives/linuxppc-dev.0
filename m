Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9zB332xzDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:42 +1000 (AEST)
In-Reply-To: <1467695057-12431-21-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [20/41] powerpc/mm/hash64: Don't test for machine type to detect
 HEA special case
Message-Id: <3rw9zB204Gz9snm@ozlabs.org>
Date: Thu, 21 Jul 2016 21:09:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:56 UTC, Benjamin Herrenschmidt wrote:
> Instead, check for FW_FEATURE_SPLPAR. This should be roughtly equivalent
> as all pseries machiens that can have an HEA also support SPLPAR and
> no other machine type does.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2b4e3ad8f5790cae6e0356c5fc

cheers
