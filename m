Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKhXr5MnfzDqZW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 06:19:40 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u51KJ7bn031218
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 16:19:38 -0400
Message-Id: <201606012019.u51KJ7bn031218@mx0a-001b2d01.pphosted.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 239u0gkxn2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jun 2016 16:19:38 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 1 Jun 2016 17:19:36 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id D543C1DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 16:19:27 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u51KJYLp30736716
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 17:19:34 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u51KJYoY016997
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 17:19:34 -0300
Received: from [9.80.219.199] ([9.80.219.199])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u51KJWv1016942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 17:19:33 -0300
Subject: Re: [PATCH 1/3] powerpc: export cpu_to_core_id()
To: linuxppc-dev@lists.ozlabs.org
References: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 1 Jun 2016 17:19:28 -0300
MIME-Version: 1.0
In-Reply-To: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please ignore the 'PATCH 1/3' in the subject; this is a single patch.


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
