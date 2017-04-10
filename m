Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w253G4sBmzDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:49:30 +1000 (AEST)
In-Reply-To: <1491801875-25733-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>
Subject: Re: powerpc/powernv: Fix powernv Kconfig dependencies
Message-Id: <3w253G36Fzz9sDG@ozlabs.org>
Date: Tue, 11 Apr 2017 08:49:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-10 at 05:24:35 UTC, Alistair Popple wrote:
> The patch to introduce address translation services for Nvlink2 uses
> MMU notifiers. However usage of MMU notifiers requires a Kconfig
> option which is not selected by default on powerpc so add it to the
> powernv Kconfig.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/abfe8026b505d66dad7a3e5ebe7235

cheers
