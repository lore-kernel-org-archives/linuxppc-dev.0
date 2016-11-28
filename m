Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5Gv5Ms1zDt3c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:15:19 +1100 (AEDT)
In-Reply-To: <5f8659707d87126507e163dcada64c6f8923933e.1479913108.git.geliangtang@gmail.com>
To: Geliang Tang <geliangtang@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/eeh/of: use builtin_platform_driver
Message-Id: <3tS5Gv0w0tz9vFp@ozlabs.org>
Date: Mon, 28 Nov 2016 23:15:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-23 at 14:58:56 UTC, Geliang Tang wrote:
> Use builtin_platform_driver() helper to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> Acked-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ebb242d56bbe14af6ea25cf5e45440

cheers
