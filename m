Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CB8C1A1DDA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 18:03:31 +1000 (AEST)
In-Reply-To: <1438758511-918-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, mikey@neuling.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [v3] powerpc: Add an inline function to update POWER8 HID0
Message-Id: <20150817080331.396941402B4@ozlabs.org>
Date: Mon, 17 Aug 2015 18:03:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-08 at 07:08:31 UTC, "Gautham R. Shenoy" wrote:
> Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
> prescribes that updates to HID0 be preceded by a SYNC instruction and
> followed by an ISYNC instruction (Page 91).
> 
> Create an inline function name update_power8_hid0() which follows this
> recipe and invoke it from the static split core path.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> Tested-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e63dbd16ab7be41f5b66

cheers
