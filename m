Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gbZD1CDfzF1Cq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 00:40:19 +1000 (AEST)
Date: Wed, 1 Aug 2018 11:40:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf tools: allow overriding MAX_NR_CPUS at compile time
Message-ID: <20180801144011.GA16449@kernel.org>
References: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
 <20180503134037.GB8442@kernel.org>
 <dc8f1911-fa9a-c1c8-0dd5-fd33236da69a@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <dc8f1911-fa9a-c1c8-0dd5-fd33236da69a@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Aug 01, 2018 at 11:37:30AM +0200, Christophe LEROY escreveu:
> 
> 
> Le 03/05/2018 à 15:40, Arnaldo Carvalho de Melo a écrit :
> > Em Fri, Sep 22, 2017 at 01:20:43PM +0200, Christophe Leroy escreveu:
> > > After update of kernel, perf tool doesn't run anymore on my
> > > 32MB RAM powerpc board, but still runs on a 128MB RAM board:
> > 
> > Cleaning up my inbox, found this one, simple enough, still applies,
> > applied.
> 
> Did you finally apply it ? I can't see it in linux-next. Will it be merged
> into 4.19 ?

Sure, applied it finally, 

- Arnaldo
