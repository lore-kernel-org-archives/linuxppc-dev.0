Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GGZD46bTzF1Dg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 07:41:24 +1000 (AEST)
In-Reply-To: <1529523316-25027-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: powerpc: Wire up io_pgetevents
Message-Id: <41GGZD2sbZz9s29@ozlabs.org>
Date: Thu, 28 Jun 2018 07:41:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-06-20 at 19:35:16 UTC, Breno Leitao wrote:
> Wire up io_pgetevents system call on powerpc.
> 
> io_pgetevents is a new syscall to read asynchronous I/O events from the
> completion queue.
> 
> Tested with libaio branch aio-poll[1] and the io_pgetevents test (#22) passed
> on both ppc64 LE and BE modes.
> 
> [1] https://pagure.io/libaio/branch/aio-poll
> 
> CC: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b2f82565f2caa1a5c1a26e68593eae

cheers
