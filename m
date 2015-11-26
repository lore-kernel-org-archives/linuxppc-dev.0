Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F3A21A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:13:09 +1100 (AEDT)
In-Reply-To: <1447908285-14637-3-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org,
 sam.bobroff@au1.ibm.com
Subject: Re: [v2,2/2] powerpc/tm: Check for already reclaimed tasks
Message-Id: <20151126121309.3824D140157@ozlabs.org>
Date: Thu, 26 Nov 2015 23:13:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-19-11 at 04:44:45 UTC, Michael Neuling wrote:
> Currently we can hit a scenario where we'll tm_reclaim() twice.  This
> results in a TM bad thing exception because the second reclaim occurs
> when not in suspend mode.

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7f821fc9c77a9b01fe7b1d6e

cheers
