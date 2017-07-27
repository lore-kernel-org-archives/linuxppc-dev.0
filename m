Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBLz4qLszDrGy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:37:15 +1000 (AEST)
In-Reply-To: <0b7273a9720afeea6a42a10f38ebb09b6489adc3.1493381148.git.geliangtang@gmail.com>
To: Geliang Tang <geliangtang@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/pseries: use memdup_user_nul
Message-Id: <3xJBLz3ptlz9s1h@ozlabs.org>
Date: Thu, 27 Jul 2017 22:37:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-04-29 at 01:45:15 UTC, Geliang Tang wrote:
> Use memdup_user_nul() helper instead of open-coding to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3783225130f01ea86fc0ee477a0e72

cheers
