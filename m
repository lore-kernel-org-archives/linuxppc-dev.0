Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSJjQ2ZpbzF0Q6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 10:51:54 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0PNnQ6n026976
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 18:51:51 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fqr5w263c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 18:51:51 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 25 Jan 2018 23:51:49 -0000
Subject: Re: [PATCH v2 07/13] ocxl: Add AFU interrupt support
To: Greg KH <gregkh@linuxfoundation.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 mpe@ellerman.id.au, alastair@au1.ibm.com
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
 <20180123113148.6024-8-fbarrat@linux.vnet.ibm.com>
 <20180125130703.GA8576@kroah.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 26 Jan 2018 10:51:42 +1100
MIME-Version: 1.0
In-Reply-To: <20180125130703.GA8576@kroah.com>
Message-Id: <8add9b8f-033b-0b67-de83-68bc42b46468@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/01/18 00:07, Greg KH wrote:
> On Tue, Jan 23, 2018 at 12:31:42PM +0100, Frederic Barrat wrote:
>> --- /dev/null
>> +++ b/drivers/misc/ocxl/afu_irq.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Copyright 2017 IBM Corp.
> 
> What year is it again?
> 
> :)

It was 2017 when the code was written! :D

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
