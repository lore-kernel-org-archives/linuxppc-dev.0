Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xNY96bQ5zDrYj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 20:11:57 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4VAAXbw125285
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 06:11:55 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jaekps83y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 06:11:54 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 31 May 2018 11:11:53 +0100
Date: Thu, 31 May 2018 15:41:48 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: Add support for function error injection
To: Josef Bacik <jbacik@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <87h8mozajv.fsf@concordia.ellerman.id.au>
In-Reply-To: <87h8mozajv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1527761352.z5jz8jg2d5.naveen@linux.ibm.com>
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
>> ...
>=20
> A change log is always nice even if it's short :)

I tried, but really couldn't come up with anything more to write. I'll=20
try harder for v2 :)

>=20
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/Kconfig                       | 1 +
>>  arch/powerpc/include/asm/error-injection.h | 9 +++++++++
>>  arch/powerpc/include/asm/ptrace.h          | 5 +++++
>>  3 files changed, 15 insertions(+)
>>  create mode 100644 arch/powerpc/include/asm/error-injection.h
>=20
> This looks fine to me, it's probably easiest if it goes in via tip along
> with patch 1.
>=20
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for the review. I'll base v2 on -tip


- Naveen

=
