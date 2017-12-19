Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1LCG3j6nzDx5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 01:39:38 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBJEdBUW095466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 09:39:36 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ey1k3twmc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 09:39:35 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 19 Dec 2017 14:39:30 -0000
Subject: Re: [PATCH 13/13] ocxl: add MAINTAINERS entry
To: Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <44bdca7f352748a658840889d6e6f52561b4a987.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <1513613052.31581.84.camel@perches.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 15:39:26 +0100
MIME-Version: 1.0
In-Reply-To: <1513613052.31581.84.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d34f6347-c8b8-b5e4-a90c-25289a6e6df5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/12/2017 à 17:04, Joe Perches a écrit :
>> +OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
>> +M:	Frederic Barrat<fbarrat@linux.vnet.ibm.com>
>> +M:	Andrew Donnellan<andrew.donnellan@au1.ibm.com>
>> +L:	linuxppc-dev@lists.ozlabs.org
>> +S:	Supported
>> +F:	arch/powerpc/platforms/powernv/ocxl.c
>> +F:	arch/powerpc/include/asm/pnv-ocxl.h
>> +F:	drivers/misc/ocxl/
>> +F:	include/misc/ocxl*
>> +F:	include/uapi/misc/ocxl.h
>> +F:	Documentation/accelerators/ocxl.txt
>> +
> Alphabetic ordering by section header please...
> 
> Maybe CXL - OCXL ...


Sure, I'll fix it. Thanks!

   Fred
