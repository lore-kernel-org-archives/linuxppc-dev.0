Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xcQf18sGzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 05:07:05 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4VJ4K9Q111158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 15:07:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jaj6ucxuq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 15:07:02 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 31 May 2018 20:07:00 +0100
Date: Fri, 01 Jun 2018 00:36:54 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: Add support for function error injection
To: Josef Bacik <jbacik@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <87h8mozajv.fsf@concordia.ellerman.id.au>
 <1527761352.z5jz8jg2d5.naveen@linux.ibm.com>
 <87zi0fyktj.fsf@concordia.ellerman.id.au>
In-Reply-To: <87zi0fyktj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1527793526.g9zv2oo8k4.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>=20
>> Michael Ellerman wrote:
>>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>>> ...
>>>=20
>>> A change log is always nice even if it's short :)
>>
>> I tried, but really couldn't come up with anything more to write. I'll=20
>> try harder for v2 :)
>=20
> Yeah true.
>=20
> You could just say "All that's required is to define x and y and select
> the Kconfig symbol".

Ok, sure.

>=20
>>> This looks fine to me, it's probably easiest if it goes in via tip alon=
g
>>> with patch 1.
>>>=20
>>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> Thanks for the review. I'll base v2 on -tip
>=20
> I guess if it doesn't already apply to tip you should rebase it. You've
> probably missed 4.18 anyway.

Oh ok. I just tried and it seems to apply just fine. I'll post v2 after=20
giving this a quick test.

- Naveen

=
