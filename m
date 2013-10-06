Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68DA72C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Oct 2013 03:56:37 +1100 (EST)
Received: by mail-pa0-f43.google.com with SMTP id hz1so6294846pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Oct 2013 09:56:34 -0700 (PDT)
Message-ID: <1381078592.12191.0.camel@edumazet-glaptop.roam.corp.google.com>
Subject: Re: [PATCH v4 net-next] fix unsafe set_memory_rw from softirq
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Alexei Starovoitov <ast@plumgrid.com>
Date: Sun, 06 Oct 2013 09:56:32 -0700
In-Reply-To: <1380870846-3357-1-git-send-email-ast@plumgrid.com>
References: <1380870846-3357-1-git-send-email-ast@plumgrid.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <dborkman@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-10-04 at 00:14 -0700, Alexei Starovoitov wrote:
> on x86 system with net.core.bpf_jit_enable = 1

> cannot reuse jited filter memory, since it's readonly,
> so use original bpf insns memory to hold work_struct
> 
> defer kfree of sk_filter until jit completed freeing
> 
> tested on x86_64 and i386
> 
> Signed-off-by: Alexei Starovoitov <ast@plumgrid.com>

Acked-by: Eric Dumazet <edumazet@google.com>
