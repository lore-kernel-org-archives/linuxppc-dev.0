Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 93F7C1A119D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 23:19:46 +1100 (AEDT)
Date: Thu, 17 Dec 2015 09:19:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: "Wangnan (F)" <wangnan0@huawei.com>, jolsa@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20151217121939.GH19926@kernel.org>
References: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
 <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
 <20151215114046.GG23726@naverao1-tp.in.ibm.com>
 <20151216194234.GA19926@kernel.org> <56720FFB.5060407@huawei.com>
 <20151217050714.GB21524@naverao1-tp.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151217050714.GB21524@naverao1-tp.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Dec 17, 2015 at 10:37:14AM +0530, Naveen N. Rao escreveu:
> On 2015/12/17 09:29AM, Wang Nan wrote:
> > The whole thread is:
> > 
> > [PATCH v3 0/3] perf build: PowerPC: Fix build breakage due to libbpf:
> > http://lkml.kernel.org/g/1450150557-127942-1-git-send-email-wangnan0@huawei.com
> > 
> > [PATCH v3 1/3] perf tools: Fix PowerPC native building
> > http://lkml.kernel.org/g/1450150557-127942-2-git-send-email-wangnan0@huawei.com
> > 
> > [PATCH v3 2/3] tools: Move Makefile.arch from perf/config to tools/scripts
> > http://lkml.kernel.org/g/1450150557-127942-3-git-send-email-wangnan0@huawei.com
> > 
> > [PATCH v3 3/3] perf: bpf: Fix build breakage due to libbpf
> > http://lkml.kernel.org/g/1450150557-127942-4-git-send-email-wangnan0@huawei.com
> > 
> > and [PATCH v3 3/3] breaks local building because the usage of "srctree", and
	     ^^
> You mean v4 here.

> Anyway, now that you've sent v4, it should be much clearer.

Right, I should've read it more thoroughly, but anyway, I'll process it
today.

- Arnaldo
