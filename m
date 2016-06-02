Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL4ZP6t8KzDqhZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 21:22:21 +1000 (AEST)
Received: from pps.filterd (m0082756.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u52BLbJF015655
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 07:22:19 -0400
Message-Id: <201606021122.u52BLbJF015655@mx0a-001b2d01.pphosted.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23ag2m6ryv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 07:22:19 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 08:22:17 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id ADCCF1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 07:22:07 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u52BMES214876980
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 08:22:14 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u52BMEqY018504
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 08:22:14 -0300
Subject: Re: [PATCH 1/3] powerpc: export cpu_to_core_id()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
 <1464853260.19646.6.camel@ellerman.id.au>
 <201606020900.u528tQHH025445@mx0a-001b2d01.pphosted.com>
 <1464865393.11826.0.camel@ellerman.id.au>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 2 Jun 2016 08:22:11 -0300
MIME-Version: 1.0
In-Reply-To: <1464865393.11826.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2016 08:03 AM, Michael Ellerman wrote:
> Can you send me a v2 with a change log that includes all that detail.

Sure; should have done it. Thanks.


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
