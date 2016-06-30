Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgCYs1b6HzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 18:36:17 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5U8YJpH091165
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:36:15 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09r4ua3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:36:15 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 02:36:13 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>, Darren Stevens <darren@stevens-zone.net>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Pat Wall <pjwall@mac.com>,
 Alex Perez <aperez@alexperez.com>, matthew@a-eon.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH v2 RFC] pasemi: Fix boot failure on 4.7-rc1
In-Reply-To: <CAOesGMgvNY8YBeyT3uMfD5XyQbhv0ucFtC8EVHS7gwrTmTNzGw@mail.gmail.com>
References: <4867f9385a2.1e1ca6c1@auth.smtp.1and1.co.uk>
 <CAOesGMgvNY8YBeyT3uMfD5XyQbhv0ucFtC8EVHS7gwrTmTNzGw@mail.gmail.com>
Date: Thu, 30 Jun 2016 14:06:03 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvm33wgc.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Olof Johansson <olof@lixom.net> writes:

> Hi,
>
> On Wed, Jun 29, 2016 at 1:06 PM, Darren Stevens <darren@stevens-zone.net> wrote:
>>
>>     Commit:d6a9996e84ac4beb7713e9485f4563e100a9b03e (powerpc/mm:
>>     vmalloc abstraction in preparation for radix) turned kernel memory
>>     and IO addresses from #defined constants to variables initialised
>>     at runtime.
>>
>>     On PA6T systems the setup_arch machine call initialises the onboard
>>     PCI-e root-ports, and uses pci_io_base to do this, which is now before
>>     its value has been set resulting in a panic right after 'booting
>>     linux via __start()'
>
> I don't see the panic here on a Chitra, at least not on recent -next.
>
> What config are you building with when you see this?
>
> Please cc me on PA Semi related patches if you want my attention. I
> still have hardware, in fact I boot every -next release on it through
> automation.
>

You can find more details in the below thread.

https://lkml.kernel.org/r/8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de


-aneesh
