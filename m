Return-Path: <ego@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8knM37fKzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 16:29:27 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 18 May 2016 00:29:24 -0600
Date: Wed, 18 May 2016 11:59:18 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] powerpc/powernv: Move idle code usable by
 multiple hardware to common location
Message-ID: <20160518062917.GC3939@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-4-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462263878-25237-4-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On Tue, May 03, 2016 at 01:54:32PM +0530, Shreyas B. Prabhu wrote:
> CPU-idle related code like context save/restore functions idle_power7.S
> can reused for adding stop instruction support. Move this
> code to a new commonly accessible location.

[..snip..]

> diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
> new file mode 100644
> index 0000000..05954ae
> --- /dev/null
> +++ b/arch/powerpc/kernel/idle_power_common.S

Since the new file is derived from idle_power7.S, you should add a
comment here to indicate that this shares the copyright history with
the original file.

--
Thanks and Regards
gautham.
