Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qDgJ31VQzF10l
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 19:55:56 +1000 (AEST)
In-Reply-To: <20180518013742.24095-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, sam@mendozajonas.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: powepc: Clear PCR on boot
Message-Id: <40qDgJ229mz9s31@ozlabs.org>
Date: Mon, 21 May 2018 19:55:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-18 at 01:37:42 UTC, Michael Neuling wrote:
> Clear the PCR on boot to ensure we are not running in a compat mode.
> 
> We've seen this cause problems when a crash (and kdump) occurs while
> running compat mode guests. The kdump kernel then runs with the PCR
> set and causes problems. The symptom in the kdump kernel (also seen in
> petitboot after fast-reboot) is early userspace programs taking
> sigills on newer instructions (seen in libc).
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: <stable@vger.kernel.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/faf37c44a105f3608115785f17cbbf

cheers
