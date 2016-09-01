Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQJcS3xbczDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 09:39:03 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u81NX44Z086213
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 19:39:02 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 256b6987j5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Sep 2016 19:39:02 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 2 Sep 2016 09:38:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 229463578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 09:38:58 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u81NcvNP61407450
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2016 09:38:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u81NcvpP023076
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2016 09:38:57 +1000
Subject: Re: [PATCH 1/3] powerpc/sparse: Make a bunch of things static
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
References: <1472772381-22696-1-git-send-email-dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 2 Sep 2016 09:38:55 +1000
MIME-Version: 1.0
In-Reply-To: <1472772381-22696-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9988ac7d-a1d8-c425-1661-17d3b23d563c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/09/16 09:26, Daniel Axtens wrote:
> Squash a bunch of sparse warnings by making things static.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> -struct irq_domain *iic_get_irq_host(int node)
> +static struct irq_domain *iic_get_irq_host(int node)
>  {
>  	return iic_host;
>  }

Should probably get rid of the symbol export here too.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
