Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkmpx6QJhzDqvK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 13:44:56 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u663d8mZ040770
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 23:44:54 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240n49fr6n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 23:44:54 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 6 Jul 2016 13:44:52 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0D93E3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 13:44:49 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u663imtX1573132
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 13:44:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u663im7k003690
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 13:44:48 +1000
Subject: Re: [PATCH 01/14] powerpc/powernv: Split cxl code out into a separate
 file
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-2-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 6 Jul 2016 13:44:47 +1000
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-2-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c70cdeaf-e8b0-d2c7-6eed-4d252bf9103b@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/16 23:21, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The support for using the Mellanox CX4 in cxl mode will require
> additions to the PHB code. In preparation for this, move the existing
> cxl code out of pci-ioda.c into a separate pci-cxl.c file to keep things
> more organised.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> +++ b/arch/powerpc/platforms/powernv/pci-cxl.c
> @@ -0,0 +1,163 @@
> +/*
> + * Copyright 2015 IBM Corp.

If you end up spinning a V2 of this, could probably put "2015, 2016" on 
there.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
