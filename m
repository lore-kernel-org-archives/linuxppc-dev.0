Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KfSW31JDzF1LQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 19:48:11 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w639iOpP141878
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2018 05:48:08 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k04xcd1vr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 05:48:08 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 3 Jul 2018 05:48:06 -0400
Date: Tue, 3 Jul 2018 15:17:59 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 stewart@linux.vnet.ibm.com, benh@kernel.crashing.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com,
 mpe@ellerman.id.au
Subject: Re: [PATCH v3 2/2] powernv/cpuidle: Use parsed device tree values
 for cpuidle_init
Reply-To: ego@linux.vnet.ibm.com
References: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1530609656-13301-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530609656-13301-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <20180703094759.GB24693@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Akshay,

On Tue, Jul 03, 2018 at 02:50:56PM +0530, Akshay Adiga wrote:
> Export pnv_idle_states and nr_pnv_idle_states so that its accessible to
> cpuidle driver. Use properties from pnv_idle_states structure for powernv
> cpuidle_init.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---

[..snip..]

> 
>  		/*
>  		 * For nap and fastsleep, use default target_residency
>  		 * values if f/w does not expose it.
>  		 */

This comment can also go, since we are no longer hard-coding the
residency values in the kernel.

Otherwise looks good to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


--
Thanks and Regards
gautham.
