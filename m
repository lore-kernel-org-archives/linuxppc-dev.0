Return-Path: <alexei.starovoitov@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 105E21A0001
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 04:08:08 +1100 (AEDT)
MIME-Version: 1.0
In-Reply-To: <CAOJe8K0t3G-bHm_24GjrTp9mmKnYZS1_bdGgrwQBLjC_s5is6w@mail.gmail.com>
References: <1414351406-4122-1-git-send-email-kda@linux-powerpc.org>
 <CAOJe8K0t3G-bHm_24GjrTp9mmKnYZS1_bdGgrwQBLjC_s5is6w@mail.gmail.com>
Date: Wed, 29 Oct 2014 10:08:04 -0700
Message-ID: <CAADnVQLmW1var8ebSJJYhmBXCuFbRwX01KXjrnKxyUz1cqFXmA@mail.gmail.com>
Subject: Re: [PATCH] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Matt Evans <matt@ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2014 at 2:21 AM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> Any feedback from PPC folks?

not a ppc guy, but looks reasonable to me.
What lib/test_bpf says? Like performance difference before/after
for LD_PKTTYPE test...
