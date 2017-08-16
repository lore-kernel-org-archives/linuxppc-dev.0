Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFC44v2zDrJp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:51 +1000 (AEST)
In-Reply-To: <1501704846-22625-2-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: [v3,2/2] powerpc/xmon: Disable tracing when entering xmon
Message-Id: <3xXTFC2HSHz9t42@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 20:14:06 UTC, Breno Leitao wrote:
> If tracing is enabled and you get into xmon, the tracing buffer
> continues to be updated, causing possible loss of data and unnecessary
> tracing information coming from xmon functions.
> 
> This patch simple disables tracing when entering xmon, and re-enables it
> if the kernel is resumed (with 'x').
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ed49f7fd6438dcc8c93fa7d1d7d815

cheers
