Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46E1B1A0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 08:06:05 +1000 (EST)
Date: Tue, 3 Jun 2014 08:06:04 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] powerpc/powernv: Enable POWER8 doorbell IPIs
Message-ID: <20140603080604.1ab0a86b@kryten>
In-Reply-To: <1401692223-28337-2-git-send-email-mikey@neuling.org>
References: <1401692223-28337-1-git-send-email-mikey@neuling.org>
 <1401692223-28337-2-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> This patch enables POWER8 doorbell IPIs on powernv.
> 
> Since doorbells can only IPI within a core, we test to see when we
> can use doorbells and if not we fall back to XICS.  This also enables
> hypervisor doorbells to wakeup us up from nap/sleep via the LPCR
> PECEDH bit.
> 
> Based on tests by Anton, the best case IPI latency between two
> threads dropped from 894ns to 512ns.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Thanks Mikey!

Tested-by: Anton Blanchard <anton@samba.org>

Anton
