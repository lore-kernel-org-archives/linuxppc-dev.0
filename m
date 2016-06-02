Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL1Xx0VD9zDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:05:52 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5295nAr001178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 05:05:50 -0400
Message-Id: <201606020905.u5295nAr001178@mx0a-001b2d01.pphosted.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23a4fx3ec2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 05:05:50 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 06:05:41 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9FB08352006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 05:05:23 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5295cQn4690126
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 06:05:38 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5295cFG025747
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 06:05:38 -0300
Subject: Re: [PATCH 1/3] powerpc: export cpu_to_core_id()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
 <1464853260.19646.6.camel@ellerman.id.au>
 <201606020900.u528tPo9035094@mx0a-001b2d01.pphosted.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 2 Jun 2016 06:05:35 -0300
MIME-Version: 1.0
In-Reply-To: <201606020900.u528tPo9035094@mx0a-001b2d01.pphosted.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2016 06:00 AM, Mauricio Faria de Oliveira wrote:
> I actually use topology_core_id() from  <kernel/topology.h> in lpfc [1]

Er, <linux/topology.h> .. kinda early here :)


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
