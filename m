Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4114rn4sHJzF2vk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 20:38:16 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w56AYEUa141127
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2018 06:38:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jebgpf4ym-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2018 06:38:13 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 6 Jun 2018 11:38:11 +0100
Date: Wed, 06 Jun 2018 16:08:04 +0530
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
 <1527793526.g9zv2oo8k4.naveen@linux.ibm.com>
In-Reply-To: <1527793526.g9zv2oo8k4.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1528280140.q9nkfry2ll.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Naveen N. Rao wrote:
> Michael Ellerman wrote:
>>=20
>> I guess if it doesn't already apply to tip you should rebase it. You've
>> probably missed 4.18 anyway.
>=20
> Oh ok. I just tried and it seems to apply just fine. I'll post v2 after=20
> giving this a quick test.

I didn't post a v2 since I have decided against using this approach. The=20
reason for that is Masami's series to remove jprobes. The discussion=20
there reminded me that we can't easily override functions with kprobes=20
on powerpc. Though it works for this particular scenario, we would just=20
be setting a bad example.

As such, I won't be changing generic code, but will simply make the=20
necessary changes in powerpc code.

Sorry for the noise.

- Naveen

=
