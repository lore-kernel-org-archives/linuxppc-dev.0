Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rgpK0BcCzF0tS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:22:00 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NIJblT092243
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:21:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j5a8aj7cb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:21:57 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 23 May 2018 19:21:55 +0100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Breno Leitao <leitao@debian.org>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/xmon: Also setup debugger hooks when
 single-stepping
In-Reply-To: <20180523180054.9937-1-msuchanek@suse.de>
References: <20180523180054.9937-1-msuchanek@suse.de>
Date: Wed, 23 May 2018 23:51:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877enuxmfa.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Suchanek <msuchanek@suse.de> writes:

> When single-stepping kernel code from xmon without a debug hook enabled
> the kernel crashes. This can happen when kernel starts with xmon on
> crash disabled but xmon is entered using sysrq.
>
> Call force_enable_xmon when single-stepping in xmon to install the xmon
> debug hooks.
>
> Fixes: e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
> break-point is set")
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
LGTM,

Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
