Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1tfB14mYzDrYD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 23:01:21 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBKBxK4r130138
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 07:01:19 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eypy61edb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 07:01:18 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 12:01:16 -0000
Subject: Re: [PATCH 09/13] ocxl: Add trace points
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <7a59e8575bcb8c2de4a68be688fb2a4d0699d61b.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <CAOFm3uGpELv+X+DdESofnFqQZDw7V4TcCg3v5NHX3cVCFxQP_A@mail.gmail.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 13:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAOFm3uGpELv+X+DdESofnFqQZDw7V4TcCg3v5NHX3cVCFxQP_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <88b0e4c6-1f9e-0c92-bf95-000c73dd700c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/12/2017 à 17:48, Philippe Ombredanne a écrit :
>> --- /dev/null
>> +++ b/drivers/misc/ocxl/trace.h
>> @@ -0,0 +1,189 @@
>> +/*
>> + * Copyright 2017 IBM Corp.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
> Would you mind using the new SPDX tags documented in Thomas patch set
> [1] rather than this legalese?

ok, it will be in the next revision. Thanks!

   Fred
