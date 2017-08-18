Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYjch30hpzDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:51:00 +1000 (AEST)
In-Reply-To: <1501697258-19220-1-git-send-email-bhumirks@gmail.com>
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
 benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: powerpc: add const to bin_attribute structures
Message-Id: <3xYjcg4ggxz9t41@ozlabs.org>
Date: Fri, 18 Aug 2017 22:50:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 18:07:38 UTC, Bhumika Goyal wrote:
> Declare bin_attribute structures as const as they are only passed as an
> argument to the function sysfs_create_bin_file. This argument is of
> type const, so declare the structure as const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8bfa42ab84910841336218265fcee9

cheers
