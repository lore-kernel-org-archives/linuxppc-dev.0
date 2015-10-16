Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id A38AF1A0762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 12:54:51 +1100 (AEDT)
Date: Fri, 16 Oct 2015 10:47:06 +0900
From: Simon Horman <horms@verge.net.au>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/3] ppc64: Fix warnings
Message-ID: <20151016014706.GE20667@verge.net.au>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 06, 2015 at 05:55:48PM -0500, Scott Wood wrote:
> Produce a warning-free build on ppc64 (at least, when built as 64-bit
> userspace -- if a 64-bit binary for ppc64 is a requirement, why is -m64
> set only on purgatory?).  Mostly unused (or write-only) variable
> warnings, but also one nasty one where reserve() was used without a
> prototype, causing long long arguments to be passed as int.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Thanks, applied.

I would have slightly preferred one-patch per problem.
