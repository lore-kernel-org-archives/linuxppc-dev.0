Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv0HN3z6FzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 10:50:40 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5N0mwW8108147
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 20:50:38 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8k2y4h8m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 20:50:37 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 20:50:36 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Invalidate ERAT on powersave wakeup for POWER9
In-Reply-To: <20170622172616.7598-1-mikey@neuling.org>
References: <20170622172616.7598-1-mikey@neuling.org>
Date: Fri, 23 Jun 2017 10:50:23 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgojy1bk.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:
> On POWER9 the ERAT may be incorrect on wakeup from some stop states
> that lose state. This causes random segvs and illegal instructions
> when these stop states are enabled.
>
> This patch invalidates the ERAT on wakeup on POWER9 to prevent this
> from causing a problem.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

CC: stable?

-- 
Stewart Smith
OPAL Architect, IBM.
