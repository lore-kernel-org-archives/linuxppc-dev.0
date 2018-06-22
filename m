Return-Path: <stewart@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BqHL5FVxzF12j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 17:01:34 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5M6xGu8124919
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 03:01:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jrphqtsnd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 03:01:26 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Fri, 22 Jun 2018 01:01:24 -0600
From: Stewart Smith <stewart@linux.ibm.com>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Document issues with TM on POWER9
In-Reply-To: <20180622061452.19016-2-mikey@neuling.org>
References: <20180622061452.19016-1-mikey@neuling.org>
 <20180622061452.19016-2-mikey@neuling.org>
Date: Fri, 22 Jun 2018 17:01:19 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tvpve24g.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:
> +POWER9C DD1.2 and above are only avaliable with POWERNV and hence

PowerVM, not POWERNV


-- 
Stewart Smith
OPAL Architect, IBM.
