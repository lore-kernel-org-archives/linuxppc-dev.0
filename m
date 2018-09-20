Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SS6BrlzF37B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:20:56 +1000 (AEST)
In-Reply-To: <1533070557-24432-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org, rashmicy@gmail.com
Subject: Re: powerpc/selftests: Wait all threads to join
Message-Id: <42G3SS4kCvz9sCP@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-31 at 20:55:57 UTC, Breno Leitao wrote:
> Test tm-tmspr might exit before all threads stop executing, because it just
> waits for the very last thread to join before proceeding/exiting.
> 
> This patch makes sure that all threads that were created will join before
> proceeding/exiting.
> 
> This patch also guarantees that the amount of threads being created is equal
> to thread_num.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/693b31b2fc1636f0aa7af53136d3b4

cheers
