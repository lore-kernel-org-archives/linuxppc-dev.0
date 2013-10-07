Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 064732C011C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 06:17:28 +1100 (EST)
Date: Mon, 07 Oct 2013 15:17:23 -0400 (EDT)
Message-Id: <20131007.151723.1874328502711969492.davem@davemloft.net>
To: eric.dumazet@gmail.com
Subject: Re: [PATCH v4 net-next] fix unsafe set_memory_rw from softirq
From: David Miller <davem@davemloft.net>
In-Reply-To: <1381078592.12191.0.camel@edumazet-glaptop.roam.corp.google.com>
References: <1380870846-3357-1-git-send-email-ast@plumgrid.com>
 <1381078592.12191.0.camel@edumazet-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 heiko.carstens@de.ibm.com, edumazet@google.com, dborkman@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 ast@plumgrid.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Sun, 06 Oct 2013 09:56:32 -0700

> On Fri, 2013-10-04 at 00:14 -0700, Alexei Starovoitov wrote:
>> on x86 system with net.core.bpf_jit_enable = 1
> 
>> cannot reuse jited filter memory, since it's readonly,
>> so use original bpf insns memory to hold work_struct
>> 
>> defer kfree of sk_filter until jit completed freeing
>> 
>> tested on x86_64 and i386
>> 
>> Signed-off-by: Alexei Starovoitov <ast@plumgrid.com>
> 
> Acked-by: Eric Dumazet <edumazet@google.com>

I've decided to apply this to 'net', thanks.
