Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD0901A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:13:08 +1100 (AEDT)
In-Reply-To: <1447908285-14637-2-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org,
 sam.bobroff@au1.ibm.com
Subject: Re: [v2,
 1/2] powerpc/tm: Block signal return setting invalid MSR state
Message-Id: <20151126121308.627F114016A@ozlabs.org>
Date: Thu, 26 Nov 2015 23:13:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-19-11 at 04:44:44 UTC, Michael Neuling wrote:
> Currently we allow both the MSR T and S bits to be set by userspace on
> a signal return.  Unfortunately this is a reserved configuration and
> will cause a TM Bad Thing exception if attempted (via rfid).

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d2b9d2a5ad5ef04ff978c992

cheers
