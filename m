Return-Path: <ego@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9YLG6XDfzDqVm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 00:27:18 +1000 (AEST)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 19 May 2016 08:27:16 -0600
Date: Thu, 19 May 2016 19:56:18 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 paulus@ozlabs.org, linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v2 4/9] powerpc/powernv: Make power7_powersave_common
 more generic
Message-ID: <20160519142618.GB913@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-5-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160518063708.GD3939@in.ibm.com>
 <573C10E5.9000007@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <573C10E5.9000007@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2016 at 12:21:17PM +0530, Shreyas B Prabhu wrote:
> With this patch, r5 which is the third parameter to
> power_powersave_common contains the return address that needs to be
> written to SRR0. So here I'm keeping r5 unaltered and using r7 for the MSR.

Ok.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> 
> Thanks,
> Shreyas
