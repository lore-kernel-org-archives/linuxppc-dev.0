Return-Path: <srs0=oy2m=fq=au1.ibm.com=andrew.donnellan@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zn0fg0cP2zF185
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:47:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zn0ff5hvQz8sxb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:47:22 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zn0ff1Sh8z9sW9
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 14:47:21 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1M3hkfg067537
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 22:47:20 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g9fusv1ps-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 22:47:19 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 22 Feb 2018 03:47:18 -0000
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
To: Balbir Singh <bsingharora@gmail.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
 Greg KH <gregkh@linuxfoundation.org>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <1519255934.2867.3.camel@au1.ibm.com>
 <CAKTCnzmmUGPNk1ggpWYQjiDLcAR_c7cqdZyPU+6rKGC6AcNW7A@mail.gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 14:47:11 +1100
MIME-Version: 1.0
In-Reply-To: <CAKTCnzmmUGPNk1ggpWYQjiDLcAR_c7cqdZyPU+6rKGC6AcNW7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <76092e30-6959-942c-3600-95fb933eada8@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/02/18 14:41, Balbir Singh wrote:
>> Setting it to 0 is for the reader, not the compiler. I'm not clear on
>> the benefit of starting the version at 1, could you clarify?
> 
> How do I distinguish between version number never set and 0?

The ioctl won't exist without a version number set.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
