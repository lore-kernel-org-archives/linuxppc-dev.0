Return-Path: <jakub.kicinski@netronome.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s0k22klQzF1LJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 17:04:26 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id t12-v6so470267plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 00:04:26 -0700 (PDT)
Date: Thu, 24 May 2018 00:04:21 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH bpf-next v4 10/10] tools: bpftool: add delimiters to
 multi-function JITed dumps
Message-ID: <20180524000421.3def372c@cakuba>
In-Reply-To: <477bc3286831947c2eb774e8787f72680cf378cf.1527143877.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
 <477bc3286831947c2eb774e8787f72680cf378cf.1527143877.git.sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 24 May 2018 12:26:54 +0530, Sandipan Das wrote:
> This splits up the contiguous JITed dump obtained via the bpf
> system call into more relatable chunks for each function in
> the program. If the kernel symbols corresponding to these are
> known, they are printed in the header for each JIT image dump
> otherwise the masked start address is printed.

...
 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thank you!
