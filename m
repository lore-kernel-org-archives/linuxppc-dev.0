Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C59001A02C3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Nov 2014 06:50:33 +1100 (AEDT)
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 3EF421400F1
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2014 06:50:32 +1100 (AEDT)
Date: Fri, 07 Nov 2014 14:50:26 -0500 (EST)
Message-Id: <20141107.145026.945264099310112541.davem@davemloft.net>
To: kda@linux-powerpc.org
Subject: Re: [PATCH net-next] PPC: bpf_jit_comp: add SKF_AD_HATYPE instruction
From: David Miller <davem@davemloft.net>
In-Reply-To: <1415253755-4001-1-git-send-email-kda@linux-powerpc.org>
References: <1415253755-4001-1-git-send-email-kda@linux-powerpc.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: felix@linux.vnet.ibm.com, netdev@vger.kernel.org, dborkman@redhat.com,
 alexei.starovoitov@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Thu,  6 Nov 2014 09:02:35 +0300

> Add BPF extension SKF_AD_HATYPE to ppc JIT to check
> the hw type of the interface
> 
> JIT off:
> [   69.106783] test_bpf: #20 LD_HATYPE 48 48 PASS
> JIT on:
> [   64.721757] test_bpf: #20 LD_HATYPE 7 6 PASS
> 
> CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
> CC: Daniel Borkmann<dborkman@redhat.com>
> CC: Philippe Bergheaud<felix@linux.vnet.ibm.com>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Can I get some reviews please?

Thanks.
