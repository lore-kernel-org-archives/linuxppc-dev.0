Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9dYY3cMyzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 22:38:57 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99BciQ1040143
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 07:38:55 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dg3jd5nnk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 07:38:54 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 05:38:54 -0600
Subject: Re: linux-4.14-rc3/arch/powerpc/perf/imc-pmu.c:599: pointless test ?
To: Michael Ellerman <mpe@ellerman.id.au>,
 David Binderman <dcb314@hotmail.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HE1PR0802MB23316FCA14FD1F8E51FCAB059C710@HE1PR0802MB2331.eurprd08.prod.outlook.com>
 <87fuasewxv.fsf@concordia.ellerman.id.au>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 17:08:47 +0530
MIME-Version: 1.0
In-Reply-To: <87fuasewxv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d6d7ee9b-9c8e-5d1c-d60e-c92457a4cd44@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,


On Monday 09 October 2017 10:31 AM, Michael Ellerman wrote:
> David Binderman <dcb314@hotmail.com> writes:
>> Hello there,
>>
>> linux-4.14-rc3/arch/powerpc/perf/imc-pmu.c:599]: (style) Unsigned variable 'ncpu' can't be negative so it is unnecessary to test it.
>>
>> Source code is
>>
>>      if (ncpu >= 0 && ncpu < nr_cpu_ids) {
>>
>> but
>>
>>      unsigned int ncpu, core_id;
>>
>> Suggest remove test.

Nice catch. Thanks for mentioning this. I will fix this.

Thanks,
Anju
> Thanks.
>
> Notifying the author would be more helpful:
>
> $ git blame -L 599,599 arch/powerpc/perf/imc-pmu.c
> 39a846db1d574 (Anju T Sudhakar 2017-07-19 03:06:35 +0530 599)   if (ncpu >= 0 && ncpu < nr_cpu_ids) {
> $ git log -1 --format=%ae 39a846db1d574
> anju@linux.vnet.ibm.com
>
> cheers
>
