Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB7101A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 11:05:40 +1100 (AEDT)
Message-ID: <1444262740.31685.0.camel@ellerman.id.au>
Subject: Re: [GIT PULL 0/1] perf/urgent fix
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org,  Stephane Eranian <eranian@google.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linuxppc-dev@ozlabs.org, Jiri
 Olsa <jolsa@kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.vnet.ibm.com>,  Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>
Date: Thu, 08 Oct 2015 11:05:40 +1100
In-Reply-To: <20151007163348.GA10371@gmail.com>
References: <1444232523-20638-1-git-send-email-acme@kernel.org>
 <20151007163348.GA10371@gmail.com>
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

On Wed, 2015-10-07 at 18:33 +0200, Ingo Molnar wrote:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > ----------------------------------------------------------------
> > perf/urgent fix:
> > 
> > - Fix build break on (at least) powerpc due to sample_reg_masks, not being
> >   available for linking (Sukadev Bhattiprolu)
> > 
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Sukadev Bhattiprolu (1):
> >       perf tools: Fix build break on powerpc due to sample_reg_masks
> 
> Pulled, thanks Arnaldo!

Thanks guys.

cheers
