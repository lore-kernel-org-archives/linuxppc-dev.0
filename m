Return-Path: <ego@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDT785Q2fzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 18:27:48 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 24 May 2016 02:27:45 -0600
Date: Tue, 24 May 2016 13:57:32 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH v3 2/9] powerpc/powernv: Rename idle_power7.S to
 idle_power_common.S
Message-ID: <20160524082732.GA12860@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464016722-7488-3-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464016722-7488-3-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2016 at 08:48:35PM +0530, Shreyas B. Prabhu wrote:
> idle_power7.S handles idle entry/exit for POWER7, POWER8 and in next
> patch for POWER9. Rename the file to a non-hardware specific
> name.
> 
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
