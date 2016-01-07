Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B46CD1A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 17:58:58 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 7 Jan 2016 12:28:55 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 300F7E0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 12:30:05 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u076whRf39125066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jan 2016 12:28:44 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u076wfXL016132
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jan 2016 12:28:43 +0530
Date: Thu, 7 Jan 2016 12:28:15 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Wangnan (F)" <wangnan0@huawei.com>, jolsa@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20160107065709.GA2459@naverao1-tp.ibm.com>
References: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
 <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
 <20151215114046.GG23726@naverao1-tp.in.ibm.com>
 <20151216194234.GA19926@kernel.org> <56720FFB.5060407@huawei.com>
 <20151217050714.GB21524@naverao1-tp.ibm.com>
 <20151217121939.GH19926@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151217121939.GH19926@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/12/17 09:19AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 17, 2015 at 10:37:14AM +0530, Naveen N. Rao escreveu:
> > On 2015/12/17 09:29AM, Wang Nan wrote:
> > > The whole thread is:
> > > 
> > > [PATCH v3 0/3] perf build: PowerPC: Fix build breakage due to libbpf:
> > > http://lkml.kernel.org/g/1450150557-127942-1-git-send-email-wangnan0@huawei.com
> > > 
> > > [PATCH v3 1/3] perf tools: Fix PowerPC native building
> > > http://lkml.kernel.org/g/1450150557-127942-2-git-send-email-wangnan0@huawei.com
> > > 
> > > [PATCH v3 2/3] tools: Move Makefile.arch from perf/config to tools/scripts
> > > http://lkml.kernel.org/g/1450150557-127942-3-git-send-email-wangnan0@huawei.com
> > > 
> > > [PATCH v3 3/3] perf: bpf: Fix build breakage due to libbpf
> > > http://lkml.kernel.org/g/1450150557-127942-4-git-send-email-wangnan0@huawei.com
> > > 
> > > and [PATCH v3 3/3] breaks local building because the usage of "srctree", and
> 	     ^^
> > You mean v4 here.
> 
> > Anyway, now that you've sent v4, it should be much clearer.
> 
> Right, I should've read it more thoroughly, but anyway, I'll process it
> today.

Bump.

Arnaldo,
Can you please push at least the initial 3 patches of this for v4.4?  
Wang Nan has posted v6 here:
http://thread.gmane.org/gmane.linux.kernel/2110626


Thanks,
Naveen
