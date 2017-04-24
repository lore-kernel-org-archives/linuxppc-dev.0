Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLb2Q2NzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:35 +1000 (AEST)
In-Reply-To: <1492994114-13797-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/xmon: Deindent the SLB dumping logic
Message-Id: <3wBhLb0qjcz9s8W@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-24 at 00:35:14 UTC, Michael Ellerman wrote:
> Currently the code that dumps SLB entries uses a double-nested if. This
> means the actual dumping logic is a bit squashed. Deindent it by using
> continue.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/856736466806ceb72c7402eb0f06be

cheers
