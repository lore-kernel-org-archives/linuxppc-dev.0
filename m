Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
 [209.85.220.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sh1yF3j4JzDrLQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 17:27:01 +1000 (AEST)
Received: by mail-pa0-f66.google.com with SMTP id i5so2865044pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 00:27:01 -0700 (PDT)
Date: Sat, 24 Sep 2016 03:25:56 -0400
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Alexei Starovoitov <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 1/2] bpf samples: fix compiler errors with sockex2 and
 sockex3
Message-ID: <20160924072524.GA48029@ast-mbp>
References: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 24, 2016 at 02:10:04AM +0530, Naveen N. Rao wrote:
> These samples fail to compile as 'struct flow_keys' conflicts with
> definition in net/flow_dissector.h. Fix the same by renaming the
> structure used in the sample.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks for the fix.
Acked-by: Alexei Starovoitov <ast@kernel.org>
