Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFF41vSzDrK7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:53 +1000 (AEST)
In-Reply-To: <1502473125-4849-1-git-send-email-bhumirks@gmail.com>
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: drivers/macintosh: make wf_control_ops and wf_pid_param const
Message-Id: <3xXTFF34j3z9t5R@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-11 at 17:38:45 UTC, Bhumika Goyal wrote:
> Make wf_control_ops const as they are only stored in the ops field of a
> wf_control structure, which is const.
> Make wf_pid_param const as they are only used during a copy operation.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ad35f6e2864d9b52fe9705ede1730

cheers
