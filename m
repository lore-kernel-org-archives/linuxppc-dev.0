Return-Path: <stewart@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BqFw5hPBzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 17:00:20 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5M6x3vh097119
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 03:00:18 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jrp9fkhg1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 03:00:17 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Fri, 22 Jun 2018 03:00:16 -0400
From: Stewart Smith <stewart@linux.ibm.com>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Document issues with the DAWR on POWER9
In-Reply-To: <20180622061452.19016-1-mikey@neuling.org>
References: <20180622061452.19016-1-mikey@neuling.org>
Date: Fri, 22 Jun 2018 17:00:11 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87woure26c.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  Documentation/powerpc/DAWR-POWER9.txt | 58 +++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/powerpc/DAWR-POWER9.txt

Acked-by: Stewart Smith <stewart@linux.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
