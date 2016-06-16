Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVfFh2WNHzDqnM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 20:07:36 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVfFg6778z9t1j
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 20:07:35 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5G9xweK099858
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 06:07:34 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kqshnq3p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 06:07:34 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 04:07:33 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
In-Reply-To: <20160616055746.GC22590@birch.djwong.org>
References: <20160616043340.GB22590@birch.djwong.org>
 <1466054627.5400.5.camel@ellerman.id.au>
 <20160616055746.GC22590@birch.djwong.org>
Date: Thu, 16 Jun 2016 15:37:26 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737oda1lt.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

> On Thu, Jun 16, 2016 at 03:23:47PM +1000, Michael Ellerman wrote:
>> On Wed, 2016-06-15 at 21:33 -0700, Darrick J. Wong wrote:
>> 
>> > Hi Aneesh,
>> > 
>> > I noticed when trying out 4.7-rc3 on qemu-2.5 that the kernel no longer
>> > boots.  4.6 booted just fine, so I bisected the kernel to the commit
>> > 30bda41aba4efb2370c97e2cbe7385de93ccc372, which is "powerpc/mm: Drop WIMG in
>> > favour of new constants".  The changelog suggests that the KVM changes need
>> > closer review, and here's an actual crash:
>> > 
>> > (I can send libvirt's machine xml, .config, and full dmesg if that helps.)
>> 
>> Yes please.
>> 
>> I'm successfully booting 4.7-rc's on qemu (2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.1)).
>
> Ok, see attached.  I also sent along the dpkg --status output for qemu
> and qemu-slof; looks like we're running the same Ubuntu packages...
>
> ...my host kernel is 4.6.0 on x64.

So this is Qemu TCG mode right ? I will try some test and update later.

-aneesh
