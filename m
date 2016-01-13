Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2BE31A08A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 00:09:27 +1100 (AEDT)
In-Reply-To: <1452647072-23321-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com
Subject: Re: powerpc/powernv: Fix OPAL_CONSOLE_FLUSH prototype and usages
Message-Id: <20160113130926.E84741409A0@ozlabs.org>
Date: Thu, 14 Jan 2016 00:09:26 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-01 at 01:04:32 UTC, Russell Currey wrote:
> The recently added OPAL API call, OPAL_CONSOLE_FLUSH, originally took no
> parameters and returned nothing.  The call was updated to accept the
> terminal number to flush, and returned various values depending on the
> state of the output buffer.
> 
> The prototype has been updated and its usage in the OPAL kmsg dumper has
> been modified to support its new behaviour as an incremental flush.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c88c5d43732a0356f99e5e4d1a

cheers
