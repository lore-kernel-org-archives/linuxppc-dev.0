Return-Path: <prvs=3898f00e9f=ast@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbZC83cLjzDq71
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 06:22:12 +1100 (AEDT)
Subject: Re: [PATCH 1/4] samples/bpf: Fix build breakage with
 map_perf_test_user.c
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <56FD61B6.9000102@fb.com> <20160331184602.GC17907@naverao1-tp.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, "David S
 . Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Borkmann
 <daniel@iogearbox.net>, <netdev@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <56FD782B.1020005@fb.com>
Date: Thu, 31 Mar 2016 12:19:07 -0700
MIME-Version: 1.0
In-Reply-To: <20160331184602.GC17907@naverao1-tp.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/31/16 11:46 AM, Naveen N. Rao wrote:
>> It's failing this way on powerpc? Odd.
> This fails for me on x86_64 too -- RHEL 7.1.

indeed. fails on centos 7.1, whereas centos 6.7 is fine.
