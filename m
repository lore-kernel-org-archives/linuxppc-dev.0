Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBh1H7jzDvyP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:12 +1100 (AEDT)
In-Reply-To: <20161117050747.18250-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
 Russell Currey <ruscur@russell.cc>
Subject: Re: powerpc/eeh: Refactor EEH PE reset functions
Message-Id: <3tPxBg6cdWz9t0Z@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-17 at 05:07:47 UTC, Russell Currey wrote:
> eeh_pe_reset and eeh_reset_pe are two different functions in the same
> file which do mostly the same thing.  Not only is this confusing, but
> potentially causes disrepancies in functionality, notably eeh_reset_pe
> as it does not check return values for failure.
> 
> Refactor this into the following:
> 
>  - eeh_pe_reset(): stays as is, performs a single operation, exported
>  - eeh_pe_reset_full(): new, full reset process that calls eeh_pe_reset()
>  - eeh_reset_pe(): removed and replaced by eeh_pe_reset_full()
>  - eeh_reset_pe_once(): removed
> 
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6654c9368a6ff75a36230d8eb94676

cheers
