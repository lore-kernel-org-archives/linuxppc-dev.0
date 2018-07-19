Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNph4YjBzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:07:40 +1000 (AEST)
In-Reply-To: <1531346584-9157-1-git-send-email-eleon@ele0n.de>
To: Daniel Klamt <eleon@ele0n.de>, benh@kernel.crashing.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org, paulus@samba.org,
 Daniel Klamt <eleon@ele0n.de>, Bjoern Noetel <bjoern@br3ak3r.de>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Replaced msleep(x) with msleep(OPAL_BUSY_DELAY_MS)
Message-Id: <41WNph2Dpxz9s9F@ozlabs.org>
Date: Thu, 19 Jul 2018 16:07:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-11 at 22:03:04 UTC, Daniel Klamt wrote:
> Replaced msleep(x) with with msleep(OPAL_BUSY_DELAY_MS)
> to diocument these sleep is to wait for opal.
> 
> Signed-off-by: Daniel Klamt <eleon@ele0n.de>
> Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c3250a127901c93b23723dc5859c7

cheers
