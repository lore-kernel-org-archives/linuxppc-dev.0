Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKf534q9zDqpx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:41:17 +1000 (AEST)
Message-ID: <1461246071.28585.0.camel@ellerman.id.au>
Subject: Re: [PATCH V11 0/4]perf/powerpc: Add ability to sample intr machine
 state in powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, jolsa@redhat.com, dsahern@gmail.com,
 sukadev@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com, acme@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Thu, 21 Apr 2016 23:41:11 +1000
In-Reply-To: <20160420131633.GI2527@redhat.com>
References: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
 <5714AD1F.9020807@linux.vnet.ibm.com> <20160420035754.GH2527@redhat.com>
 <1461128158.13404.3.camel@ellerman.id.au>
 <20160420131633.GI2527@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-20 at 10:16 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 20, 2016 at 02:55:58PM +1000, Michael Ellerman escreveu:
> > On Wed, 2016-04-20 at 00:57 -0300, Arnaldo Carvalho de Melo wrote:
> > > Even the bits in tools/perf/ are arch specific, so I guess this goes via
> > > the powerpc tree? Michael?
> >
> > Yeah if that's OK with you.
> >
> > It doesn't look like it will generate much in the way of merge conflicts.
> >
> > Do you want to send an ack?
>
> For the tools/perf/ bits:
>
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks.

cheers
