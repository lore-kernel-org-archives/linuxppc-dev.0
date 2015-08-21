Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 680EE1A005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 17:43:35 +1000 (AEST)
In-Reply-To: <1437544251-19016-3-git-send-email-sam.mj@au1.ibm.com>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [V4,2/2] powerpc/kexec: Reset HILE before kexec_sequence
Message-Id: <20150821074335.4B34E1402AC@ozlabs.org>
Date: Fri, 21 Aug 2015 17:43:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-22-07 at 05:50:51 UTC, Samuel Mendoza-Jonas wrote:
> On powernv secondary cpus are returned to OPAL, and will then enter
> the target kernel in big-endian. However if it is set the HILE bit
> will persist, causing the first exception in the target kernel to be
> delivered in litte-endian regardless of the current endianess.
> 
> If running on top of OPAL make sure the HILE bit is reset once we've
> finished waiting for all of the secondaries to be returned to OPAL.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e72bb8a5a884d0222311

cheers
