Return-Path: <prvs=3903de43b8=ast@fb.com>
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfYRV3hJJzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 01:58:14 +1000 (AEST)
Subject: Re: [PATCH net 1/4] lib/test_bpf: Fix JMP_JSET tests
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>
References: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <5703E06C.5060907@fb.com>
Date: Tue, 5 Apr 2016 08:57:32 -0700
MIME-Version: 1.0
In-Reply-To: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/5/16 3:02 AM, Naveen N. Rao wrote:
> JMP_JSET tests incorrectly used BPF_JNE. Fix the same.
>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Good catch.
Fixes: cffc642d93f9 ("test_bpf: add 173 new testcases for eBPF")
Acked-by: Alexei Starovoitov <ast@kernel.org>
