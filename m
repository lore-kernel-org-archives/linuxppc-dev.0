Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA25F1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 19:05:21 +1100 (AEDT)
Date: Tue, 15 Dec 2015 09:05:17 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Wang Nan <wangnan0@huawei.com>
Cc: naveen.n.rao@linux.vnet.ibm.com, acme@kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/3] perf build: PowerPC: Fix build breakage due to
 libbpf
Message-ID: <20151215080517.GB16565@krava.brq.redhat.com>
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 15, 2015 at 03:35:54AM +0000, Wang Nan wrote:
> Hi Naveen,
> 
>    Now I know your problem is in native building and the reason is
> missing proper $(ARCH). I think other than that there's another problem
> in libbpf's building: if your problem is unable to compile libbpf,
> feature checker should find it and set NO_LIBBPF=1 for perf, so perf
> building won't be blocked, only BPF related features should be turned
> off. Also, I think including Makefile.arch from tools/scripts would be
> better, because libbpf is at the same level with perf. So I separate
> them into 3 patches. Please help me test it on PowerPC.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> Naveen N. Rao (1):
>   perf: bpf: Fix build breakage due to libbpf
> 
> Wang Nan (2):
>   perf tools: Fix PowerPC native building
>   tools: Move Makefile.arch from perf/config to tools/scripts

for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
