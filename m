Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzS2cL7zDvs2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:08 +1100 (AEDT)
In-Reply-To: <1478148061-5724-2-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: [2/2] selftests/powerpc: Fail load_unaligned_zeropad on miscompare
Message-Id: <3tHTzS0T4hz9t2N@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-11 at 04:41:01 UTC, Michael Ellerman wrote:
> If the result returned by load_unaligned_zeropad() doesn't match what we
> expect we should fail the test!
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/997e200182347d2cc7e37bc43eaafe

cheers
