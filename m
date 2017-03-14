Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjDnl05DrzDrDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:39:22 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2ECckG8092209
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 08:39:12 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 296f3vn9nq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 08:39:12 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 09:39:09 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2ECd6rw38797466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:39:07 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2ECd6Q3006361
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:39:06 -0300
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Update iommu table base on
 ownership change
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <20170221024131.47753-1-aik@ozlabs.ru>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Tue, 14 Mar 2017 09:39:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170221024131.47753-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3f5d0a44-0520-3e87-dbfd-6888ddc35902@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2017 11:41 PM, Alexey Kardashevskiy wrote:
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

P.S.: sorry, late, but for the record.


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
