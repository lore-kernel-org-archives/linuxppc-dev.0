Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fW2Db7zDqBR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:15 +1000 (AEST)
In-Reply-To: <1458036852-11993-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V2] powernv/hmi: Use the "unknown" checkstop type as a fallback
Message-Id: <3qk8fW0BXsz9t3b@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-15-03 at 10:14:12 UTC, Russell Currey wrote:
> The HMI code knows about three types of errors: CORE, NX and UNKNOWN.
> If OPAL were to add a new type, it would not be handled at all since
> there is no fallback case.  Instead of explicitly checking for UNKNOWN,
> treat any checkstop type without a handler as unknown.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f8a25db47ebc11fe228735d916

cheers
