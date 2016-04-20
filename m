Return-Path: <acme@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqj8102TVzDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 23:16:32 +1000 (AEST)
Date: Wed, 20 Apr 2016 10:16:33 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, jolsa@redhat.com, dsahern@gmail.com,
 sukadev@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com, acme@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11 0/4]perf/powerpc: Add ability to sample intr machine
 state in powerpc
Message-ID: <20160420131633.GI2527@redhat.com>
References: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
 <5714AD1F.9020807@linux.vnet.ibm.com>
 <20160420035754.GH2527@redhat.com>
 <1461128158.13404.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461128158.13404.3.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Apr 20, 2016 at 02:55:58PM +1000, Michael Ellerman escreveu:
> On Wed, 2016-04-20 at 00:57 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Apr 18, 2016 at 03:17:11PM +0530, Anju T escreveu:
> > > On Saturday 20 February 2016 10:32 AM, Anju T wrote:
> > > >  tools/perf/arch/powerpc/include/perf_regs.h | 69 ++++++++++++++++++++++
> > > >  tools/perf/arch/powerpc/util/Build          |  1 +
> > > >  tools/perf/arch/powerpc/util/perf_regs.c    | 49 ++++++++++++++++
> > > >  tools/perf/config/Makefile                  |  5 ++
> > > >  create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h
> > > >  create mode 100644 tools/perf/arch/powerpc/util/perf_regs.c

> > > Can this be taken into the next tree?

> > Even the bits in tools/perf/ are arch specific, so I guess this goes via
> > the powerpc tree? Michael?

> Yeah if that's OK with you.
> 
> It doesn't look like it will generate much in the way of merge conflicts.
> 
> Do you want to send an ack?

For the tools/perf/ bits:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
