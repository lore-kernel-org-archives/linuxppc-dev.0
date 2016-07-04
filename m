Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdyB5wdTzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:32:18 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjdyB2RC1z9sCg
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:32:17 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u647O3Fk035813
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 03:32:16 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23xa4btngx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Jul 2016 03:32:16 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 4 Jul 2016 17:32:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1DC8D2BB0059
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:32:11 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u647WAYN8913178
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 17:32:10 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u647WAZb006736
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 17:32:10 +1000
Subject: Re: [PATCH 5/6] powerpc/sparse: Pass endianness to sparse
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
 <1467616182-30886-5-git-send-email-dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 4 Jul 2016 17:32:09 +1000
MIME-Version: 1.0
In-Reply-To: <1467616182-30886-5-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5db87034-fde1-a007-8f2a-a102c8f1e743@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/16 17:09, Daniel Axtens wrote:
> Explicitly give sparse an endianness in the Makefile, so that it
> doesn't get confused.
>
> Normally we have #ifdef one and #else the other, so it doesn't usually
> matter, but we have been bitten by it before, and indeed this patch
> fixes a number of sparse errors.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
