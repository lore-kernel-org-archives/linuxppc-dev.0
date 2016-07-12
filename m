Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpWJ25YBhzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 15:49:38 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6C5nT5L139735
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 01:49:36 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 242vjw8ufb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 01:49:36 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 12 Jul 2016 15:49:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0BAD43578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 15:49:31 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6C5nUje24248408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 15:49:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6C5nU8v006168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 15:49:30 +1000
Subject: Re: [PATCH 09/15] cxl: Add kernel APIs to get & set the max irqs per
 context
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
 <1468237822-26276-10-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 12 Jul 2016 15:48:59 +1000
MIME-Version: 1.0
In-Reply-To: <1468237822-26276-10-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4b0121e6-9921-ca58-7629-4cfc27ab500b@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/16 21:50, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> These APIs will be used by the Mellanox CX4 support. While they function
> standalone to configure existing behaviour, their primary purpose is to
> allow the Mellanox driver to inform the cxl driver of a hardware
> limitation, which will be used in a future patch.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
