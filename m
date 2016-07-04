Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjds06c6yzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:27:48 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjds02W9Dz9sBm
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:27:48 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u647O13W094777
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 03:27:46 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x9mcjr2n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Jul 2016 03:27:46 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 4 Jul 2016 17:27:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 03CB73578053
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:27:40 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u647Rd8f8978868
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 17:27:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u647RdJA019260
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 17:27:39 +1000
Subject: Re: [PATCH 3/6] powerpc/xics: Fully qualify cast to silence sparse
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
 <1467616182-30886-3-git-send-email-dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 4 Jul 2016 17:27:38 +1000
MIME-Version: 1.0
In-Reply-To: <1467616182-30886-3-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c8b2b997-ffc7-94a2-f370-0b13415b9a4e@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/16 17:09, Daniel Axtens wrote:
> Make the cast fully line up with what out_rm8 expects.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
